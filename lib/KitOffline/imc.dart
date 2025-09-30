import 'package:flutter/material.dart';

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({super.key});

  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final _formKey = GlobalKey<FormState>();
  final _estaturaController = TextEditingController();
  final _pesoController = TextEditingController();

  void _calcularIMC() {
    if (!_formKey.currentState!.validate()) return;

    final double estatura = double.parse(_estaturaController.text);
    final double peso = double.parse(_pesoController.text);
    final double imc = peso / (estatura * estatura);

    String categoria = '';
    if (imc < 18.5) {
      categoria = 'Bajo peso';
    } else if (imc < 25) {
      categoria = 'Normal';
    } else if (imc < 30) {
      categoria = 'Sobrepeso';
    } else {
      categoria = 'Obesidad';
    }

    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tu IMC: ${imc.toStringAsFixed(2)} → $categoria'),
        backgroundColor: theme.colorScheme.primary, // ← color del tema
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _limpiar() {
    _formKey.currentState!.reset();
    _estaturaController.clear();
    _pesoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ← fondo del tema
      appBar: AppBar(
        title: Text('Calculadora IMC', style: theme.textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary, // ← color del tema
        foregroundColor: theme.colorScheme.onPrimary, // ← texto del AppBar
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.15),
              theme.colorScheme.primary.withOpacity(0.30),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de estatura
              Card(
                elevation: 4,
                color:
                    theme.colorScheme.surface, // ← color de la tarjeta del tema
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: TextFormField(
                    controller: _estaturaController,
                    style:
                        theme.textTheme.bodyLarge, // ← color del texto del tema
                    decoration: InputDecoration(
                      labelText: 'Estatura (m)',
                      labelStyle: theme.textTheme.bodyMedium,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.colorScheme.outline),
                      ),
                      prefixIcon:
                          Icon(Icons.height, color: theme.iconTheme.color),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Obligatorio';
                      if (double.tryParse(val) == null ||
                          double.parse(val) <= 0) {
                        return 'Número positivo';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Campo de peso
              Card(
                elevation: 4,
                color: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: TextFormField(
                    controller: _pesoController,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: theme.textTheme.bodyMedium,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: theme.colorScheme.outline),
                      ),
                      prefixIcon: Icon(Icons.monitor_weight,
                          color: theme.iconTheme.color),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Obligatorio';
                      if (double.tryParse(val) == null ||
                          double.parse(val) <= 0) {
                        return 'Número positivo';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Botones
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calcularIMC,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme
                            .colorScheme.primary, // ← color del botón del tema
                        foregroundColor: theme.colorScheme
                            .onPrimary, // ← texto del botón del tema
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: theme.textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Calcular IMC'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _limpiar,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color:
                                theme.colorScheme.primary), // ← borde del tema
                        foregroundColor: theme
                            .colorScheme.primary, // ← texto del botón del tema
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: theme.textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Limpiar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
