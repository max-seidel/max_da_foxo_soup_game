class_name Ingredient
extends Node3D


var assigned_shelf: Shelf
var is_in_soup: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    occupy_shelf(Shelf.pick_random(false), true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func occupy_shelf(shelf: Shelf, teleport: bool = false) -> void:
    if shelf.is_occupied:
        printerr("Occupying already occupied shelf ", shelf)
    
    shelf.assign_ingredient(self)
    assigned_shelf = shelf
    is_in_soup = false
    Soup.active.remove_ingredient(self)
    
    animate_towards(shelf.marker, teleport)


func occupy_soup(soup: Soup, teleport: bool = false) -> void:
    soup.assign_ingredient(self)
    assigned_shelf.remove_ingredient()
    assigned_shelf = null
    is_in_soup = true

    animate_towards(soup.marker)


func animate_towards(to: Marker3D, teleport: bool = false) -> void:
    if teleport:
        global_position = to.global_position
        return
    
    var tween: Tween = create_tween()
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.set_trans(Tween.TRANS_CUBIC)
    tween.tween_property(self, "global_position", to.global_position, 1.0)


func interact() -> void:
    if is_in_soup:
        return
    print("Interacted with ", self.name)

    if Soup.active.ingredients.size() >= Soup.MAX_INGREDIENTS:
        print("Soup MAX_INGREDIENTS hit")
        return
    
    occupy_soup(Soup.active, false)
