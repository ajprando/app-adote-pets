import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/models/animal.dart';


class ApiService {
  Client client;

  ApiService(this.client);

  final String baseUrl = 'http://localhost:3000';

  Future<Animal> getAnimal() async {
    Uri uri = Uri.parse("http://localhost:3000/animais");

    Response response = await client.get(uri);

    if (response.statusCode == 200) {
      return Animal.fromJson(jsonDecode(response.body));
    }
    throw Exception('Erro');
  }

  Future<List<dynamic>> fetchAnimal() async {
    final response = await http.get(Uri.parse('$baseUrl/animais'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar animais');
    }
  }

  Future<void> addAnimal(Map<String, dynamic> animal) async {
    final response = await http.post(
      Uri.parse('$baseUrl/animais'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(animal),
    );
 
    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar animal');
    }
  }

  Future<void> deleteAnimal(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/animais/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar animal');
    }
  }

  Future<void> updateAnimal(String id, Map<String, dynamic> animal) async {
    final response = await http.put(
      Uri.parse('$baseUrl/animais/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(animal),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar animal');
    }
   }

}
