extends Node2D

@export var rotation_amount: float = 22.5

@onready var rotation_rads = deg_to_rad(rotation_amount)

func rotate_shooters():
	self.rotate(rotation_rads)
