extends CharacterBody2D

const SPEED = 100
const JUMP_STRENGTH = 200

var acceleration = 1600
var friction = 800
var gravity = 600
var direction = Vector2.ZERO
var jump := false
var can_move := true


func _process(delta: float) -> void:
	apply_gravity(delta)
	
	if can_move:
		get_input()
		movement(delta)
		update_sprite()
	
func get_input():
	direction.x = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump"):
		jump = true
		
		
func movement(delta):
	if direction.x:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
	if jump:
		if is_on_floor():
			jump = false
			velocity.y = -JUMP_STRENGTH
		
func apply_gravity(delta):
	velocity.y += gravity * delta
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func update_sprite():
	if direction.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
