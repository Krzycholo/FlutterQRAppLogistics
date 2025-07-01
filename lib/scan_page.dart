import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skanowanie'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tutaj będzie funkcjonalność skanowania kodów QR'),
            ElevatedButton(
              onPressed: () {
                // Dodaj logikę skanowania
              },
              child: Text('Skanuj Kod QR'),
            ),
          ],
        ),
      ),
    );
  }
}