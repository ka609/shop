import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/article_provider.dart';
import 'add_edit_article_screen.dart';

class AdminArticlesScreen extends StatelessWidget {
  const AdminArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<ArticleProvider>(context).articles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des articles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddEditArticleScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(articles[i].title),
          subtitle:
              Text('${articles[i].categoryTitle} - ${articles[i].price} FCFA'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AddEditArticleScreen(article: articles[i]),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<ArticleProvider>(context, listen: false)
                      .removeArticle(articles[i].id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
