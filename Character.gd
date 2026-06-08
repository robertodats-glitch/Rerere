# Character.gd
class_name Character # Allows us to use 'Character' as a data type in other scripts
extends RefCounted   # A basic data object that doesn't need a visual presence on screen

var name: String
var max_hp: int
var current_hp: int
var attack_power: int

# Godot's version of __init__ is _init
func _init(p_name: String, p_hp: int, p_attack: int):
	self.name = p_name
	self.max_hp = p_hp
	self.current_hp = p_hp
	self.attack_power = p_attack

func is_alive() -> bool:
	return self.current_hp > 0

func take_damage(damage: int):
	self.current_hp -= damage
	if self.current_hp < 0:
		self.current_hp = 0

func heal(amount: int):
	self.current_hp += amount
	if self.current_hp > self.max_hp:
		self.current_hp = self.max_hp
