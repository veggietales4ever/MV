extends CharacterBody2D

var jump_strength = 250
var gravity = 600
var speed = 100
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
	
	#Jump

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump = true
	
func movement(delta):
	if direction.x:
		velocity.x = move_toward(velocity.x, direction.x * speed, 1600 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, 1600 * delta)
		
		
	#Jump
	if jump:
		jump = false
		velocity.y = -jump_strength
		
	move_and_slide()

func apply_gravity(delta):
	velocity.y += gravity * delta

func update_sprite():
	if direction.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
		
	
