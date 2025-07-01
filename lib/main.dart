import 'package:flutter/material.dart';
import 'add_screen.dart';
import 'wydaj_screen.dart';
import 'szukaj_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dodajemy 2-sekundowe opóźnienie
  await Future.delayed(Duration(seconds: 2));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Definiowanie jasnego motywu
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  // Definiowanie ciemnego motywu
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
  );

  // Domyślnie używamy ustawień systemowych
  ThemeMode _themeMode = ThemeMode.system;

  // Funkcja przełączająca motyw
  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        // Jeśli aktualny motyw to systemowy, przełącz na jasny
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazyn - Główna Strona',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: HomeScreen(
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({
    Key? key,
    required this.onThemeToggle,
  }) : super(key: key);

  void _navigateToAddPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddScreen(),
      ),
    );
  }

  void _navigateToWydajPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WydajScreen(),
      ),
    );
  }

  void _navigateToSzukajPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SzukajScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Zawartość
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 30,
                        blurRadius: 50,
                        offset: Offset(0, 2), // przesunięcie cienia
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2), // Promień zaokrąglenia rogów
                    child: Image.asset(
                      'assets/images/logoele.png',
                      width: 1000,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Witaj Pracowniku !',
                  style: TextStyle(
                    
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2), // Przesunięcie cienia
                        blurRadius: 4.0, // Rozmycie cienia
                        color: Colors.black.withOpacity(0.5), // Kolor i przezroczystość cienia
                      ),
                    ],
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 70),
                _buildHomeButton(
                  context: context,
                  icon: Icons.add,
                  label: 'Dodaj',
                  onTap: () => _navigateToAddPage(context),
                  buttonColor: Color(0xFFFFA726),
                ),
                SizedBox(height: 70),
                _buildHomeButton(
                  context: context,
                  icon: Icons.remove,
                  label: 'Wydaj',
                  onTap: () => _navigateToWydajPage(context),
                  buttonColor: Color(0xFFFFA726),
                ),
                SizedBox(height: 70),
                _buildHomeButton(
                  context: context,
                  icon: Icons.search,
                  label: 'Szukaj',
                  onTap: () => _navigateToSzukajPage(context),
                  buttonColor: Color(0xFFFFA726),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    TextStyle? textStyle,
    required Color buttonColor,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        foregroundColor: buttonColor, // Pomarańczowy kolor ikon i tekstu
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      icon: Icon(icon, size: 40),
      label: Text(
        label,
        style: TextStyle(

          shadows: [
            Shadow(
              offset: Offset(1, 1), // Przesunięcie cienia
              blurRadius: 3.0, // Rozmycie cienia
              color: Colors.black.withOpacity(0.5), // Kolor i przezroczystość cienia
            ),
          ],
          fontSize: 30,
          fontWeight: FontWeight.bold, 
          color: buttonColor, // Pomarańczowy akcent
           ),
        ),
      onPressed: onTap,
    );
  }
}
