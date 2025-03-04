extends CanvasLayer

@onready var button_save: Button = $VBoxContainer/Button_Save
@onready var button_load: Button = $VBoxContainer/Button_Load

var is_paused : bool = false
var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)
	
	pass # Replace with function body.


# take any key presses that haven't been handled by another script previously, and will check.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()
		
func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	button_save.grab_focus()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false

func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game(player)
	hide_pause_menu()
	
func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	hide_pause_menu()
