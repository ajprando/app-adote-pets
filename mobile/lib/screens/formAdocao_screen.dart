import 'package:flutter/material.dart';
import '../models/animal.dart';

class AdocaoFormScreen extends StatefulWidget {
  final Animal animal;

  AdocaoFormScreen({required this.animal});

  @override
  _AdocaoFormScreenState createState() => _AdocaoFormScreenState();
}

class _AdocaoFormScreenState extends State<AdocaoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  String cpf = '';
  String dataNascimento = '';
  String cidade = '';
  String estado = '';
  String numeroContato = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
  
      print('Solicitação de adoção enviada para o animal: ${widget.animal.nome}');
      print('Dados do usuário: $nome, $cpf, $dataNascimento, $cidade, $estado, $numeroContato');
      
  
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Solicitação de adoção enviada com sucesso!'),
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Adoção'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) => nome = value!,
                validator: (value) => value!.isEmpty ? 'Informe seu nome' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
                onSaved: (value) => cpf = value!,
                validator: (value) => value!.isEmpty ? 'Informe seu CPF' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data de Nascimento'),
                onSaved: (value) => dataNascimento = value!,
                validator: (value) => value!.isEmpty ? 'Informe sua data de nascimento' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cidade'),
                onSaved: (value) => cidade = value!,
                validator: (value) => value!.isEmpty ? 'Informe sua cidade' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estado'),
                onSaved: (value) => estado = value!,
                validator: (value) => value!.isEmpty ? 'Informe seu estado' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Número para contato'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => numeroContato = value!,
                validator: (value) => value!.isEmpty ? 'Informe seu número de contato' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Enviar Solicitação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
