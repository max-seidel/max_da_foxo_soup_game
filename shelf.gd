class_name Shelf
extends Node3D


@export var marker: Marker3D

static var shelfs: Array[Shelf] = []

static func pick_random(include_occupied: bool) -> Shelf:
    if include_occupied:
        return shelfs.pick_random()

    var unoccupied_shelfs: Array[Shelf] = []
    for shelf: Shelf in shelfs:
        if not shelf.is_occupied:
            unoccupied_shelfs.append(shelf)

    return unoccupied_shelfs.pick_random()

var _ingredient: Ingredient

var is_occupied: bool:
    get():
        return _ingredient != null


func _enter_tree() -> void:
    shelfs.append(self)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func assign_ingredient(ingredient: Ingredient) -> void:
    _ingredient = ingredient

func remove_ingredient() -> void:
    _ingredient = null