import 'package:flutter/material.dart';
import '../models/animal.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Animal> favoritos;
  final Function(Animal) toggleFavorito;

  FavoritosScreen({required this.favoritos, required this.toggleFavorito});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: favoritos.isEmpty
          ? Center(child: Text('Nenhum animal adicionado aos favoritos'))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final animal = favoritos[index];
                return ListTile(
                  title: Text(animal.nome),
                  subtitle: Text('${animal.categoria} - ${animal.descricao}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      toggleFavorito(animal); 
                    },
                    child: Text('Remover dos favoritos'),
                  ),
                );
              },
            ),
    );
  }
}
