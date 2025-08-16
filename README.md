😈 Rage Platformer (Flutter + Flame)

A simple 2D rage-bait platformer built with Flutter and Flame game engine, inspired by Level Devil.
This is a starter project to explore how troll mechanics, traps, and rage-inducing level design can be implemented in a structured way.

🎮 Features

Multi-platform: Android, iOS, Web, Desktop

Minimalistic graphics (colored shapes, no assets needed)

Scenes:

Menu Scene → Start Game

Game Scene → Core gameplay (player, platforms, traps, goal door)

Win Scene → Victory screen + restart option

Player movement: Left / Right / Jump

Traps include:

Hidden spikes (appear on step)

Falling platforms (drop after delay)

Ceiling crusher (falls when under it)

Reverse control zones (swap left/right input)

Instant death → restart level

📂 Folder Structure
lib/
├── main.dart                 # Entry point, game initialization
├── constants.dart             # Game-wide constants (gravity, colors, speeds)
├── scenes/
│   ├── menu_scene.dart        # Title + Start button
│   ├── game_scene.dart        # Main level, traps, and logic
│   └── win_scene.dart         # Victory screen
├── components/
│   ├── player.dart            # Player movement, physics, collisions
│   ├── platform.dart          # Static + falling platforms
│   ├── door.dart              # Goal object
│   └── traps/
│       ├── hidden_spike.dart  # Hidden spikes that pop up
│       ├── falling_platform.dart # Falls after short delay
│       ├── ceiling_crusher.dart  # Drops when player below
│       └── reverse_zone.dart  # Swaps controls inside zone

🚀 Getting Started
Prerequisites

Install Flutter (latest stable)

Dart SDK (comes with Flutter)

Installation

Clone the repo or download this project

Navigate into the project folder

cd rage_platformer


Install dependencies

flutter pub get

Run

Mobile (Android/iOS):

flutter run


Web:

flutter run -d chrome


Desktop (Windows/Mac/Linux):

flutter run -d windows   # or macos / linux

🕹️ Controls

Keyboard (desktop/web):

← / → → Move left/right

Space or W → Jump

Touch (mobile):

On-screen left/right buttons

On-screen jump button

🔮 Next Steps / Ideas

Add fake doors that explode

Invisible walls near the goal

Random wind pushing player

Proper sprite art + animations

Sound effects for traps and deaths

📜 License

This project is open-source and free to use for learning and experimentation.