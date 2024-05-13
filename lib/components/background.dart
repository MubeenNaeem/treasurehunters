import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class Background extends ParallaxComponent {
  double scrollSpeed = 40;

  @override
  void onLoad() async {
    priority = -10;
    size = Vector2.all(32);
    parallax = await game.loadParallax(
      [
        ParallaxImageData('Backgrounds/Brown.png'),
      ],
      baseVelocity: Vector2(0, -scrollSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );
    super.onLoad();
  }
}
