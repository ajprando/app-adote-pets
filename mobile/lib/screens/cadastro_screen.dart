import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/models/animal.dart';
import 'package:mobile/screens/formCadastro_screen.dart';
import 'package:mobile/services/api_service.dart';

class CadastroAnimalList extends StatefulWidget {
  @override 
  _CadastroAnimalListState createState() => _CadastroAnimalListState();
}

class _CadastroAnimalListState extends State<CadastroAnimalList> {
  final ApiService apiservice = ApiService(Client());
  List<dynamic> animais = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAnimal();
  }

  void fetchAnimal() async {
    setState(() => isLoading = true);
    try {
      final data = await apiservice.fetchAnimal();
      setState(() {
        animais = data;
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao listar animais: $e');
      setState(() => isLoading = false);
    }
  }

  void deleteAnimal(String id, int index) async {
    try {
      await apiservice.deleteAnimal(id);
      fetchAnimal();
    } catch (e) {
      print('Erro ao deletar animal: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar animal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Cadastro de animais")
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => CadastroAnimalForm()),
          ).then((value) => fetchAnimal());
      },
      child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: animais.length,
        itemBuilder: (context, index) {
          final animal = animais[index];
          return Dismissible(
            key: Key(animal['id'].toString()),
            background: Container(color: Colors.red, child: Icon(Icons.delete)),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                deleteAnimal(animal['id'], index);
              }
            }, 
            child: ListTile(
              title: Text(animal['nome']),
              subtitle: Text(animal['categoria']),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroAnimalForm(animal: animal),
                    ),
                  ).then((value) => fetchAnimal());
                },
              ),
            ),
          );
        },
      )
    );
  }
}