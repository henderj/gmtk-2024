extends Node2D
class_name HealthComponent

signal died
signal changed(old_amount: float, new_amount: float)

@export var MAX_HEALTH: float = 10.0
@export var remove_on_died: bool = false
@export var invincible: bool = false

var health: float
var alive: bool

func _ready():
    alive = true
    health = MAX_HEALTH

func damage(amount: float):
    if not alive:
        health = 0
        return
    if invincible:
        return
    var old_amount = health
    health -= amount
    changed.emit(old_amount, health)
    if health <= 0:
        health = 0
        alive = false
        died.emit()
        if remove_on_died:
            get_parent().queue_free()
