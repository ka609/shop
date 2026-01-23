import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../models/article.dart';
import '../../models/category.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  String selectedCategoryId = 'all';

  List<Article> get filteredArticles {
    if (selectedCategoryId == 'all') {
      return DUMMY_ARTICLES;
    }
    return DUMMY_ARTICLES
        .where((article) => article.categoryId == selectedCategoryId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
      ),
      body: Column(
        children: [
          // 🔹 BOUTONS DE CATÉGORIES
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _buildCategoryButton(
                  id: 'all',
                  title: 'Tout',
                ),
                ...DUMMY_CATEGORIES.map((category) {
                  return _buildCategoryButton(
                    id: category.id,
                    title: category.title,
                  );
                }).toList(),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔹 LISTE DES ARTICLES
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredArticles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (ctx, index) {
                final article = filteredArticles[index];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          article.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('${article.price} FCFA'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 WIDGET BOUTON CATÉGORIE
  Widget _buildCategoryButton({
    required String id,
    required String title,
  }) {
    final bool isSelected = selectedCategoryId == id;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedCategoryId = id;
          });
        },
        child: Text(title),
      ),
    );
  }
}
