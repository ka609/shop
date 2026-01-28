import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/article_provider.dart';
import 'article_detail_screen.dart';

class ArticlesScreen extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  const ArticlesScreen({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final articles =
        Provider.of<ArticleProvider>(context).articlesByCategory(categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: articles.isEmpty
          ? const Center(child: Text('Aucun article disponible'))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: articles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, i) {
                final article = articles[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ArticleDetailScreen(articleId: article.id),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: article.id,
                            child: Image.network(
                              article.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            article.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('${article.price} FCFA'),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
