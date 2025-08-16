
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'scenes/menu_scene.dart';
import 'scenes/game_scene.dart';
import 'scenes/win_scene.dart';

void main() {
  runApp(const RageApp());
}

class RageApp extends StatelessWidget {
  const RageApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = RagePlatformerGame();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(game: game),
      ),
    );
  }
}

class RagePlatformerGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, TapCallbacks {
  late final RouterComponent router;

  RagePlatformerGame() : super(priority: 0);

  @override
  Future<void> onLoad() async {
    camera.viewport = FixedResolutionViewport(Vector2(
        GameConstants.viewportWidth, GameConstants.viewportHeight));
    add(ScreenHitbox()); // for HUD taps if needed

    router = RouterComponent(
      initialRoute: 'menu',
      routes: {
        'menu': Route(() => MenuScene()),
        'game': Route(() => GameScene()),
        'win' : Route(() => WinScene()),
      },
    );
    add(router);
  }

  void goToMenu() => router.pushReplacementNamed('menu');
  void goToGame() => router.pushReplacementNamed('game');
  void goToWin()  => router.pushReplacementNamed('win');
}