import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../constants.dart';
import '../../main.dart';
import '../player.dart';

class CeilingCrusher extends RectangleComponent
    with CollisionCallbacks, HasGameRef<RagePlatformerGame> {
  final double startY;
  bool falling = false;
  double speed = 0;
  final double accel = 2400;

  late final RectangleComponent trigger;

  CeilingCrusher({required Vector2 position, required Vector2 size})
      : startY = position.y,
        super(
            position: position,
            size: size,
            paint: Paint()..color = GameConstants.crusherColor);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());

    // Trigger zone just below the crusher
    trigger = RectangleComponent(
      size: Vector2(size.x, 120),
      position: Vector2(0, size.y),
      anchor: Anchor.topLeft,
      paint: Paint()..color = const Color(0x00000000),
    )..add(RectangleHitbox());
    add(trigger);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (falling) {
      speed += accel * dt;
      position.y += speed * dt;
    }
  }

  @override
  bool onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      // lethal touch
      other.position = Vector2(80, 300);
      other.velocity = Vector2.zero();
      return true;
    }
    return false;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // Check if collision is with the trigger zone
    if (other is Player && intersectionPoints.isNotEmpty) {
      // Simple check: if player is below the crusher body, start falling
      final playerCenter = other.position + other.size / 2;
      final crusherBottom = position.y + size.y;

      if (playerCenter.y > crusherBottom) {
        falling = true;
      }
    }
    return super.onCollisionStart(intersectionPoints, other);
  }
}
