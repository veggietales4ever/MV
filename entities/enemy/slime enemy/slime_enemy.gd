extends CharacterBody2D
class_name Enemy

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

@export var Health : int = 3

var invulnerable : bool = false
var direction = Vector2.ZERO
var player : Player
var is_hurt := false
var is_knocked_back := false
var knockback_force := 100
var knockback_duration := 0.3
var invulnerability_duration := 1.0
var gravity := 600

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $hitbox
@onready var state_matchine: EnemyStateMachine = $EnemyStateMachine
@onready var invulnerability_timer: Timer = $Timers/InvulnerabilityTimer

func _ready() -> void:
	state_matchine.initialize(self)
	player = PlayerManager.player

func _process(delta: float) -> void:
	apply_gravity(delta)
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func update_animation(state : String) -> void:
	animation_player.play(state)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var player = PlayerManager.player
		if not player.invulnerable:
			player_data.life -= 1
			player.take_damage(global_position)
			
		
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Sword":
		take_damage(2) # Apply 2 damage
			
func take_damage(amount: int):
	if invulnerable or is_knocked_back:
		return # Don't take damage if invulnerable
		
	# States
	is_knocked_back = true
	invulnerable = true
	
	take_damage_animation()
	
	# Knockback direction (opposite of player)
	var knockback_direction = sign(position.x - PlayerManager.player.position.x)
	if knockback_direction == 0:
		knockback_direction = 1 # Default to right if directly on top
	
	# Apply knockback
	velocity.x = knockback_direction * knockback_force
	#velocity.y = -200 * 1.3 # Slight upward
		
	# Knockback movement
	move_and_slide()
	
	Health -= amount # Subtract health
	emit_signal("enemy_damaged") # Emit signal if needed
	
	# Knockback timer
	var knockback_tween = create_tween()
	knockback_tween.tween_property(self, "velocity", Vector2.ZERO, knockback_duration)
	knockback_tween.set_ease(Tween.EASE_IN_OUT)
	knockback_tween.connect("finished", _on_knockback_finished)
	
	start_invulnerability()
	
	if Health <= 0:
		queue_free()

func take_damage_animation():
	if not is_hurt:
		is_hurt = true
		animation_player.play("damaged")
		
func _on_knockback_finished():
	is_knocked_back = false

func start_invulnerability():
	invulnerable = true
	var flash_tween = create_tween()
	for i in range(7): # Flash 7 times
		flash_tween.tween_property(self, "modulate", Color(1, 1, 1, 0.3), 0.1) # 0.1 is duration of tween in seconds
		flash_tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.1)
	flash_tween.connect("finished", _on_invulnerability_timeout)
	
func _on_invulnerability_timeout():
	invulnerable = false
	self.modulate = Color(1, 1, 1, 1) # Reset opacity
	
func apply_gravity(delta):
	velocity.y += gravity * delta
