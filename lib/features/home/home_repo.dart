import 'dart:io';

import 'package:bareekmedia/core/cache/session_cache_manager.dart';
import 'package:bareekmedia/core/dependency_registrar/dependencies.dart';
import 'package:bareekmedia/features/base_repo.dart';
import 'package:bareekmedia/models/movie_model.dart';
import 'package:dartz/dartz.dart';

class HomeRepo extends BaseRepo {
  final SessionCacheManager<MovieListModel> _movieListCache = sl();

  /// sample on how a BE request can be made, and handled.
  Future<Either<FailureModel, List<MovieModel>>> searchMovies(
    String keyword, {
    int? searchPage,
  }) =>
      ErrorHandler.handleFuture<List<MovieModel>>(
        () async {
          if (!_movieListCache.contains(keyword)) {
            var result = await client.get(query: {
              "s": keyword.replaceAll(" ", "+"),
              "page": searchPage.toString(),
            });
            if (result.statusCode != HttpStatus.ok) {
              throw ErrorHandler.httpResponseException(result);
            } else {
              var resp = MovieListModel.fromRawJson(result.body);
              //the api returns 200 with a false response if there is an error
              if (resp.response != "True") {
                throw NotFoundException(message: resp.error);
              }
              _movieListCache.set(keyword, resp);
              return Right(resp.movies);
            }
          } else {
            return Right(
                (_movieListCache.get(keyword) ?? MovieListModel.empty())
                    .movies);
          }
        },
      );
}
