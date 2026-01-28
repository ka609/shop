import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleProvider with ChangeNotifier {
  /// 🔐 Liste privée des articles
  final List<Article> _articles = [];

  /// 📤 Accès en lecture seule
  List<Article> get articles {
    return [..._articles];
  }

  /// ➕ Ajouter un article (ADMIN)
  void addArticle(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  /// ❌ Supprimer un article (ADMIN)
  void removeArticle(String id) {
    _articles.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  /// ✏️ Modifier un article (ADMIN)
  void updateArticle(String id, Article newArticle) {
    final index = _articles.indexWhere((a) => a.id == id);
    if (index >= 0) {
      _articles[index] = newArticle;
      notifyListeners();
    }
  }

  /// 📂 Articles par catégorie (USER)
  List<Article> articlesByCategory(String categoryId) {
    return _articles
        .where((article) => article.categoryId == categoryId)
        .toList();
  }

  /// 🧠 Catégories DÉDUITES des articles
  ///
  /// Retourne une liste unique de catégories
  List<Map<String, String>> get categories {
    final Map<String, String> uniqueCategories = {};

    for (final article in _articles) {
      uniqueCategories[article.categoryId] = article.categoryTitle;
    }

    return uniqueCategories.entries
        .map((e) => {
              'id': e.key,
              'title': e.value,
            })
        .toList();
  }

  /// 🔍 Trouver un article par ID
  Article? findById(String id) {
    try {
      return _articles.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  /// 🧪 MOCK – articles de démonstration (OPTIONNEL)
  ///
  /// Appelé une seule fois dans le main()
  void loadMockData() {
    if (_articles.isNotEmpty) return;

    addArticle(
      Article(
        id: 'a1',
        title: 'Riz local',
        description: 'Riz de Bagré, qualité supérieure',
        price: 2500,
        imageUrl:
            'https://images.unsplash.com/photo-1604909053259-d1e07b36fc1c',
        categoryId: 'c1',
        categoryTitle: 'Alimentation',
      ),
    );

    addArticle(
      Article(
        id: 'a2',
        title: 'Chaussures homme',
        description: 'Chaussures élégantes en cuir',
        price: 18000,
        imageUrl:
            'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77',
        categoryId: 'c2',
        categoryTitle: 'Mode',
      ),
    );
  }

  /// 🧹 Réinitialiser (utile pour logout / tests)
  void clear() {
    _articles.clear();
    notifyListeners();
  }
}
