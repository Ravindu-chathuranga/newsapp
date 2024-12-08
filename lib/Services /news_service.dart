import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '3e748210ff3c4f38a41408c7b5f664f7';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchNews(String country) async {
    final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=$country&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<dynamic>> fetchCategoryNews(String category) async {
    final response = await http.get(
        Uri.parse('$baseUrl/top-headlines?category=$category&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
