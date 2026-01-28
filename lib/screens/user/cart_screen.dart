import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Panier'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 18),
                  ),
                  Chip(
                    label: Text(
                      '${cart.totalAmount} FCFA',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text('Panier vide'))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      final item = cart.items.values.toList()[i];
                      final productId = cart.items.keys.toList()[i];

                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(
                          'Qté: ${item.quantity} | ${item.price * item.quantity} FCFA',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cart.removeItem(productId);
                          },
                        ),
                      );
                    },
                  ),
          ),
          ElevatedButton(
            child: const Text('Valider la commande'),
            onPressed: cart.items.isEmpty
                ? null
                : () {
                    cart.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Commande validée avec succès'),
                      ),
                    );
                  },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
