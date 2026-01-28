import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/article_provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String articleId;

  const ArticleDetailScreen({
    super.key,
    required this.articleId,
  });

  @override
  Widget build(BuildContext context) {
    final articleProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    final Article? article = articleProvider.findById(articleId);

    if (article == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Article')),
        body: const Center(
          child: Text('Article introuvable'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.image_not_supported,
                  size: 100,
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// 💰 Prix
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '${article.price.toStringAsFixed(0)} FCFA',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// 📝 Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                article.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            /// 🛒 Bouton ajouter au panier
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Ajouter au panier'),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(article.id, article.title, article.price);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Article ajouté au panier'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
