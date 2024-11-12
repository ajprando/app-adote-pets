import 'package:flutter/material.dart';
import 'package:mobile/models/animal.dart';
import 'screens/home_screen.dart';
import 'screens/favoritos_screen.dart';

void main() {
  runApp(AnimalAdoptionApp());
}

class AnimalAdoptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adoção de Animais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  List<Animal> favoritos = [];

  void toggleFavorito(Animal animal) {
    setState(() {
      if (favoritos.contains(animal)) {
        favoritos.remove(animal); 
      } else {
        favoritos.add(animal); 
      }
    });
  }

  List<Widget> _pages() {
    return [
      HomeScreen(toggleFavorito: toggleFavorito, favoritos: favoritos),
      FavoritosScreen(favoritos: favoritos, toggleFavorito: toggleFavorito),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

