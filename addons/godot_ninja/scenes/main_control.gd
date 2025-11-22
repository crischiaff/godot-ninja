@tool
extends Control

@onready var viewport = %NinjaViewport
@onready var texture_rect = %NinjaTexture

var kunai_scene = preload("res://addons/godot_ninja/scenes/kunai.tscn")
var kunai_scene_instance: Kunai = null


@export var steps: Array[Step] = []


var current_step = 0

func _ready():
  %Next.pressed.connect(_on_next_step)
  %Prev.pressed.connect(_on_prev_step)
  _render_current_step()
  
  #highlight_scene_instance.
  #get_tree().root.add_child(highlight_scene.instantiate())

func _enter_tree():
  pass
    
func _exit_tree():
  _clear_kunai()
    
func _on_next_step():
  if current_step < steps.size() -1:
    current_step += 1
    _render_current_step()
  
func _on_prev_step():
  if current_step > 0:  
    current_step -= 1
    _render_current_step()
    
func _show_kunai():
  var step = steps[current_step]
  var at = step.indicator
  var base = EditorInterface.get_base_control()
  match at:
    GodotNinja.Indicators.INSPECTOR:
      var inspector = EditorInterface.get_inspector()
      
      if inspector:
        var rect = inspector.get_global_rect()
        var posizione_inspector = rect.position # La posizione (Vector2) in coordinate dello schermo
        var dimensione_inspector = rect.size    # La dimensione (Vector2) dell'Inspector
        
        # Esempio per il centro dell'Inspector:
        #var centro_inspector = posizione_inspector + dimensione_inspector / 2
        kunai_scene_instance = kunai_scene.instantiate()
        base.add_child(kunai_scene_instance)
        
        kunai_scene_instance.global_position = posizione_inspector
        kunai_scene_instance.point_right()
    GodotNinja.Indicators.SCENE:
      var scene = EditorInterface.get_editor_main_screen()
      if scene:
        var rect = scene.get_global_rect()
        var posizione_inspector = rect.position # La posizione (Vector2) in coordinate dello schermo
        var dimensione_inspector = rect.size    # La dimensione (Vector2) dell'Inspector
        
        # Esempio per il centro dell'Inspector:
        #var centro_inspector = posizione_inspector + dimensione_inspector / 2
        kunai_scene_instance = kunai_scene.instantiate()
        base.add_child(kunai_scene_instance)
        
        kunai_scene_instance.global_position = posizione_inspector + Vector2(20, 0)
        kunai_scene_instance.point_right()
    GodotNinja.Indicators.SCENE_TREE:
      var scene = EditorInterface.get_editor_main_screen()
      if scene:
        var rect = scene.get_global_rect()
        var posizione_inspector = rect.position # La posizione (Vector2) in coordinate dello schermo
        var dimensione_inspector = rect.size    # La dimensione (Vector2) dell'Inspector
        
        # Esempio per il centro dell'Inspector:
        #var centro_inspector = posizione_inspector + dimensione_inspector / 2
        kunai_scene_instance = kunai_scene.instantiate()
        base.add_child(kunai_scene_instance)
        
        kunai_scene_instance.global_position = posizione_inspector + Vector2(-20, 0)
        kunai_scene_instance.point_left()
    GodotNinja.Indicators.FILESYSTEM:
      var scene = EditorInterface.get_file_system_dock()
      if scene:
        var rect = scene.get_global_rect()
        var posizione_inspector = rect.position # La posizione (Vector2) in coordinate dello schermo
        var dimensione_inspector = rect.size    # La dimensione (Vector2) dell'Inspector
        
        # Esempio per il centro dell'Inspector:
        #var centro_inspector = posizione_inspector + dimensione_inspector / 2
        kunai_scene_instance = kunai_scene.instantiate()
        base.add_child(kunai_scene_instance)
        
        kunai_scene_instance.global_position = posizione_inspector + Vector2(rect.size.x -20, 0)
        kunai_scene_instance.point_left()

    
func _clear_kunai():
  if (kunai_scene_instance):
    kunai_scene_instance.queue_free()
    
func _clear_code():
  %Code.text = "# Nessun codice da mostrare"
  
func _show_code():
  var step = steps[current_step]
  if step.code != "":
    %Code.text = step.code
    
func _refresh_buttons():
  var step = steps[current_step]
  %StepText.text = step.text
  if current_step == 0:
    %Prev.disabled = true
  else:
    %Prev.disabled = false
    
  if current_step >= steps.size() - 1:
    %Next.disabled = true
  else:
    %Next.disabled = false
  
func _render_current_step():
  _clear_kunai()
  _clear_code()
  _refresh_buttons()
  _show_kunai()
  _show_code()
    
  
