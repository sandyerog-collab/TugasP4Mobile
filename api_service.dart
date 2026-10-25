import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas4/article_model.dart';

class ApiService{
  Future<List<Article>> fetchArticles() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=apple&from=2026-10-18&to=2026-10-18&sortBy=popularity&apiKey=589f26cc01f64da786167d1f79fac595',
    );

    try {
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 20));

      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 &&
          data['status'] == 'ok') {
        final List<dynamic> articlesJson =
            data['articles'] as List<dynamic>;

        return articlesJson
            .whereType<Map<String, dynamic>>()
            .map((json) => Article.fromJson(json))
            .toList();
      }

      final message =
          data['message'] ?? 'Gagal mengambil berita';

      throw Exception(
        'NewsAPI (${response.statusCode}): $message',
      );
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Terjadi kesalahan saat memuat berita: $e');
    }
  }
}