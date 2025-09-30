import 'package:flutter/material.dart';

// Notificador global (ya existe en main.dart)
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Ajustes', style: theme.textTheme.titleLarge),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentMode, _) {
          // Detecta si está en oscuro (incluye modo sistema)
          final isDark =
              currentMode == ThemeMode.dark ||
              (currentMode == ThemeMode.system &&
                  MediaQuery.of(context).platformBrightness == Brightness.dark);

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              // Switch ANIMADO con iconos
              _themeTile(context, isDark),
              const Divider(),
              // Acerca de
              _aboutTile(context),
            ],
          );
        },
      ),
    );
  }

  /// Tile ANIMADO con iconos y texto del tema
  Widget _themeTile(BuildContext context, bool isDark) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceVariant
            : theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isDark
              ? Icon(
                  Icons.dark_mode,
                  key: const ValueKey('dark'),
                  color: theme.colorScheme.primary,
                )
              : Icon(
                  Icons.light_mode,
                  key: const ValueKey('light'),
                  color: theme.colorScheme.primary,
                ),
        ),
        title: Text(
          isDark ? 'Modo oscuro' : 'Modo claro',
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          'Cambia el tema de la app',
          style: theme.textTheme.bodySmall,
        ),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Switch(
            key: ValueKey(isDark),
            value: isDark,
            activeColor: theme.colorScheme.primary,
            inactiveTrackColor: theme.colorScheme.outline,
            onChanged: (val) {
              themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ),
      ),
    );
  }

  /// Tile "Acerca de" con ícono y texto del tema
  Widget _aboutTile(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(Icons.info_outline, color: theme.iconTheme.color),
      title: Text('Acerca de', style: theme.textTheme.titleMedium),
      subtitle: Text(
        'Versión 1.0 - Autor: Jonathan Espinoza',
        style: theme.textTheme.bodySmall,
      ),
      onTap: () => _showAboutDialog(context),
    );
  }

  /// Diálogo "Acerca de" adaptado al tema
  void _showAboutDialog(BuildContext context) {
    final theme = Theme.of(context);

    showAboutDialog(
      context: context,
      applicationName: 'AppHub Portafolio + Kit Offline',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.flutter_dash,
        size: 50,
        color: theme.colorScheme.primary,
      ),
      children: [
        Text(
          'Esta aplicación fue desarrollada como práctica de Flutter por Jonathan Espinoza.\n\n'
          'Incluye navegación por rutas, temas claro/oscuro, validaciones, estado en memoria y más.',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
