import 'package:dio/dio.dart';
import 'package:eid_moo/shared/components/em_dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EMFetchException implements Exception {
  final String message;

  const EMFetchException(this.message);
}

class EMFetch {
  final String url;
  final EMFetchMethod method;
  final Object? body;
  final Map<String, dynamic>? queryParameters;
  final Function(int? sent, int? total)? onSendProgress;

  EMFetch(
    this.url, {
    required this.method,
    this.body,
    this.onSendProgress,
    this.queryParameters,
  });

  Future<dynamic> authorizedRequest() async {
    final umDio = DioFactory().getDio();

    final storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');

    final response = await umDio.request(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        method: method.name,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode != 200) {
      if (response.data.runtimeType == String) {
        throw EMFetchException(
          response.data ?? 'Something went wrong. Please try again later.',
        );
      } else {
        throw EMFetchException(
          response.data['message'] ??
              'Something went wrong. Please try again later.',
        );
      }
    }

    return response.data;
  }

  Future<dynamic> request() async {
    final agDio = DioFactory().getDio();

    final response = await agDio.request(
      url,
      data: body,
      options: Options(
        method: method.name,
      ),
      onSendProgress: onSendProgress,
    );

    if (response.statusCode != 200) {
      print(response);
      print(response.data.runtimeType);

      if (response.data.runtimeType == String) {
        print('here');
        throw EMFetchException(
          response.data ?? 'Something went wrong. Please try again later.',
        );
      } else {
        throw EMFetchException(
          response.data['message'] ??
              'Something went wrong. Please try again later.',
        );
      }
    }

    return response.data;
  }
}

enum EMFetchMethod {
  GET,
  POST,
  PUT,
  DELETE,
}