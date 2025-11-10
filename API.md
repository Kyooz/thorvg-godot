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

---

*State Machine API coming soon*