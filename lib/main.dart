import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Hand {
  rock,
  scissors,
  paper;

  String get text {
    switch (this) {
      case Hand.rock:
        return '✊';
      case Hand.scissors:
        return '✌';
      default:
        return '✋';
    }
  }
}

enum Result {
  win,
  loose,
  draw;

  String get text {
    switch (this) {
      case Result.win:
        return 'Win';
      case Result.loose:
        return 'Loose';
      default:
        return 'Draw';
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String? _playerText;
  String? _computerText;
  String? _judgeText;

  Result _judge(Hand cpu, Hand player) {
    if (cpu == player) {
      return Result.draw;
    }

    if (((cpu == Hand.rock) && (player == Hand.paper)) ||
        ((cpu == Hand.scissors) && (player == Hand.rock)) ||
        ((cpu == Hand.paper) && (player == Hand.scissors))) {
      return Result.win;
    }

    return Result.loose;
  }

  void _chooseHand(Hand player) {
    final cpu = Hand.values[Random().nextInt(3)];
    final res = _judge(cpu, player);

    setState(() {
      _computerText = cpu.text;
      _playerText = player.text;
      _judgeText = res.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Computer',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              _computerText ?? '?',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 24),
            Text(_judgeText ?? ''),
            const SizedBox(height: 24),
            Text(
              _playerText ?? '',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _chooseHand(Hand.rock),
            child: Text(
              Hand.rock.text,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => _chooseHand(Hand.scissors),
            child: Text(
              Hand.scissors.text,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => _chooseHand(Hand.paper),
            child: Text(
              Hand.paper.text,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
