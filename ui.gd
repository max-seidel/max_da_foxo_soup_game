extends Control


@export var return_ingredients_button: Button


func _enter_tree() -> void:
    return_ingredients_button.pressed.connect(Soup.active._return_ingredients)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
