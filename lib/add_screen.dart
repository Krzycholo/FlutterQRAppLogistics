import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'api_service.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final ApiService apiService = ApiService();
  String kodMaterialu = '';
  String miejsce = '';

  void onDetectBarcode(BarcodeCapture barcodeCapture) {
  String code = barcodeCapture.barcodes.first.rawValue ?? "";
  if (code.isNotEmpty) {
    if (code.contains(RegExp(r'R(\d{1,3})P(\d{1,3})'))) {
      // Jeśli kod to miejsce
      setState(() {
        miejsce = code;
      });
    } else {
      // Jeśli kod to materiał
      setState(() {
        kodMaterialu = code;
      });
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nieprawidłowy kod: $code')),
    );
  }
}

  void addMaterial() async {
    try {
      await apiService.addMaterial(kodMaterialu, miejsce);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dodano materiał pomyślnie')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd przy dodawaniu materiału: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 97, 97),
        foregroundColor: Color(0xFFFFA726),
        title: Text('Dodaj Materiał',
          style: TextStyle(
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Tło gradientowe
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A4A4A), Color(0xFF9E9E9E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: MobileScanner(
                    onDetect: onDetectBarcode,
                  ),
                ),
                SizedBox(height: 40),
                _buildInfoDisplay(
                  'Materiał:', kodMaterialu,
                ),
                SizedBox(height: 10),
                _buildInfoDisplay(
                  'Miejsce:', miejsce,
                ),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: kodMaterialu.isNotEmpty && miejsce.isNotEmpty ? addMaterial : null,
                  icon: Icon(Icons.add_box, size: 30),
                  label: Text(
                    'Dodaj Materiał',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                      fontSize: kodMaterialu.length > 20 ? 20 : 28,
                      fontWeight: FontWeight.bold,
                      color: kodMaterialu.isNotEmpty && miejsce.isNotEmpty ? Color(0xFFFFA726) : Colors.grey,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    minimumSize: Size(150, 60),
                    backgroundColor: const Color.fromARGB(255, 49, 49, 49),
                    foregroundColor: Color(0xFFFFA726),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoDisplay(String label, String value) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFFFFA726),
                fontSize: value.length > 20 ? 20 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileScannerPage extends StatelessWidget {
  final Function(Barcode barcode) onDetect;
  final String title;

  MobileScannerPage({required this.onDetect, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: MobileScanner(
        onDetect: (barcodeCapture) {
          // Pobierz kod kreskowy
          final Barcode? code = barcodeCapture.barcodes.first;
          if (code != null && code.rawValue != null) {
            onDetect(code);
          }
        },
      ),
    );
  }
}