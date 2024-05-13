import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tresurehunters/game.dart';

void main() {
  final game = TreasureHunters();
  runApp(
    GameWidget(game: game),
  );
}
