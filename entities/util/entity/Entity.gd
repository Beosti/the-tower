class_name Entity
extends CharacterBody2D

var maxHealth: int = 0: set = _set_maxHealth;
var health: int = 0: set = _set_health;
var speed: int = 0: set = _set_speed;


func _set_maxHealth(new_value : int):
	maxHealth = new_value;
func _set_health(new_value : int):
	health = new_value;
func _set_speed(new_value : int):
	speed = new_value;

var clickable: bool;

func _on_mouse_entered():
	clickable = true;
func _on_mouse_exited():
	clickable = false;
