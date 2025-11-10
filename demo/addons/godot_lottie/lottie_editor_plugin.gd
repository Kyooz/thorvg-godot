@tool
extends EditorPlugin

var lottie_dock: Control
var inspector_plugin: EditorInspectorPlugin

func _enter_tree():
	var icon: Texture2D = null
	var svg_path := "res://src/lottieico.svg"
	
	if ResourceLoader.exists(svg_path, "Texture2D"):
		icon = load(svg_path)
	
	if icon == null:
		icon = get_editor_interface().get_base_control().get_theme_icon("Node2D", "EditorIcons")

	add_custom_type(
		"LottieAnimation",
		"Node2D",
		preload("res://addons/godot_lottie/lottie_animation_script.gd"),
		icon
	)
	
	print("Godot Lottie plugin enabled")

func _exit_tree():
	remove_custom_type("LottieAnimation")
	
	if lottie_dock:
		remove_control_from_docks(lottie_dock)
		lottie_dock.queue_free()

	if inspector_plugin:
		remove_inspector_plugin(inspector_plugin)
	
	print("Godot Lottie plugin disabled")

func _handles(object):
	return object is LottieAnimation

func _make_visible(visible):
	if lottie_dock:
		lottie_dock.visible = visible
