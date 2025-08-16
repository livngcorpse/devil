import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../constants.dart';
import '../player.dart';

class ReverseZone extends RectangleComponent with CollisionCallbacks {
  final Set<Player> _playersInside = <Player>{};

  ReverseZone({required Vector2 position, required Vector2 size})
      : super(
            position: position,
            size: size,
            paint: Paint()..color = GameConstants.reverseZoneColor);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && !_playersInside.contains(other)) {
      _playersInside.add(other);
      other.incReverse();
    }
    return super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Player && _playersInside.contains(other)) {
      _playersInside.remove(other);
      other.decReverse();
    }
    return super.onCollisionEnd(other);
  }
}
