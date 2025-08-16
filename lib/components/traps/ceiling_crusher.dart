import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../constants.dart';
import '../../main.dart'; // Add this import
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
    add(RectangleHitbox(isSolid: false)); // lethal body

    // Trigger zone just below the crusher
    trigger = RectangleComponent(
      size: Vector2(size.x, 120),
      position: Vector2(0, size.y),
      anchor: Anchor.topLeft,
      paint: Paint()..color = const Color(0x00000000),
    )..add(RectangleHitbox(isSolid: false));
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
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    super.onCollisionStart(points, other);
    if (other is Player) {
      // lethal touch
      other.position = Vector2(80, 300);
      other.velocity = Vector2.zero();
    }
  }

  @override
  void onChildrenCollisionStart(
      PositionComponent child, Set<Vector2> points, PositionComponent other) {
    super.onChildrenCollisionStart(child, points, other);
    if (child == trigger && other is Player) {
      falling = true;
    }
  }
}
