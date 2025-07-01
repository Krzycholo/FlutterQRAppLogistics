import 'package:flutter/material.dart';
import 'api_service.dart';

class SzukajScreen extends StatefulWidget {
  @override
  _SzukajScreenState createState() => _SzukajScreenState();
}

class _SzukajScreenState extends State<SzukajScreen> {
  final ApiService apiService = ApiService();
  String kodMaterialu = '';
  Map<String, dynamic>? material;

  void szukajMaterial() async {
    try {
      final result = await apiService.szukajMaterial(kodMaterialu);
      setState(() {
        material = result;
      });
    } catch (e) {
      print('Błąd przy szukaniu materiału: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Szukaj Materiału'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Kod Materiału'),
              onChanged: (value) {
                kodMaterialu = value;
              },
            ),
            ElevatedButton(
              onPressed: szukajMaterial,
              child: Text('Szukaj Materiału'),
            ),
            if (material != null) ...[
              Image.network(material!['Zdjecie']),
              Text('Indeks: ${material!['Indeks']}'),
              Text('Miejsce: ${material!['Miejsce']}'),
            ]
          ],
        ),
      ),
    );
  }
}