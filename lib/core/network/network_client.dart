import 'dart:convert';

import 'package:bareekmedia/core/errors/errors.dart';
import 'package:bareekmedia/core/logger.dart';
import 'package:bareekmedia/core/network/network_config.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  final NetworkConfig config;

  NetworkClient({required this.config});

  Future<http.Response> post({
    required String url,
    required String body,
    Map<String, String> query = const {},
  }) async {
    if (await config.isConnected()) {
      Map<String, String> allQueryParams = {};
      // allQueryParams.addAll({"apikey": Secrets.apiKey});
      allQueryParams.addAll(query);
      var finalUrl = Uri.parse("${config.getBaseUrl()}/$url")
          .replace(queryParameters: allQueryParams);
      var headers = config.getHeaders();
      Log.d("Posting To: $finalUrl"
          "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(headers)}");
      http.Response result = await http.post(
        finalUrl,
        headers: config.getHeaders(),
        body: body,
      );
      Log.d("Response code: ${result.statusCode}"
          "\nResponse headers: ${result.headers}"
          "\nResponse body: ${result.body}");
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }

  Future<http.Response> get({
    String url = "",
    Map<String, String> query = const {},
  }) async {
    if (await config.isConnected()) {
      Map<String, String> allQueryParams = {};
      // allQueryParams.addAll({"apikey": Secrets.apiKey});
      allQueryParams.addAll(query);
      var finalUrl = Uri.parse("${config.getBaseUrl()}/$url")
          .replace(queryParameters: allQueryParams);
      var headers = config.getHeaders();
      Log.d("Getting From: $finalUrl"
          "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(headers)}");
      var result = await http.get(
        finalUrl,
        headers: headers,
      );
      Log.d("Response code: ${result.statusCode}"
          "\nResponse body: ${result.body}");
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }

  Future<http.Response> put({
    required String url,
    required String body,
  }) async {
    if (await config.isConnected()) {
      var finalUrl = Uri.parse("${config.getBaseUrl()}");

      ///?&apikey=${Secrets.apiKey}$url");
      var headers = config.getHeaders();
      Log.d("Putting To: $finalUrl"
          "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(headers)}"
          "\nRequest body: $body");
      var result = await http.put(
        finalUrl,
        headers: headers,
        body: body,
      );

      Log.d("Response code: ${result.statusCode}"
          "\nResponse headers: ${result.headers}"
          "\nResponse body: ${result.body}");
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }
}
