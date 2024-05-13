import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tresurehunters/components/collision_block.dart';
import 'package:tresurehunters/components/player.dart';

class Level extends World {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    await loadLevel();
    initCollisions();
    spawnItems();
    return super.onLoad();
  }

  Future<void> loadLevel() async {
    level = await TiledComponent.load(
      'level-01.tmx',
      Vector2.all(32),
    );
    add(level);
  }

  void initCollisions() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');
    if (collisionsLayer != null) {
      for (final item in collisionsLayer.objects) {
        final collisions = CollisionBlock(
          position: Vector2(item.x, item.y),
          size: Vector2(item.width, item.height),
        );
        add(collisions);
      }
    }
  }

  void spawnItems() {
    final spawnLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');
    if (spawnLayer != null) {
      for (final item in spawnLayer.objects) {
        switch (item.class_) {
          case 'Player':
            final player = Player(
              position: Vector2(item.x, item.y),
              size: Vector2(item.width, item.height),
            );
            add(player);
        }
      }
    }
  }
}
