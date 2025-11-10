extends Node2D

# UI buttons for animation control
@onready var play: Button = $play
@onready var stop: Button = $stop

# Reference to the Lottie animation node
@onready var lottie: LottieAnimation = $LottieAnimation

# Start/resume animation when play button is pressed
func _on_play_pressed() -> void:
	lottie.play()

# Stop animation and reset to frame 0 when stop button is pressed (maybe it can stop at the current frame, I'm not sure)
func _on_stop_pressed() -> void:
	lottie.stop()
