import 'package:flutter/material.dart';

class NotasView extends StatefulWidget {
  const NotasView({super.key});

  @override
  State<NotasView> createState() => _NotasViewState();
}

class _NotasViewState extends State<NotasView> {
  final List<String> _notas = [];
  final _controller = TextEditingController();

  void _agregarNota() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;
    setState(() => _notas.add(texto));
    _controller.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Nota agregada')),
    );
  }

  void _borrarTodo() {
    setState(() => _notas.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Todas las notas borradas')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ← fondo del tema
      appBar: AppBar(
        title: Text('Notas Rápidas', style: theme.textTheme.titleLarge),
        backgroundColor:
            theme.colorScheme.primary, // ← color del AppBar del tema
        foregroundColor:
            theme.colorScheme.onPrimary, // ← texto del AppBar del tema
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: theme.colorScheme.onPrimary),
            onPressed: _borrarTodo,
          ),
        ],
      ),
      body: _notas.isEmpty
          ? Center(
              child: Text(
                'No hay notas',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _notas.length,
              itemBuilder: (_, i) => Card(
                color:
                    theme.colorScheme.surface, // ← color de la tarjeta del tema
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(
                    _notas[i],
                    style:
                        theme.textTheme.bodyLarge, // ← color del texto del tema
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: theme.colorScheme.error),
                    onPressed: () {
                      setState(() => _notas.removeAt(i));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Nota eliminada')),
                      );
                    },
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary, // ← color del FAB del tema
        foregroundColor:
            theme.colorScheme.onPrimary, // ← ícono del FAB del tema
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor:
                theme.colorScheme.surface, // ← fondo del diálogo del tema
            title: Text('Nueva Nota', style: theme.textTheme.titleLarge),
            content: TextField(
              controller: _controller,
              style: theme
                  .textTheme.bodyLarge, // ← color del texto del campo del tema
              decoration: InputDecoration(
                hintText: 'Escribe aquí',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar', style: theme.textTheme.labelLarge),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _agregarNota();
                },
                child: Text('Guardar', style: theme.textTheme.labelLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
