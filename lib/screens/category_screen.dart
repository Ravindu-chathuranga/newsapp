import 'package:flutter/material.dart';
// import 'package:news_app/services/news_service.dart';
// import 'package:news_app/models/article_model.dart';
import 'package:weathe_news_app/Services /news_service.dart';
import 'package:weathe_news_app/models/artical_model.dart';
import 'article_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final NewsService newsService = NewsService();
  List<Article> articles = [];
  String selectedCategory = 'business';
  List<String> categories = [
    'business',
    'sports',
    'technology',
    'health',
    'entertainment'
  ];

  // Define a color mapping for categories
  final Map<String, Color> categoryColors = {
    'business': Colors.blue,
    'sports': Colors.green,
    'technology': Colors.orange,
    'health': Colors.red,
    'entertainment': Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    fetchNews(selectedCategory);
  }

  Future<void> fetchNews(String category) async {
    final data = await newsService.fetchCategoryNews(category);
    setState(() {
      articles = data.map((json) => Article.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: categoryColors[selectedCategory], // Set AppBar color
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: categoryColors[selectedCategory]
                ?.withOpacity(0.2), // Light background color
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                      fetchNews(selectedCategory);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]
                          ? categoryColors[categories[index]]
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(categories[index],
                            style: const TextStyle(color: Colors.white))),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
