extends Area2D
class_name DetectionZone

@export var bt_player : BTPlayer

var blackboard : Blackboard
var target : Character :
	set(value):
		target = value
		# prints("New target %s on %s" % [target, name])

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	blackboard = bt_player.blackboard
	blackboard.bind_var_to_property(BBNames.target_var, self, "target", true)
	
# When any node enters, this event triggers. check if character
func _on_body_entered(p_body : Node2D):
	if p_body is Character:
		target = p_body
		
func _on_body_exited(p_body : Node2D):
	if target == p_body:
		target = null
