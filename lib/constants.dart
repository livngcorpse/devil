
import 'package:flutter/material.dart';

class GameConstants {
  static const double gravity = 1200; // px/s^2
  static const double playerMoveSpeed = 220; // px/s
  static const double playerJumpSpeed = -520; // px/s (negative up)
  static const double worldWidth = 1600;
  static const double worldHeight = 900;

  // UI
  static const double viewportWidth = 800;
  static const double viewportHeight = 450;

  // Colors
  static const Color bgColor = Color(0xFF0F1020);
  static const Color platformColor = Color(0xFF3E5F8A);
  static const Color playerColor = Color(0xFFF5D76E);
  static const Color doorColor = Color(0xFF93E9BE);
  static const Color spikeHidden = Color(0x77333333);
  static const Color spikeShown = Color(0xFFE74C3C);
  static const Color crusherColor = Color(0xFF9B59B6);
  static const Color reverseZoneColor = Color(0x6682E0FF);
}