import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import '../main.dart';

class Player extends RectangleComponent
    with CollisionCallbacks, KeyboardHandler, HasGameRef<RagePlatformerGame> {
  Vector2 velocity = Vector2.zero();
  bool moveLeft = false, moveRight = false, wantJump = false;
  bool onGround = false;
  bool reversed = false;
  int reverseOverlap = 0;
  Vector2 lastPosition = Vector2.zero();

  Player({required Vector2 position})
      : super(
          position: position,
          size: Vector2(32, 40),
          paint: Paint()..color = GameConstants.playerColor,
        );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  void incReverse() {
    reverseOverlap++;
    reversed = reverseOverlap > 0;
  }

  void decReverse() {
    reverseOverlap = (reverseOverlap - 1).clamp(0, 999);
    reversed = reverseOverlap > 0;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    moveLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA);
    moveRight = keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD);
    wantJump = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    lastPosition.setFrom(position);

    // Horizontal input (reversible)
    double dir = (moveRight ? 1 : 0) - (moveLeft ? 1 : 0);
    if (reversed) dir = -dir;
    velocity.x = dir * GameConstants.playerMoveSpeed;

    // Gravity
    velocity.y += GameConstants.gravity * dt;

    // Jump
    if (wantJump && onGround) {
      velocity.y = GameConstants.playerJumpSpeed;
      onGround = false;
    }

    // Apply movement
    position += velocity * dt;
  }

  // Helpers called by platforms when resolving collisions.
  void landOnTop(double topY) {
    position.y = topY - size.y;
    velocity.y = 0;
    onGround = true;
  }

  void bumpHead(double bottomY) {
    position.y = bottomY;
    if (velocity.y < 0) velocity.y = 0;
  }

  void pushSide(double x) {
    position.x = x;
    velocity.x = 0;
  }
}
