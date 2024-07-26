import 'dart:convert';
import 'dart:io';

import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/core/errors/errors.dart';
import 'package:bareekmedia/core/logger.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  final Configuration config;
  final Map<String, String> generalHeaders;

  NetworkClient({
    required this.config,
    this.generalHeaders = const {},
  });

  Future<http.Response> post({
    required String url,
    required String body,
    Map<String, String> query = const {},
  }) async =>
      await _sendIfConnected<http.Response>(
        () async {
          Map<String, String> allQueryParams = {};

          allQueryParams.addAll(query);
          var finalUrl = Uri.parse("${config.baseUrl}/$url")
              .replace(queryParameters: allQueryParams);

          Log.d("Posting To: $finalUrl"
              "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(generalHeaders)}");

          http.Response result = await http.post(
            finalUrl,
            headers: generalHeaders,
            body: body,
          );

          Log.d("Response code: ${result.statusCode}"
              "\nResponse headers: ${result.headers}"
              "\nResponse body: ${result.body}");
          return result;
        },
      );

  Future<http.Response> get({
    String url = "",
    Map<String, String> query = const {},
  }) async =>
      await _sendIfConnected<http.Response>(
        () async {
          Map<String, String> allQueryParams = {};

          allQueryParams.addAll(query);
          var finalUrl = Uri.parse("${config.baseUrl}/$url")
              .replace(queryParameters: allQueryParams);

          Log.d("Getting From: $finalUrl"
              "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(generalHeaders)}");

          var result = await http.get(
            finalUrl,
            headers: generalHeaders,
          );

          Log.d("Response code: ${result.statusCode}"
              "\nResponse body: ${result.body}");
          return result;
        },
      );

  Future<http.Response> put({
    required String url,
    required String body,
  }) async =>
      await _sendIfConnected<http.Response>(
        () async {
          var finalUrl = Uri.parse(config.baseUrl);

          Log.d("Putting To: $finalUrl"
              "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(generalHeaders)}"
              "\nRequest body: $body");

          var result = await http.put(
            finalUrl,
            headers: generalHeaders,
            body: body,
          );

          Log.d("Response code: ${result.statusCode}"
              "\nResponse headers: ${result.headers}"
              "\nResponse body: ${result.body}");

          return result;
        },
      );

  Future<T> _sendIfConnected<T>(Future<T> Function() fun) async {
    final result = await InternetAddress.lookup('www.google.com');

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return await fun.call();
    } else {
      Log.e("################ No Internet Connection ################");
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }
}
