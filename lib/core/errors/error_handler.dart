import 'dart:io';

import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/core/dependency_registrar/dependencies.dart';
import 'package:bareekmedia/core/errors/errors.dart';
import 'package:bareekmedia/core/errors/failure_model.dart';
import 'package:bareekmedia/core/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class ErrorHandler {
  /// handles all exceptions that may happen when making a request
  static Future<Either<FailureModel, T>> handleFuture<T>(
    Future<Either<FailureModel, T>> Function() func,
  ) async {
    try {
      return await func.call();
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    } on FailureModel catch (f) {
      Log.e(f.toString());
      return Left(f);
    } on Error catch (e) {
      Log.e(e);
      return Left(
        FailureModel(
          hasError: true,
          message: e.toString(),
        ),
      );
    } catch (e) {
      Log.e(e);
      return Left(
        FailureModel(
          hasError: true,
          message: e.toString(),
        ),
      );
    }
  }

  /// Checks for specific codes that require special attention
  /// Then handles the rest based on the HTTP Code level
  static Exception httpResponseException(
    Response response, {
    bool handleClientErrors = true,
    bool handleServerErrors = true,
  }) =>
      switch (response.statusCode) {
        (HttpStatus.forbidden) => UnauthorizedException(message: response.body),
        (HttpStatus.notFound) => NotFoundException(message: response.body),
        (_)
            when (handleClientErrors &&
                response.statusCode >= 400 &&
                response.statusCode < 500) =>
          ClientErrorException(
            statusCode: response.statusCode,
            body: response.body,
          ),
        (_) when (handleServerErrors && response.statusCode >= 500) =>
          ServerErrorException(
            statusCode: response.statusCode,
            body: response.body,
          ),
        (_) => Exception(
            "UnhandledNetworkException \n\tCode: "
            "${response.statusCode} \n\tbody: ${response.body}",
          ),
      };

  /// maps possible exceptions to be shown in the form of a failure message
  static FailureModel _mapExceptionToFailure(Exception exception) {
    Log.e(exception);
    return switch (exception.runtimeType) {
      (const (NoInternetException)) =>
        FailureModel(message: (exception as NoInternetException).message),
      (const (UnauthorizedException)) =>
        FailureModel(message: (exception as UnauthorizedException).message),
      (const (NotFoundException)) =>
        FailureModel(message: (exception as NotFoundException).message),
      (const (ServerErrorException)) =>
        FailureModel(message: (exception as ServerErrorException).body),
      (const (ClientErrorException)) =>
        FailureModel(message: (exception as ClientErrorException).body),
      (const (FormatException)) =>
        FailureModel(message: (exception as FormatException).message),
      (const (ClientException)) =>
        FailureModel(message: (exception as ClientException).message),
      (_) => FailureModel(
          message: sl<Configuration>().defaultErrorMessage,
        ),
    };
  }
}
