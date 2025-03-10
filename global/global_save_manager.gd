extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_health = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [], #any variable, like a chest being already open and remain being opened, to be saved
	quests = [],
}

# ==========================
# SAVE GAME FUNCTION
# ==========================
func save_game() -> void:
	
	## Ensure we have valid player data
	#if not player or not player.stats:
		#print("Save failed: Player or PlayerStats  missing.")
		#return
		
	update_player_data()
	update_scene_path()
	
	# Save the file
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()


# ==========================
# LOAD GAME FUNCTION
# ==========================
func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict :  Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	
	await LevelManager.level_load_started
	
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_health)
	
	await LevelManager.level_loaded
	
	game_loaded.emit()


# ==========================
# UPDATE PLAYER DATA (FOR SAVING)
# ==========================
func update_player_data() -> void:
	var p : Player = PlayerManager.player
	var stats = PlayerManager.player.stats

	current_save.player.hp = stats.health
	current_save.player.max_health = stats.max_health
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y
	
func update_scene_path() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			p = c.scene_file_path
	current_save.scene_path = p
	## Update player data
	#current_save["player"]["hp"] = player.stats.health
	#current_save["player"]["max_hp"] = player.stats.health
	#current_save["player"]["pos_x"] = player.position.x
	#current_save["player"]["pos_y"] = player.position.y
