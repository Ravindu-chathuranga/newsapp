import 'package:flutter/material.dart';
import 'package:weathe_news_app/models/artical_model.dart';
import 'package:weathe_news_app/Services /news_service.dart';
import 'article_details_screen.dart';
import 'category_screen.dart';
import 'search_screen.dart';
// import 'video_screen.dart';
// import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService newsService = NewsService();
  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final data = await newsService.fetchNews('us');
    setState(() {
      articles = data.map((json) => Article.fromJson(json)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SearchScreen(articles: articles)),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  leading: Image.network(article.urlToImage, fit: BoxFit.cover),
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailsScreen(article: article),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.category),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CategoryScreen()),
        ),
      ),
    );
  }
}
