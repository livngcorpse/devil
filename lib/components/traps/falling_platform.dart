
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../constants.dart';
import '../player.dart';

class FallingPlatform extends RectangleComponent with CollisionCallbacks {
  bool triggered = false;
  bool lethal = false;
  double delay = 0.4;
  double fallSpeed = 0;
  double gravity = 1500;

  FallingPlatform({required Vector2 position, required Vector2 size})
      : super(position: position, size: size, paint: Paint()..color = const Color(0xFF8E9BAE));

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox()); // starts solid
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (triggered) {
      delay -= dt;
      if (delay <= 0) {
        fallSpeed += gravity * dt;
        position.y += fallSpeed * dt;
        lethal = true;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Player) {
      if (!triggered) {
        // Land like a normal platform until it drops
        final playerBottomPrev = other.lastPosition.y + other.size.y;
        if (playerBottomPrev <= position.y && other.velocity.y >= 0) {
          other.landOnTop(position.y);
          triggered = true;
        }
      } else if (lethal) {
        // If already falling, touching it is lethal
        other.position = Vector2(80, 300);
        other.velocity = Vector2.zero();
      }
    }
  }
}