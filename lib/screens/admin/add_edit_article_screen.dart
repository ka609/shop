import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final _picker = ImagePicker();

  String title = '';
  String description = '';
  double price = 0;
  String categoryId = 'c1';
  String categoryTitle = 'Alimentation';

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      title = widget.article!.title;
      description = widget.article!.description;
      price = widget.article!.price;
      categoryId = widget.article!.categoryId;
      categoryTitle = widget.article!.categoryTitle;

      if (widget.article!.imageUrl.isNotEmpty) {
        _imageFile = File(widget.article!.imageUrl);
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une image')),
      );
      return;
    }

    _formKey.currentState!.save();

    final article = Article(
      id: widget.article?.id ?? DateTime.now().toString(),
      title: title,
      description: description,
      price: price,
      imageUrl: _imageFile!.path, // 👈 chemin local
      categoryId: categoryId,
      categoryTitle: categoryTitle,
    );

    final provider = Provider.of<ArticleProvider>(context, listen: false);

    if (widget.article == null) {
      provider.addArticle(article);
    } else {
      provider.updateArticle(widget.article!.id, article);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article == null ? 'Ajouter un article' : 'Modifier l’article',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// 🖼 Image preview
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                        image: _imageFile != null
                            ? DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _imageFile == null
                          ? const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_a_photo, size: 40),
                                  SizedBox(height: 8),
                                  Text('Ajouter une image'),
                                ],
                              ),
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 📝 Titre
                  TextFormField(
                    initialValue: title,
                    decoration: const InputDecoration(
                      labelText: 'Titre',
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Champ requis' : null,
                    onSaved: (v) => title = v!,
                  ),

                  const SizedBox(height: 15),

                  /// 📝 Description
                  TextFormField(
                    initialValue: description,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.description),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Champ requis' : null,
                    onSaved: (v) => description = v!,
                  ),

                  const SizedBox(height: 15),

                  /// 💰 Prix
                  TextFormField(
                    initialValue: price == 0 ? '' : price.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Prix (FCFA)',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Champ requis';
                      if (double.tryParse(v) == null) {
                        return 'Nombre invalide';
                      }
                      return null;
                    },
                    onSaved: (v) => price = double.parse(v!),
                  ),

                  const SizedBox(height: 15),

                  /// 📂 Catégorie
                  DropdownButtonFormField<String>(
                    value: categoryId,
                    decoration: const InputDecoration(
                      labelText: 'Catégorie',
                      prefixIcon: Icon(Icons.category),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'c1',
                        child: Text('Alimentation'),
                      ),
                      DropdownMenuItem(
                        value: 'c2',
                        child: Text('Mode'),
                      ),
                      DropdownMenuItem(
                        value: 'c3',
                        child: Text('Électronique'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        categoryId = value!;
                        categoryTitle = value == 'c1'
                            ? 'Alimentation'
                            : value == 'c2'
                                ? 'Mode'
                                : 'Électronique';
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  /// 💾 Bouton enregistrer
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Enregistrer'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _saveForm,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
