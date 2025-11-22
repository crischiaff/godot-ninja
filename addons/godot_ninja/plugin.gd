@tool
extends EditorPlugin

var main_control = preload("res://addons/godot_ninja/scenes/main_control.tscn")

var main_control_instance

func _enable_plugin():
  print("Godot Ninja enabled")


func _disable_plugin():
  # Remove autoloads here.
  pass


func _enter_tree():
  main_control_instance = main_control.instantiate()
  add_control_to_bottom_panel(main_control_instance, "Godot Ninja")


func _exit_tree():
  remove_control_from_bottom_panel(main_control_instance)
