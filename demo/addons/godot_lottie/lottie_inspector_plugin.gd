@tool
extends EditorInspectorPlugin

func _can_handle(object):
	return object.get_class() == "LottieAnimation" or object is LottieAnimationWrapper

func _parse_begin(object):
	pass

func _parse_category(object, category):
	pass

func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	return false
