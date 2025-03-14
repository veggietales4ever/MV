extends Node

var fade_duration = 0.5 # Set fade duration to 2.5 seconds
var fade_speed = 1.5# / fade_duration
var right_distance = 25
var left_distance = -25
var walk_duration = 1.5
var state = "idle"
var can_move := false



@export var level: Node2D
@export var fade_rect: ColorRect
@export var character : CharacterBody2D



#func _ready() -> void:
	#var current_scene = get_tree().current_scene
	#if current_scene:
		## Locate FadeRect
		#if current_scene.has_node("Transitions/FadeRect"):
			#fade_rect = current_scene.get_node("Transitions/FadeRect")
		#else:
			#fade_rect = null
			#push_error("FadeRect not found")
			#
	## Make sure fade starts black
	#if fade_rect:
		#fade_rect.modulate.a = 1
		#fade_rect.visible = true
		#
	#call_deferred("start_fade_in")

	
func start_fade_in():
	if fade_rect:
		fade_in()

		
		
#func _process(_delta: float) -> void:
	#if state == "fade_left" and fade_rect:
		#PlayerManager.player.can_move = false
		#fade_out()
		#transition_left()
	#if state == "fade_right" and fade_rect:
		#PlayerManager.player.cant_move()
		#fade_out()
		#transition_right()
		#fade_rect.color.a = min(1, fade_rect.color.a + fade_speed * delta)
		
	
	#if state == "fade_left" or "fade_right" or "fade_up" or "fade_down" and fade_rect:
		##fade_rect.color.a = min(1, fade_rect.color.a + fade_speed * delta)
		#player.cant_move()
		#fade_in()
	
		
		
func fade_in():
	if not fade_rect:
		return

	fade_rect.modulate.a = 1 # Make sure the screen is black
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0, fade_duration)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(on_fade_in_finished)

	
func fade_out():
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1, fade_duration)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(on_fade_out_finished)
	

func on_fade_in_finished():
	state = "idle"
	
func on_fade_out_finished():
	state = "idle"
	
	
# Scene Entry
# Entry - LEFT
func entry_left():
	var player = PlayerManager.player
	var sprite = player.get_node_or_null("Sprite2D")
	sprite.flip_h = false
	
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + right_distance, walk_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(on_entry_finished_left)
	
func on_entry_finished_left():
	PlayerManager.player.can_move = true
	state = "idle"


# Entry - RIGHT
func entry_right():
	var player = PlayerManager.player
	var sprite = player.get_node_or_null("Sprite2D")
	sprite.flip_h = true
	
	var tween = create_tween()
	tween.tween_property(player, "position:x", player.position.x + left_distance, walk_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(on_entry_finished_right)
	
func on_entry_finished_right():
	PlayerManager.player.can_move = true
	state = "idle"
	
	
	
	
	
	
	
# Scene Exit
	
# Exit LEFT
func transition_left():
	if PlayerManager.player:
		var animation_player = PlayerManager.player.get_node_or_null("AnimationPlayer")
		if animation_player:
			animation_player.play("run")
	var tween = create_tween()
	tween.tween_property(PlayerManager.player, "position:x", PlayerManager.player.position.x + left_distance, walk_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(level.on_transition_finished_left)
	
func _on_left_area_body_entered(_body: Node2D) -> void:
	if PlayerManager.player:
		var animation_player = PlayerManager.player.get_node_or_null("AnimationPlayer")
		if animation_player:
			animation_player.play("run")
			state = "fade_left"
			print("state changed to:", state)
		
	
	
# Exit RIGHT
func transition_right():
	var tween = create_tween()
	tween.tween_property(PlayerManager.player, "position:x", PlayerManager.player.position.x + right_distance, walk_duration)
	tween.set_ease(Tween.EASE_OUT)
	
	tween.finished.connect(level.on_transition_finished_right)
	
		
func _on_right_area_body_entered(_body: Node2D) -> void:
	if PlayerManager.player:
		var animation_player = PlayerManager.player.get_node_or_null("AnimationPlayer")
		if animation_player:
			animation_player.play("run")
			state = "fade_right"
			print("state changed to:", state)
		
		
func change_scene(target_scene_path: String):
	if target_scene_path == "" or target_scene_path.is_empty():
		push_error("🚨 Error: Target scene path is empty! Cannot switch scenes.")
		return

	print("Switching to scene:", target_scene_path)

	await fade_out()  # Ensure fade-out before switching

	# Remove the current scene properly
	var current_scene = get_tree().current_scene
	if current_scene:
		current_scene.queue_free()  # Mark current scene for deletion
		await get_tree().process_frame  # Ensure deletion is processed

	# Load new scene
	var new_scene = load(target_scene_path).instantiate()
	if not new_scene:
		push_error("🚨 Error: Failed to instantiate scene!")
		return

	# Add new scene to tree and set it as the active scene
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

	await get_tree().process_frame  # Ensure the new scene is fully loaded

	_ready()  # Reinitialize FadeRect
	await fade_in()  # Fade in smoothly
