import 'package:flutter/material.dart';
import 'api_service.dart';

class WydajScreen extends StatefulWidget {
  @override
  _WydajScreenState createState() => _WydajScreenState();
}

class _WydajScreenState extends State<WydajScreen> {
  final ApiService apiService = ApiService();
  String kodMaterialu = '';
  Map<String, dynamic>? material;

  void wydajMaterial() async {
    try {
      final result = await apiService.wydajMaterial(kodMaterialu);
      setState(() {
        material = result;
      });
    } catch (e) {
      print('Błąd przy wydawaniu materiału: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wydaj Materiał'),
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
              onPressed: wydajMaterial,
              child: Text('Wydaj Materiał'),
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