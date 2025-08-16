import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../constants.dart';
import '../main.dart';
import 'player.dart';

class Door extends RectangleComponent
    with CollisionCallbacks, HasGameRef<RagePlatformerGame> {
  Door({required Vector2 position})
      : super(
          position: position,
          size: Vector2(40, 70),
          paint: Paint()..color = GameConstants.doorColor,
        );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  bool onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      gameRef.goToWin();
      return true;
    }
    return false;
  }
}
