import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tresurehunters/components/level.dart';

class TreasureHunters extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    addWorld();
    return super.onLoad();
  }

  @override
  Color backgroundColor() => const Color(0xfff2b882);

  void addWorld() {
    world = Level();
    camera = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 352,
    );
    camera.viewfinder.anchor = Anchor.topLeft;
    add(world);
  }
}
