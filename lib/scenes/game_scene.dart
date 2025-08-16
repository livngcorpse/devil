import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import '../constants.dart';
import '../main.dart';
import '../components/player.dart';
import '../components/platform.dart';
import '../components/door.dart';
import '../components/traps/hidden_spike.dart';
import '../components/traps/falling_platform.dart';
import '../components/traps/ceiling_crusher.dart';
import '../components/traps/reverse_zone.dart';

class GameScene extends Component
    with HasGameRef<RagePlatformerGame>, HasKeyboardHandlerComponents {
  late final Player player;
  late final World world;
  late final CameraComponent cameraComponent;

  Vector2 spawnPoint = Vector2(80, 300);

  @override
  Future<void> onLoad() async {
    // World and camera
    world = World();
    cameraComponent = CameraComponent(world: world)
      ..viewfinder.visibleGameSize =
          Vector2(GameConstants.viewportWidth, GameConstants.viewportHeight)
      ..viewfinder.position = Vector2(
          GameConstants.viewportWidth / 2, GameConstants.viewportHeight / 2);
    addAll([world, cameraComponent]);

    // Background
    world.add(RectangleComponent(
      size: Vector2(GameConstants.worldWidth, GameConstants.worldHeight),
      position: Vector2.zero(),
      priority: -10,
      paint: Paint()..color = GameConstants.bgColor,
    ));

    // Player
    player = Player(position: spawnPoint.clone());
    world.add(player);

    // Platforms layout (simple, hardcoded)
    final ground =
        PlatformBlock(position: Vector2(0, 400), size: Vector2(1600, 50));
    final ledge1 =
        PlatformBlock(position: Vector2(250, 320), size: Vector2(150, 20));
    final ledge2 =
        PlatformBlock(position: Vector2(500, 260), size: Vector2(150, 20));
    world.addAll([ground, ledge1, ledge2]);

    // Traps
    world.addAll([
      HiddenSpike(position: Vector2(250, 300)),
      FallingPlatform(position: Vector2(700, 300), size: Vector2(120, 20)),
      CeilingCrusher(position: Vector2(980, 100), size: Vector2(60, 60)),
      ReverseZone(position: Vector2(600, 350), size: Vector2(200, 50)),
    ]);

    // Door (goal)
    world.add(Door(position: Vector2(1200, 330)));

    // HUD buttons (mobile)
    add(_makeHud());
  }

  Component _makeHud() {
    final hud = Component(priority: 1000);

    final left = _createButton(
      position: Vector2(20, GameConstants.viewportHeight - 80),
      color: const Color(0xFF34495E),
      onPressed: () => player.moveLeft = true,
      onReleased: () => player.moveLeft = false,
    );

    final right = _createButton(
      position: Vector2(100, GameConstants.viewportHeight - 80),
      color: const Color(0xFF34495E),
      onPressed: () => player.moveRight = true,
      onReleased: () => player.moveRight = false,
    );

    final jump = _createButton(
      position: Vector2(
          GameConstants.viewportWidth - 80, GameConstants.viewportHeight - 80),
      color: const Color(0xFF1ABC9C),
      onPressed: () => player.wantJump = true,
      onReleased: () => player.wantJump = false,
    );

    hud.addAll([left, right, jump]);
    return hud;
  }

  Component _createButton({
    required Vector2 position,
    required Color color,
    required VoidCallback onPressed,
    required VoidCallback onReleased,
  }) {
    return ButtonComponent(
      button: RectangleComponent(
        size: Vector2(60, 60),
        paint: Paint()..color = color,
      ),
      position: position,
      onPressed: onPressed,
      onReleased: onReleased,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Keep camera following player
    cameraComponent.viewfinder.position = player.position + player.size / 2;
    // Simple respawn if falling off world
    if (player.position.y > GameConstants.worldHeight + 200) {
      player.position = spawnPoint.clone();
      player.velocity = Vector2.zero();
    }
  }
}
