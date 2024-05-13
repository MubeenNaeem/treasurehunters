import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tresurehunters/level.dart';

class TreasureHunters extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    addWorld();
    return super.onLoad();
  }

  @override
  Color backgroundColor() => Color(0xff3e3e60);

  void addWorld() {
    world = Level();
    camera = CameraComponent.withFixedResolution(
      world: world,
      width: 960,
      height: 640,
    );
    camera.viewfinder.anchor = Anchor.topLeft;
    add(world);
  }
}
