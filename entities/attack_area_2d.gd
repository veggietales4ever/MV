extends Area2D
class_name AttackArea2D

@export var damage : int = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(p_body : Node2D):
	if p_body is Character:
		#p_body.hit(damage)
		var damage_dealth = p_body.hit(damage)
		print("dealt %s damage to %s" % [damage_dealth, p_body.name])
		#if not PlayerManager.invulnerable:
			#PlayerManager.player.take_damage(global_position)

#func _on_hitbox_body_entered(body: Node2D) -> void:
	#pass
	#if body.name == "Player":
		#player_inside = true
		#var player = PlayerManager.player
		#if not PlayerManager.invulnerable:
			#player_data.life -= 1
			#PlayerManager.player.take_damage(global_position)
