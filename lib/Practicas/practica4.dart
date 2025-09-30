import 'package:flutter/material.dart';

class Practica4 extends StatefulWidget {
  const Practica4({super.key});

  @override
  State<Practica4> createState() => _Practica4State();
}

class _Practica4State extends State<Practica4> {
  int _counter = 0;
  final List<String> _helloList = [];

  void _generateTenHellos() {
    setState(() {
      for (int i = 0; i < 10; i++) {
        _helloList.add('Hola Mundo ${_helloList.length + 1}');
      }
      _counter += 10;
    });
  }

  void _generateSingleHello() {
    setState(() {
      _helloList.add('Hola Mundo ${_helloList.length + 1}');
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _helloList.clear();
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 4'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (_helloList.isNotEmpty)
            IconButton(
              onPressed: _resetCounter,
              icon: const Icon(Icons.refresh),
              tooltip: 'Reiniciar contador',
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _generateTenHellos,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Generar 10 Hola Mundo'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _generateSingleHello,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Generar 1 Hola Mundo'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue[50],
            child: Text(
              'Total de "Hola Mundo": $_counter',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _helloList.isEmpty
                ? const Center(
                    child: Text(
                      'Presiona un botón para generar Hola Mundos',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _helloList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(_helloList[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
