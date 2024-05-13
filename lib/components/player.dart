import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:tresurehunters/components/collision_block.dart';
import 'package:tresurehunters/game.dart';

enum PlayerState { idle, run, jump, fall }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<TreasureHunters>, KeyboardHandler, CollisionCallbacks {
  Player({super.position, super.size});

  final playerBox = RectangleHitbox(
    size: Vector2(32, 50),
    position: Vector2(32, 5),
  );

  Vector2 velocity = Vector2.zero();
  int horizontalDirection = 0;
  double horizontalSpeed = 200;
  double jumpingSpeed = -400;
  double gravity = 10;
  double terminalVelocity = 300;

  bool isMoving = false;
  bool isOnGround = true;
  bool hasJumped = false;

  @override
  void onLoad() {
    debugMode = true;
    // add hit box
    add(playerBox);

    // all player animations
    animations = {
      PlayerState.idle: playerSprite('01-Idle', 5),
      PlayerState.run: playerSprite('02-Run', 6),
      PlayerState.jump: playerSprite('03-Jump', 3),
      PlayerState.fall: playerSprite('04-Fall', 1),
    };

    // setting current animation
    current = PlayerState.idle;
    super.onLoad();
  }

  @override
  void update(double dt) {
    updatePlayerState();
    updatePlayerMovement(dt);
    return super.update(dt);
  }

  void updatePlayerState() {
    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    current = PlayerState.idle;

    if (velocity.x > 0 || velocity.x < 0) current = PlayerState.run;
    if (velocity.y > 0) current = PlayerState.fall;
    if (velocity.y < 0) current = PlayerState.jump;
  }

  void updatePlayerMovement(double dt) {
    if (hasJumped && isOnGround) jump(dt);
    if (!hasJumped && !isOnGround) fall(dt);

    velocity.x = horizontalDirection * horizontalSpeed;
    position.x += velocity.x * dt;
  }

  void jump(double dt) {
    velocity.y = jumpingSpeed;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  void fall(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(jumpingSpeed, terminalVelocity);
    position.y += velocity.y * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CollisionBlock) {
      isOnGround = true;
      velocity.y = 0;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    final leftArrow = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final rightArrow = keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalDirection += leftArrow ? -1 : 0;
    horizontalDirection += rightArrow ? 1 : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);
    return super.onKeyEvent(event, keysPressed);
  }

  SpriteAnimation playerSprite(String animationPath, int count) {
    return SpriteAnimation.spriteList(
      List.generate(
        count,
        (i) => Sprite(
          game.images.fromCache(
            '$path/$animationPath/'
            '${animationPath.split('-')[1]} '
            '${(i + 1).toString().padLeft(2, '0')}'
            '.png',
          ),
        ),
      ),
      stepTime: 0.1,
    );
  }
}

const path =
    'Captain Clown Nose/Sprites/Captain Clown Nose/Captain Clown Nose without Sword';
