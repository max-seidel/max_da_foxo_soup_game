class_name Soup
extends Node3D

@export var marker: Marker3D

static var active: Soup

const MAX_INGREDIENTS: int = 6

var ingredients: Array[Ingredient] = []

func _enter_tree() -> void:
    if active:
        printerr("No logic for multiple soups here")
    active = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _input(event: InputEvent) -> void:
    if event.is_action("interact"):
        _interact_ingredient(event)


func _interact_ingredient(event: InputEvent) -> void:
    if not event.is_pressed():
        return
    
    var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
    var cam = get_viewport().get_camera_3d()
    var mousepos = get_viewport().get_mouse_position()

    var origin = cam.project_ray_origin(mousepos)
    var end = origin + cam.project_ray_normal(mousepos) * 1000.0
    var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin, end)
    query.collide_with_areas = true
    query.collide_with_bodies = false

    var result = space_state.intersect_ray(query) # Use intersect_ray_into from version 4.8+ instead
    if not result:
        return
    
    var collider: CollisionObject3D = result.collider

    if collider is InteractArea:
        collider.interact.emit()


func assign_ingredient(ingredient: Ingredient) -> void:
    ingredients.append(ingredient)


func remove_ingredient(ingredient: Ingredient) -> void:
    ingredients.erase(ingredient)


func _return_ingredients() -> void:
    for ingredient: Ingredient in ingredients.duplicate():
        ingredient.occupy_shelf(Shelf.pick_random(false), false)
