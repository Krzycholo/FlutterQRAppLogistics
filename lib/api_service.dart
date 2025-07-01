import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.10.10.10:1010/api'; //cenzura :)

  Future<void> addMaterial(String kodMaterialu, String miejsce) async {
    final response = await http.post(
      Uri.parse('$baseUrl/magazyn'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'KodMaterialu': kodMaterialu,
        'Miejsce': miejsce
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Nie udało się dodać materiału');
    }
  }

  Future<Map<String, dynamic>> wydajMaterial(String kodMaterialu) async {
    final response = await http.get(Uri.parse('$baseUrl/magazyn/$kodMaterialu'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Nie udało się odnaleźć materiału');
    }
  }

  Future<Map<String, dynamic>> szukajMaterial(String kodMaterialu) async {
    final response = await http.get(Uri.parse('$baseUrl/magazyn/$kodMaterialu'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Nie udało się odnaleźć materiału');
    }
  }
}