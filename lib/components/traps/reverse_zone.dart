import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../constants.dart';
import '../player.dart';

class ReverseZone extends RectangleComponent with CollisionCallbacks {
  ReverseZone({required Vector2 position, required Vector2 size})
      : super(
            position: position,
            size: size,
            paint: Paint()..color = GameConstants.reverseZoneColor);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(isSolid: false));
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    super.onCollisionStart(points, other);
    if (other is Player) {
      other.incReverse();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Player) {
      other.decReverse();
    }
  }
}
