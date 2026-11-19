class_name InteractArea
extends Area3D

## A node that has a method interact()
@export var notify: Node

signal interact()

func _enter_tree() -> void:
    interact.connect(_propagate_interaction)


func _propagate_interaction() -> void:
    notify.interact()