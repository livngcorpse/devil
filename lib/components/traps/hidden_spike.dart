import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../constants.dart';
import '../player.dart';

class HiddenSpike extends RectangleComponent with CollisionCallbacks {
  bool revealed = false;
  double revealDelay = 0.05; // seconds after touch
  double timer = 0;

  HiddenSpike({required Vector2 position, Vector2? size})
      : super(
          position: position,
          size: size ?? Vector2(50, 20),
          paint: Paint()..color = GameConstants.spikeHidden,
        );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!revealed && timer > 0) {
      timer -= dt;
      if (timer <= 0) {
        revealed = true;
        paint = Paint()..color = GameConstants.spikeShown;
      }
    }
  }

  @override
  bool onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      if (!revealed) {
        timer = revealDelay;
      } else {
        // simple respawn handled by scene; here we just signal by moving player to a known spawn
        other.position = Vector2(80, 300);
        other.velocity = Vector2.zero();
      }
      return true;
    }
    return false;
  }
}
