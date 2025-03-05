extends Enemy
class_name SlimeEnemy

#signal enemy_damaged()

const gravity = 30 

@onready var invulnerability_timer: Timer = $Timers/InvulnerabilityTimer
@onready var detection_zone: DetectionZone = $DetectionZone

var invulnerable : bool = false
var is_hurt := false
var is_knocked_back := false
var knockback_force := 1000
var knockback_duration := 0.7
var invulnerability_duration := 3.0

		
func _physics_process(_delta: float) -> void:
	if is_on_wall() and is_on_floor():
		velocity.y = -stats.jump_velocity
	else:
		velocity.y += gravity
		
	move_and_slide()
	


func move(target_pos : Vector2, _delta : float):
	var direction = Vector2(
		target_pos.x - global_position.x,
		0
	).normalized()
	
	velocity.x = direction.x * stats.run_speed
	
	update_flip(direction.x)
	

func check_for_self(node):
	if node == self:
		return true
	else:
		return false

func update_flip(dir : float):
	sprite_2d.flip_h = dir < 0
	detection_zone.scale.x = -1 if dir < 0 else 1
	
	
#func damage(amount: int):
	#print("Enemy Took damage:", amount)
	#if invulnerable or is_knocked_back:
		#return # Don't take damage if invulnerable
		#
		#
	#stats.health -= amount # Subtract health
	#emit_signal("enemy_damaged") # Emit signal if needed
	#
	#if stats.health <= 0:
		#emit_signal(stats.health_depleted)
		#explode()
		#queue_free()
		#return
	## States
	#is_knocked_back = true
	#invulnerable = true
	#
func explode():
	var explosion_scene = preload("res://particles/explosion.tscn")
	var explosion_instance = explosion_scene.instantiate()
	get_parent().add_child(explosion_instance)
	explosion_instance.global_position = global_position
	
	#Pass enemy color to the explosion effect
	explosion_instance.set_explosion_color(sprite_2d.modulate)
