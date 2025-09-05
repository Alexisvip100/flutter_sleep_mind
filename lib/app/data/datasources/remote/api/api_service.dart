import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({
    required this.baseUrl,
    required this.client,
  });

  Future<Map<String, dynamic>> postUserData({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: jsonEncode(data),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ApiException(
          'Error ${response.statusCode}: ${response.body}',
          response.statusCode,
        );
      }
    } catch (e) {
      throw ApiException('Network error: $e', 0);
    }
  }

  Future<Map<String, dynamic>> getAllPost({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      try {
        final response = await client.get(
          Uri.parse('$baseUrl$endpoint'),
          headers: {'Content-Type': 'application/json', ...?headers},
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          return jsonDecode(response.body) as Map<String, dynamic>;
        } else {
          throw ApiException(
            'Error ${response.statusCode}: ${response.body}',
            response.statusCode,
          );
        }
      } catch (e) {
        throw ApiException('Network error: $e', 0);
      }
    } catch (e) {
      throw ApiException('Network error: $e', 0);
    }
  }

  Future<Map<String, dynamic>> getUserData({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw ApiException(
          'Error ${response.statusCode}: ${response.body}',
          response.statusCode,
        );
      }
    } catch (e) {
      throw ApiException('Network error: $e', 0);
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
