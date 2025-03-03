extends CharacterBody2D
class_name Enemy

@export var bt_player : BTPlayer
@export var animation_player : AnimationPlayer
@export var sprite_2d : Sprite2D
@export var stats : CharacterStats :
	set(value):
		if value:  # Ensure value is not null before duplicating
			stats = value.duplicate() # for each active character, it's gonna have it's own stats. they're not going to share resource directly or else they all die at same time

var blackboard : Blackboard
var health : CharacterStats :
	set(value):
		health = value


func _ready():
	blackboard = bt_player.blackboard
	# Bind the blackboard variable to the health property
	blackboard.bind_var_to_property(BBNames.health_var, stats, "health", true)
	
	if stats == null:
		print("Error: stats is null!")
		stats = CharacterStats.new()  # Initialize a new instance if stats isn't assigned

	
	if blackboard == null:
		print("Error: blackboard is null in _ready()!")
		return  # Stop execution if the blackboard isn't available
	

	# Force update in case binding doesn't immediately propagate
	blackboard.set(BBNames.health_var, stats.health)
	print("Initial health set in blackboard:", blackboard.get(BBNames.health_var))



func hit(p_damage : int):
	stats.health -= p_damage
	

	# Check if blackboard is valid before setting health
	if blackboard == null:
		print("Error: blackboard is null in hit()!")
		blackboard = bt_player.blackboard  # Try reassigning
		
	if blackboard != null:
		blackboard.set(BBNames.health_var, stats.health)
		print(stats.health)
	
