# MainBattle.gd
extends Node

# Connect these to your UI elements in the Godot Inspector
@onready var battle_log_label = $BattleLogLabel
@onready var player_hp_label = $PlayerHPLabel
@onready var enemy_hp_label = $EnemyHPLabel
@onready var attack_button = $AttackButton
@onready var heal_button = $HealButton

var player: Character
var enemy: Character
var turn: int = 1

func _ready():
	# This runs automatically when the game starts (replaces main())
	battle_log_label.text = "=== WELCOME TO THE RELAY RPG ===\nPrepare for battle!"
	
	player = Character.new("Hero", 100, 15)
	enemy = Character.new("Slime", 50, 8)
	
	update_ui_displays()

func update_ui_displays():
	player_hp_label.text = "[%s] HP: %d/%d" % [player.name, player.current_hp, player.max_hp]
	enemy_hp_label.text = "[%s] HP: %d/%d" % [enemy.name, enemy.current_hp, enemy.max_hp]

# Godot UI buttons use "signals" when clicked. 
# You hook these functions up to your UI buttons.

func _on_attack_button_pressed():
	disable_buttons(true)
	
	# Player Turn: Attack
	var damage = player.attack_power
	enemy.take_damage(damage)
	battle_log_label.text = "You strike the %s for %d damage!" % [enemy.name, damage]
	update_ui_displays()
	
	# Dramatic Pause then Enemy Turn
	await get_tree().create_timer(1.0).timeout
	check_battle_state()

func _on_heal_button_pressed():
	disable_buttons(true)
	
	# Player Turn: Heal
	var heal_amount = 20
	player.heal(heal_amount)
	battle_log_label.text = "You heal yourself for %d HP!" % heal_amount
	update_ui_displays()
	
	# Dramatic Pause then Enemy Turn
	await get_tree().create_timer(1.0).timeout
	check_battle_state()

func check_battle_state():
	if not enemy.is_alive():
		battle_log_label.text = "\n=== BATTLE OVER ===\nYou won! ...But what lurks ahead?"
		return
		
	# Enemy Turn Logic
	battle_log_label.text = "The %s attacks!" % enemy.name
	await get_tree().create_timer(0.5).timeout
	
	var enemy_damage = enemy.attack_power
	player.take_damage(enemy_damage)
	battle_log_label.text = "The %s deals %d damage to you!" % [enemy.name, enemy_damage]
	update_ui_displays()
	
	await get_tree().create_timer(1.0).timeout
	
	if not player.is_alive():
		battle_log_label.text = "\n=== BATTLE OVER ===\nYou were defeated. Game Over."
	else:
		turn += 1
		battle_log_label.text = "--- TURN %d ---" % turn
		disable_buttons(false) # Give player their turn back

func disable_buttons(setting: bool):
	attack_button.disabled = setting
	heal_button.disabled = setting
