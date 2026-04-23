import 'package:flutter/material.dart';
import 'features/cono_arena/presentation/pages/cono_arena_page.dart';

void main() {
  runApp(const CivilCalcApp());
}

class CivilCalcApp extends StatelessWidget {
  const CivilCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivilCalc',
      debugShowCheckedModeBanner: false,
      home: const ConoArenaPage(),
    );
  }
}