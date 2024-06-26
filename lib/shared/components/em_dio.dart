import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eid_moo/shared/utils/constants/em_contants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// final agDio = Dio(
//   BaseOptions(
//     baseUrl: '${Constants.protocol}://${Constants.domain}',
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     validateStatus: (status) {
//       return true;
//     },
//   ),
// );

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String BASE_URL = "${Constants.protocol}://${Constants.domain}";

class DioFactory {
  Dio getDio() {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      "ngrok-skip-browser-warning": "69420",
    };

    dio.options = BaseOptions(
      baseUrl: BASE_URL,
      headers: headers,
      validateStatus: (status) {
        return true;
      },
      sendTimeout: Duration(seconds: 240),
      connectTimeout: Duration(seconds: 240),
    );

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(
          context: SecurityContext(withTrustedRoots: false),
        );

        client.badCertificateCallback = (cert, host, port) {
          if (host == Constants.domain) {
            return true;
          } else {
            return false;
          }
        };

        return client;
      },
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}