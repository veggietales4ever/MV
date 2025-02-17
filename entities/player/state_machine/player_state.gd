extends Node
class_name State

var MAX_SPEED = 8000
var ACCELERATION = 1200
const SPEED = 100

#Reference to the player node that is controlled by this state
var player
var states
var current_state


func _init() -> void:
	states = {
		"idle": ,
		"run": ,
	}
# Called when entering this state.
func enter_state(player_node):
	# Store the reference to the player node
	player = player_node
	
# Called when exiting this state.
func exit_state():
	pass
	
func handle_input(_delta):
	pass
