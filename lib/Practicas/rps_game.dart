import 'dart:math';
import 'package:flutter/material.dart';

class RPSGameScreen extends StatefulWidget {
  const RPSGameScreen({super.key});
  @override
  State<RPSGameScreen> createState() => _RPSGameScreenState();
}

class _RPSGameScreenState extends State<RPSGameScreen> {
  int userScore = 0, deviceScore = 0;
  String gameResult = '';

  void playGame(String userChoice) {
    const choices = ['Piedra', 'Papel', 'Tijera'];
    final deviceChoice = choices[Random().nextInt(3)];
    String result = userChoice == deviceChoice
        ? 'Empate'
        : (userChoice == 'Piedra' && deviceChoice == 'Tijera') ||
                (userChoice == 'Papel' && deviceChoice == 'Piedra') ||
                (userChoice == 'Tijera' && deviceChoice == 'Papel')
            ? '¡Ganaste!'
            : 'Perdiste';
    setState(() {
      if (result == '¡Ganaste!') userScore++;
      if (result == 'Perdiste') deviceScore++;
      gameResult = 'Tú: $userChoice\nDispositivo: $deviceChoice\n$result';
    });
  }

  void resetScore() => setState(() {
        userScore = deviceScore = 0;
        gameResult = '';
      });

  @override
  Widget build(BuildContext context) {
    const options = [
      ['Piedra', '🪨'],
      ['Papel', '📄'],
      ['Tijera', '✂️'],
    ];
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Piedra, Papel o Tijera',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: options
                  .map(
                    (opt) => ElevatedButton(
                      onPressed: () => playGame(opt[0]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(70, 70),
                      ),
                      child: Column(
                        children: [
                          Text(opt[1], style: const TextStyle(fontSize: 25)),
                          Text(opt[0], style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  gameResult.isEmpty ? '¡Elige!' : gameResult,
                  style: TextStyle(
                    fontSize: 14,
                    color: gameResult.contains('Ganaste')
                        ? Colors.green.shade600
                        : gameResult.contains('Perdiste')
                            ? Colors.red.shade600
                            : gameResult.contains('Empate')
                                ? Colors.grey.shade600
                                : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Usuario $userScore - $deviceScore Dispositivo',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: resetScore,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade600,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Reiniciar', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
