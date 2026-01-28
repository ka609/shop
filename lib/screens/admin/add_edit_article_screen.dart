import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/article.dart';
import '../../providers/article_provider.dart';

class AddEditArticleScreen extends StatefulWidget {
  final Article? article;
  const AddEditArticleScreen({super.key, this.article});

  @override
  State<AddEditArticleScreen> createState() => _AddEditArticleScreenState();
}

class _AddEditArticleScreenState extends State<AddEditArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String imageUrl = '';
  double price = 0;
  String categoryId = 'c1';
  String categoryTitle = 'Alimentation'; // valeur par défaut

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      title = widget.article!.title;
      description = widget.article!.description;
      imageUrl = widget.article!.imageUrl;
      price = widget.article!.price;
      categoryId = widget.article!.categoryId;
      categoryTitle = widget.article!.categoryTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.article == null ? 'Ajouter article' : 'Modifier article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Titre'),
                onSaved: (v) => title = v!,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (v) => description = v!,
              ),
              TextFormField(
                initialValue: imageUrl,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (v) => imageUrl = v!,
              ),
              TextFormField(
                initialValue: price != 0 ? price.toString() : '',
                decoration: const InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number,
                onSaved: (v) => price = double.parse(v!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Enregistrer'),
                onPressed: () {
                  _formKey.currentState!.save();

                  final newArticle = Article(
                    id: widget.article?.id ?? DateTime.now().toString(),
                    title: title,
                    description: description,
                    price: price,
                    imageUrl: imageUrl,
                    categoryId: categoryId,
                    categoryTitle: categoryTitle,
                  );

                  final provider =
                      Provider.of<ArticleProvider>(context, listen: false);

                  if (widget.article == null) {
                    provider.addArticle(newArticle);
                  } else {
                    provider.updateArticle(widget.article!.id, newArticle);
                  }

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
