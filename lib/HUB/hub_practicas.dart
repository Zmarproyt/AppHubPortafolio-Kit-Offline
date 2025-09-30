import 'package:flutter/material.dart';

// Importa tus prácticas (ajusta rutas si están en otra carpeta)
import '../Practicas/formulario.dart';
import '../Practicas/practica3.dart';
import '../Practicas/practica4.dart';
import '../Practicas/rps_game.dart';

class HubPracticas extends StatefulWidget {
  const HubPracticas({super.key});

  @override
  State<HubPracticas> createState() => _HubPracticasState();
}

class _HubPracticasState extends State<HubPracticas> {
  int _currentIndex = 0;

  final List<Widget> _modulos = [
    const Formulario(),
    const Practica3(),
    const Practica4(),
    const RPSGameScreen(),
  ];

  final List<String> _titulos = [
    'Formulario',
    'Práctica 3',
    'Práctica 4',
    'Juego: Piedra, Papel o Tijera',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(_titulos[_currentIndex], style: theme.textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: _modulos[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: theme.colorScheme.surface,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.iconTheme.color?.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_center),
            label: 'Formulario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: 'Práctica 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_4),
            label: 'Práctica 4',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Juego',
          ),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
