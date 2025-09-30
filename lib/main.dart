import 'package:flutter/material.dart';
/* ---------- IMPORTS (tus rutas) ---------- */
import 'Practicas/Formulario.dart';
import 'Practicas/practica3.dart';
import 'Practicas/practica4.dart';
import 'Practicas/rps_game.dart';
import 'HUB/kitoffline.dart';
import 'Ajustes/ajustes.dart';
import 'HUB/hub_practicas.dart';

/* ---------- TEMA GLOBAL ---------- */
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MyApp());
}

/* ---------- APP QUE SE RECONSTRUYE AL CAMBIAR TEMA ---------- */
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    themeNotifier.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Flutter',
      debugShowCheckedModeBanner: false,
      // TEMA CLARO
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // TEMA OSCURO
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      themeMode: themeNotifier.value,
      initialRoute: '/',
      routes: {
        '/': (_) => const HubScreen(),
        '/formulario': (_) => const Formulario(),
        '/practica3': (_) => const Practica3(),
        '/practica4': (_) => const Practica4(),
        '/juego': (_) => const RPSGameScreen(),
        '/kitoffline': (_) => const KitOffline(),
        '/ajustes': (_) => const AjustesScreen(),
        '/practicas': (_) => const HubPracticas(),
      },
    );
  }
}

/* ---------- HUB (sin cambiar nada de tu estructura) ---------- */
class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      drawer: const AppDrawer(),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCard(context, Icons.assignment, 'Prácticas', '/practicas'),
          _buildCard(
            context,
            Icons.apps,
            'Proyecto: Kit Offline',
            '/kitoffline',
          ),
          _buildCard(context, Icons.settings, 'Ajustes', '/ajustes'),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: theme.colorScheme.primary),
              const SizedBox(height: 12),
              Text(title, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------- DRAWER (sin colores quemados) ---------- */
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
            child: const Text(
              "Menú de prácticas",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _drawerItem(
            context,
            icon: Icons.format_align_center,
            text: 'Formulario',
            route: '/formulario',
          ),
          _drawerItem(
            context,
            icon: Icons.looks_3,
            text: 'Práctica 3',
            route: '/practica3',
          ),
          _drawerItem(
            context,
            icon: Icons.looks_4,
            text: 'Práctica 4',
            route: '/practica4',
          ),
          _drawerItem(
            context,
            icon: Icons.sports_esports,
            text: 'Juego: Piedra, Papel o Tijera',
            route: '/juego',
          ),
          const Divider(),
          _drawerItem(
            context,
            icon: Icons.workspaces_outline,
            text: 'Proyecto: Kit Offline',
            route: '/kitoffline',
          ),
          const Divider(),
          _drawerItem(context, icon: Icons.home, text: 'Inicio', route: '/'),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required String route,
  }) {
    final theme = Theme.of(context);
    final isSelected = ModalRoute.of(context)?.settings.name == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? theme.colorScheme.primary : theme.iconTheme.color,
      ),
      title: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.textTheme.bodyLarge?.color,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.12),
    );
  }
}
