extends Node2D

@onready var label: Label = $Panel/Label

var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"

var playerData = PlayerData.new()



func _ready() -> void:
	verify_save_directory(save_file_path)
	update_label()
	
	
func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

func update_label():
	label.text = "Player Health : " + str(playerData.health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_load_button_pressed() -> void:
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	update_label()


func _on_save_button_pressed() -> void:
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	update_label()


func _on_change_health_pressed() -> void:
	playerData.change_health(-5)
	update_label()
