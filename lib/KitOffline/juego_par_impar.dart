import 'dart:math';
import 'package:flutter/material.dart';

class JuegoParImpar extends StatefulWidget {
  const JuegoParImpar({super.key});

  @override
  State<JuegoParImpar> createState() => _JuegoParImparState();
}

class _JuegoParImparState extends State<JuegoParImpar> {
  String eleccionUsuario = 'Par';
  int numeroUsuario = 0;
  int numeroApp = 0;
  int marcadorUsuario = 0;
  int marcadorApp = 0;

  void jugar() {
    final random = Random();
    numeroApp = random.nextInt(6);
    final suma = numeroUsuario + numeroApp;
    final esPar = suma % 2 == 0;

    setState(() {
      if ((esPar && eleccionUsuario == 'Par') ||
          (!esPar && eleccionUsuario == 'Impar')) {
        marcadorUsuario++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Ganaste! Suma: $suma'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        marcadorApp++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('¡Perdiste! Suma: $suma'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    });
  }

  void reiniciar() {
    setState(() {
      marcadorUsuario = 0;
      marcadorApp = 0;
      numeroUsuario = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego Par/Impar'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.purple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Elige Par o Impar:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: eleccionUsuario,
                      items: const [
                        DropdownMenuItem(value: 'Par', child: Text('Par')),
                        DropdownMenuItem(value: 'Impar', child: Text('Impar')),
                      ],
                      onChanged: (val) {
                        setState(() {
                          eleccionUsuario = val!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Elige un número (0-5):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: List.generate(6, (i) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      numeroUsuario = i;
                    });
                    jugar();
                  },
                  child: Text('$i', style: const TextStyle(fontSize: 20)),
                );
              }),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Text(
                  'Marcador\nUsuario: $marcadorUsuario  -  App: $marcadorApp',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: reiniciar,
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}