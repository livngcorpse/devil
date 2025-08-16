import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import '../constants.dart';
import '../main.dart';
import 'menu_scene.dart';

class WinScene extends Component
    with HasGameRef<RagePlatformerGame>, TapCallbacks {
  late final RectangleComponent playAgain;
  @override
  Future<void> onLoad() async {
    add(Background());
    add(TextComponent(
      text: 'You Win!',
      anchor: Anchor.center,
      position: Vector2(GameConstants.viewportWidth / 2,
          GameConstants.viewportHeight / 2 - 60),
      priority: 1,
    ));
    playAgain = RectangleComponent(
      size: Vector2(220, 64),
      position: Vector2(GameConstants.viewportWidth / 2 - 110,
          GameConstants.viewportHeight / 2),
      paint: Paint()..color = const Color(0xFF2ECC71),
      priority: 1,
    );
    add(playAgain);
    add(TextComponent(
      text: 'Play Again',
      anchor: Anchor.center,
      position: playAgain.position + playAgain.size / 2,
      priority: 2,
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    final p = event.localPosition;
    if (playAgain.toRect().contains(Offset(p.x, p.y))) {
      gameRef.goToGame();
    }
  }
}
