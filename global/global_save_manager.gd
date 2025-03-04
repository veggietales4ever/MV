extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [], #any variable, like a chest being open, to be saved
	quests = [],
}

# ==========================
# SAVE GAME FUNCTION
# ==========================
func save_game(player: Player) -> void:
	
	# Ensure we have valid player data
	if not player or not player.stats:
		print("Save failed: Player or PlayerStats  missing.")
		return
		
	_update_player_data(player)
	
	# Save the file
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	print("save game")


# ==========================
# LOAD GAME FUNCTION
# ==========================
func load_game() -> void:
		print("load game")



# ==========================
# UPDATE PLAYER DATA (FOR SAVING)
# ==========================
func _update_player_data(player: Player) -> void:

	# Update player data
	current_save["player"]["hp"] = player.stats.health
	current_save["player"]["max_hp"] = player.stats.health
	current_save["player"]["pos_x"] = player.position.x
	current_save["player"]["pos_y"] = player.position.y
