extends Enemy
class_name SlimeEnemy

const gravity = 30 
#var speed : float = 100


func _physics_process(delta: float) -> void:
	if is_on_wall() and is_on_floor():
		velocity.y = -stats.jump_velocity
	else:
		velocity.y += gravity
		
	move_and_slide()
	#handle_animation()
	
#func update_flip(dir):
	#if abs(dir) == dir:
		#sprite_2d.flip_h = false
	#else:
		#sprite_2d.flip_h = true

#func move(dir, speed):
	#velocity.x = dir * speed
	##handle_animation()
	#update_flip(dir)
	
func move(target_pos : Vector2, delta : float):
	var direction = Vector2(
		target_pos.x - global_position.x,
		0
	)
	
	velocity.x = direction.x * stats.run_speed
	
	update_flip(direction.x)
	
	
func handle_animation():
	#falling out of a jump
	#if !is_on_floor():
		#animation_player.play("fall")
		
	if velocity.x != 0:
		animation_player.play("idle")
	else:
		animation_player.play("idle")

func check_for_self(node):
	if node == self:
		return true
	else:
		return false

func update_flip(dir : float):
	sprite_2d.flip_h = dir < 0
