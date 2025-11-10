# LottieAnimation API

## Properties

- `animation_path : String` — Path to `.json` or `.lottie` file
- `playing : bool` — Animation playback state
- `autoplay : bool` — Start automatically when ready
- `looping : bool` — Loop when reaching end
- `speed : float` — Playback speed (1.0 = normal)
- `fit_box_size : Vector2i` — Display size
- `offset : Vector2` — Drawing offset for pivot adjustment

## Methods

- `play()` — Start/resume playback
- `stop()` — Stop and reset to frame 0
- `pause()` — Pause at current frame
- `seek(frame: float)` — Jump to specific frame
- `get_frame() -> float` — Current frame
- `get_duration() -> float` — Duration in seconds
- `get_total_frames() -> float` — Total frame count

## Signals

- `animation_finished()` — Emitted when non-looping animation ends
- `frame_changed(frame: float)` — Emitted on frame change
- `animation_loaded(success: bool)` — Emitted after load attempt

## Basic Usage

```gdscript
var lottie = $LottieAnimation
lottie.animation_path = "res://animation.json"
lottie.autoplay = true
lottie.looping = true
```

## Demo Scene

Check out `demo/addons/godot_lottie/demo/controldemo.tscn` for a working example with UI controls:

- **Play/Stop buttons** connected to `LottieAnimation` methods
- **Runtime control** of animation playback
- **Simple setup** showing basic integration

```gdscript
# UI buttons for animation control
@onready var play: Button = $play
@onready var stop: Button = $stop

# Reference to the Lottie animation node  
@onready var lottie: LottieAnimation = $LottieAnimation

func _on_play_pressed() -> void:
    lottie.play()

func _on_stop_pressed() -> void:
    lottie.stop()
```

---

*State Machine API coming soon*