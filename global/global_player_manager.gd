extends Node

const PLAYER = preload("res://entities/player/player.tscn")
const INVENTORY_DATA : InventoryData = preload("res://UI/PauseMenu/Inventory/player_inventory.tres")

var player_spawned : bool = false
var player: Player

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	
#func register_player(new_player: Player):
	#player = new_player

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	
func set_health(hp: int, max_health: int) -> void:
	player.stats.max_health = max_health
	player.stats.health = hp
	#player.update_hp(0)
	
	
func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	
	
func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
		_p.add_child(player)
		
func unparent_player(_p : Node2D) -> void:
	_p.remove_child(player)
