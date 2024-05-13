import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  CollisionBlock({super.position, super.size});

  @override
  void onLoad() {
    add(RectangleHitbox());
    super.onLoad();
  }
}
