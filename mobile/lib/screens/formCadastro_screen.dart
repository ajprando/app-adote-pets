import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/enums/categoria_enum.dart';
import 'package:mobile/services/api_service.dart';

class CadastroAnimalForm extends StatefulWidget {
  final Map<String, dynamic>? animal;

  CadastroAnimalForm({this.animal});

  @override
  _CadastroAnimaLFormState createState() =>  _CadastroAnimaLFormState();

}

class _CadastroAnimaLFormState extends State<CadastroAnimalForm> {
  final _formKey= GlobalKey<FormState>();
  String _nome = '';
  String _categoria = '';
  String _sexo = '';
  String _descricao = '';

  @override
  void initState() {
    super.initState();
    if(widget.animal != null) {
      _nome = widget.animal!['nome'];
      _categoria = widget.animal!['categoria'];
      _sexo = widget.animal!['sexo'];
      _descricao = widget.animal!['descricao'] ?? '';
    }
  }

  Future<void> _salvarForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Map<String, dynamic> animal = {
        'nome': _nome,
        'categoria': _categoria,
        'sexo': _sexo,
        'descricao': _descricao,
      };
      final apiService = ApiService(Client());
      try {
        if (widget.animal == null) {
          await apiService.addAnimal(animal);
        } else {
          await apiService.updateAnimal(widget.animal!['id'], animal);
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar animal: $e")),
        );
      }
    }
  }


  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.animal == null ? 'Adicionar animal' : 'Editar animal'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _nome,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nome = value!;
                  },
                ),
                TextFormField(
                  initialValue: _descricao,
                  decoration: InputDecoration(labelText: 'Descrição (Opcional)'),
                  onSaved: (value) {
                    _descricao = value ?? '';
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _salvarForm, 
                  child: Text('Salvar'),
                  ),
              ],
            ),
           ), ),
      );
    
  }

}