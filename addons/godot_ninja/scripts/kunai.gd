@tool
extends Control

class_name Kunai

func _ready():
  pass

func point_left():
  %Left.hide()
  %Right.show()
  
func point_right():
  %Left.show()
  %Right.hide()
