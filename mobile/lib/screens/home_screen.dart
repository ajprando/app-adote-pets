import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/screens/formAdocao_screen.dart';
import '../models/animal.dart';
import '../services/api_service.dart';
import '../enums/categoria_enum.dart';
import '../enums/sexo_enum.dart';

class HomeScreen extends StatefulWidget {
  final Function(Animal) toggleFavorito;
  final List<Animal> favoritos;

  HomeScreen({required this.toggleFavorito, required this.favoritos});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiService apiService;
  List<Animal> animais = [];
  Categoria? selectedCategoria;
  Sexo? selectedSexo;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(Client());
    fetchAnimals();
  }

  void fetchAnimals({String? categoria, String? sexo}) async {
    try {
      // Chama o método fetchAnimal da ApiService com os parâmetros de filtro
      List<Animal> data = await apiService.fetchAnimal(categoria: categoria, sexo: sexo);
      setState(() {
        animais = data;
      });
    } catch (e) {
      print('Erro ao carregar animais: $e');
    }
  }

  List<Animal> get filteredAnimals {
    // Exibe todos os animais quando nenhum filtro está selecionado
    if (selectedCategoria == null && selectedSexo == null) {
      return animais;
    }

    // Filtra por categoria e/ou sexo com base nos valores selecionados
    return animais.where((animal) {
      final matchesCategoria = selectedCategoria == null ||
          animal.categoria == selectedCategoria.toString().split('.').last;
      final matchesSexo = selectedSexo == null ||
          animal.sexo == selectedSexo.toString().split('.').last;
      return matchesCategoria && matchesSexo;
    }).toList();
  }

  void updateCategoryFilter(Categoria? newCategory) {
    setState(() {
      selectedCategoria = newCategory;
    });
  }

  void updateSexFilter(Sexo? newSex) {
    setState(() {
      selectedSexo = newSex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animais para Adoção"),
      ),
      body: Column(
        children: [
          // Dropdown de Categoria
          DropdownButton<Categoria>(
            hint: Text('Filtrar por categoria'),
            value: selectedCategoria,
            onChanged: (Categoria? newValue) {
              setState(() {
                selectedCategoria = newValue;
              });
              fetchAnimals(
                categoria: selectedCategoria != null ? selectedCategoria.toString().split('.').last : null,
                sexo: selectedSexo != null ? selectedSexo.toString().split('.').last : null,
              );
            },
            items: Categoria.values.map((Categoria categoria) {
              return DropdownMenuItem<Categoria>(
                value: categoria,
                child: Text(categoria.toString().split('.').last),
              );
            }).toList(),
          ),
          // Dropdown de Sexo
          DropdownButton<Sexo>(
            hint: Text('Filtrar por sexo'),
            value: selectedSexo,
            onChanged: (Sexo? newValue) {
              setState(() {
                selectedSexo = newValue;
              });
              fetchAnimals(
                categoria: selectedCategoria != null ? selectedCategoria.toString().split('.').last : null,
                sexo: selectedSexo != null ? selectedSexo.toString().split('.').last : null,
              );
            },
            items: Sexo.values.map((Sexo sexo) {
              return DropdownMenuItem<Sexo>(
                value: sexo,
                child: Text(sexo.toString().split('.').last),
              );
            }).toList(),
          ),
          // Lista de Animais Filtrada
          Expanded(
            child: ListView.builder(
              itemCount: filteredAnimals.length,
              itemBuilder: (context, index) {
                final animal = filteredAnimals[index];
                final isFavorito = widget.favoritos.contains(animal);

                return ListTile(
                  title: Text(animal.nome),
                  subtitle: Text('${animal.categoria} - ${animal.descricao}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorito ? Icons.favorite : Icons.favorite_border,
                          color: isFavorito ? Colors.red : null,
                        ),
                        onPressed: () {
                          widget.toggleFavorito(animal);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.pets),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdocaoFormScreen(animal: animal),
                            ),
                          );
                        },
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
}
