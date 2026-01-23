import 'package:flutter/material.dart';
import '../models/article.dart';
import '../models/category.dart';

final DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Électronique',
    color: Colors.blue,
  ),
  Category(
    id: 'c2',
    title: 'Vêtements',
    color: Colors.green,
  ),
  Category(
    id: 'c3',
    title: 'Maison',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'Sport',
    color: Colors.red,
  ),
];

final DUMMY_ARTICLES = [
  Article(
    id: 'a1',
    title: 'Smartphone Android',
    description: 'Smartphone performant avec écran AMOLED.',
    price: 150000.0,
    imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
    categoryId: 'c1',
  ),
  Article(
    id: 'a2',
    title: 'Ordinateur Portable',
    description: 'PC portable pour le travail et les études.',
    price: 350000.0,
    imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    categoryId: 'c1',
  ),
  Article(
    id: 'a3',
    title: 'T-shirt',
    description: 'T-shirt 100% coton.',
    price: 5000.0,
    imageUrl: 'https://images.unsplash.com/photo-1520975916090-3105956dac38',
    categoryId: 'c2',
  ),
  Article(
    id: 'a4',
    title: 'Chaussures de sport',
    description: 'Chaussures confortables pour le sport.',
    price: 25000.0,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    categoryId: 'c4',
  ),
];
