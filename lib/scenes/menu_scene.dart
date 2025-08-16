import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../main.dart';
import '../constants.dart';

class MenuScene extends Component
    with HasGameRef<RagePlatformerGame>, TapCallbacks {
  late final RectangleComponent startButton;
  late final TextComponent title;

  @override
  Future<void> onLoad() async {
    add(Background());
    title = TextComponent(
      text: 'Totally Not a Troll Game',
      anchor: Anchor.topCenter,
      position: Vector2(GameConstants.viewportWidth / 2, 40),
      priority: 1,
    );
    add(title);

    startButton = RectangleComponent(
      size: Vector2(220, 64),
      position: Vector2(GameConstants.viewportWidth / 2 - 110,
          GameConstants.viewportHeight / 2 - 32),
      priority: 1,
      paint: Paint()..color = const Color(0xFF2ECC71),
    );
    add(startButton);

    add(TextComponent(
      text: 'START',
      anchor: Anchor.center,
      position: startButton.position + startButton.size / 2,
      priority: 2,
    ));
  }

  @override
  bool onTapDown(TapDownEvent event) {
    final p = event.localPosition;
    final r = startButton.toRect();
    if (r.contains(Offset(p.x, p.y))) {
      gameRef.goToGame();
    }
    return true;
  }
}

class Background extends RectangleComponent {
  Background()
      : super(
          size: Vector2(
              GameConstants.viewportWidth, GameConstants.viewportHeight),
          position: Vector2.zero(),
          priority: -10,
          paint: Paint()..color = GameConstants.bgColor,
        );
}
