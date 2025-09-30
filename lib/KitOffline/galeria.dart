import 'package:flutter/material.dart';

class GaleriaLocal extends StatelessWidget {
  const GaleriaLocal({super.key});

  // ← Ajusta aquí los nombres de tus imágenes
  final List<Map<String, String>> imagenesAssets = const [
    {'ruta': 'assets/images/AudiF1Team.jpg', 'titulo': 'Imagen 1'},
    {'ruta': 'assets/images/Ferrari.jpeg', 'titulo': 'Imagen 2'},
    {'ruta': 'assets/images/McLaren.jpg', 'titulo': 'Imagen 3'},
    {'ruta': 'assets/images/RedBull.jpeg', 'titulo': 'Imagen 4'},
  ];

  void _mostrarImagen(BuildContext context, String ruta, String titulo) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor:
            theme.colorScheme.surface, // ← fondo del diálogo del tema
        title: Text(titulo, style: theme.textTheme.titleLarge),
        content: Image.asset(ruta, fit: BoxFit.contain),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar', style: theme.textTheme.labelLarge),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ← fondo del tema
      appBar: AppBar(
        title: Text('Galería local', style: theme.textTheme.titleLarge),
        backgroundColor:
            theme.colorScheme.primary, // ← color del AppBar del tema
        foregroundColor:
            theme.colorScheme.onPrimary, // ← texto del AppBar del tema
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: imagenesAssets.map((img) {
            return GestureDetector(
              onTap: () =>
                  _mostrarImagen(context, img['ruta']!, img['titulo']!),
              child: Card(
                color:
                    theme.colorScheme.surface, // ← color de la tarjeta del tema
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    img['ruta']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
