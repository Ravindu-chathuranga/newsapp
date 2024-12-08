import 'package:flutter/material.dart';
import 'package:weathe_news_app/models/artical_model.dart';

class SearchScreen extends StatefulWidget {
  final List<Article> articles;

  const SearchScreen({super.key, required this.articles});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(hintText: 'Search News...'),
          onChanged: (value) =>
              setState(() => searchQuery = value.toLowerCase()),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.articles.length,
        itemBuilder: (context, index) {
          final article = widget.articles[index];
          if (article.title.toLowerCase().contains(searchQuery)) {
            return ListTile(
              leading: Image.network(article.urlToImage, fit: BoxFit.cover),
              title: Text(article.title),
              subtitle: Text(article.description),
            );
          }
          return Container();
        },
      ),
    );
  }
}
