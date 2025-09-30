import 'package:flutter/material.dart';

// Importa tus módulos (ajusta rutas si están en otra carpeta)
import '../KitOffline/notas_rapidas.dart';
import '../KitOffline/imc.dart';
import '../KitOffline/galeria.dart';
import '../KitOffline/juego_par_impar.dart';

// Drawer dinámico (ya lo tienes en main.dart o lo pasas como parámetro)
class AppDrawer extends StatelessWidget {
  final String currentRoute;
  const AppDrawer({super.key, this.currentRoute = '/'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.primary),
            child: const Text('Menú',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
    );
  }
}

/* ---------- KIT OFFLINE ADAPTADO AL TEMA ---------- */
class KitOffline extends StatefulWidget {
  const KitOffline({super.key});

  @override
  State<KitOffline> createState() => _KitOfflineState();
}

class _KitOfflineState extends State<KitOffline> {
  int _currentIndex = 0;

  final List<Widget> _modulos = [
    const NotasView(),
    const CalculadoraIMC(),
    const GaleriaLocal(),
    const JuegoParImpar(),
  ];

  final List<String> _titulos = [
    'Notas rápidas',
    'Calculadora IMC',
    'Galería local',
    'Juego Par/Impar',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ← fondo del tema
      appBar: AppBar(
        title: Text(_titulos[_currentIndex], style: theme.textTheme.titleLarge),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary, // ← texto del AppBar
        elevation: 0,
      ),
      drawer: const AppDrawer(currentRoute: '/kitoffline'), // ← drawer dinámico
      body: _modulos[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.colorScheme.surface, // ← fondo del BottomNav
        selectedItemColor: theme.colorScheme.primary, // ← ícono seleccionado
        unselectedItemColor: theme.iconTheme.color, // ← ícono no seleccionado
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notas'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'IMC'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Galería'),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Juego'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
