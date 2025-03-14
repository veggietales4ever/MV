extends Node
class_name PlayerInput

# Handles player input

@export var limbo_hsm : LimboHSM
@export var player_actions : PlayerActions
@export var character : CharacterBody2D


var blackboard : Blackboard
var input_direction : Vector2
var jump : bool
var crouch : bool
var faster_fall : bool
var attack : bool
var can_move : bool = true
var has_sword : bool = false

func _ready() -> void:
	blackboard = limbo_hsm.blackboard
	blackboard.bind_var_to_property(BBNames.direction_var, self, "input_direction", false)
	blackboard.bind_var_to_property(BBNames.jump_var, self, "jump", false)
	blackboard.bind_var_to_property(BBNames.crouch_var, self, "crouch", false)
	blackboard.bind_var_to_property(BBNames.attack_var, self, "attack", false)
	

			
func _process(_delta: float) -> void:
	if can_move:
		#input_direction = Input.get_vector(player_actions.left, player_actions.right, player_actions.up, player_actions.down)
		input_direction = Vector2(
			Input.get_axis(player_actions.left, player_actions.right),
			Input.get_axis(player_actions.up, player_actions.down)
		)
		#if Input.is_action_just_pressed(player_actions.jump) && character.is_on_floor():
				#jump = true
		#elif Input.is_action_just_released(player_actions.jump): #and not character.is_on_floor() and character.velocity.y < 0:
			#jump = false
			
		if Input.is_action_pressed(player_actions.down):
			crouch = true
		elif Input.is_action_just_released(player_actions.down):
			crouch = false
		#if has_sword:
		if Input.is_action_just_pressed(player_actions.attack):
			attack = true
			
func _unhandled_input(_event: InputEvent) -> void: #unhandled means if key is handled by something else, we don't want 2 things to be triggered
	if can_move:
		if Input.is_action_just_pressed(player_actions.jump):
			jump = true
		elif Input.is_action_just_released(player_actions.jump): #and not character.is_on_floor() and character.velocity.y < 0:
			jump = false
	#if event.is_action_pressed(player_actions.down):
		#crouch = true
	#elif event.is_action_released(player_actions.down):
		#crouch = false
	pass
		
func _input(_event: InputEvent) -> void:
	pass
		
	
func reset_input_states() -> void:
	input_direction = Vector2.ZERO
	jump = false
	crouch = false
	attack = false
