import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../constants.dart';
import 'player.dart';

class PlatformBlock extends RectangleComponent with CollisionCallbacks {
  PlatformBlock({required Vector2 position, required Vector2 size})
      : super(
            position: position,
            size: size,
            paint: Paint()..color = GameConstants.platformColor);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox()); // solid by convention
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Player) {
      final player = other;
      // Determine collision side using player's last position
      final playerBottomPrev = player.lastPosition.y + player.size.y;
      final playerTopPrev = player.lastPosition.y;
      final myTop = position.y;
      final myBottom = position.y + size.y;
      final myLeft = position.x;
      final myRight = position.x + size.x;
      final playerLeftPrev = player.lastPosition.x;
      final playerRightPrev = player.lastPosition.x + player.size.x;

      // Landing on top
      if (playerBottomPrev <= myTop && player.velocity.y >= 0) {
        player.landOnTop(myTop);
      }
      // Hitting from below
      else if (playerTopPrev >= myBottom && player.velocity.y < 0) {
        player.bumpHead(myBottom);
      }
      // Side push
      else if (playerRightPrev <= myLeft && player.velocity.x > 0) {
        player.pushSide(myLeft - player.size.x);
      } else if (playerLeftPrev >= myRight && player.velocity.x < 0) {
        player.pushSide(myRight);
      }
    }
  }
}
