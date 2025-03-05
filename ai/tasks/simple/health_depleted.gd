extends BTAction


const PICKUP = preload("res://entities/objects/pickup/item_pickup.tscn")

@export_category("Item Drops")
@export var drops : Array[DropData]

#@export var stats : CharacterStats
var health_var : int

func _tick(_delta: float) -> Status:
	agent.stats.health = health_var
	if health_var >= 0:
		agent.animation_player.play("dead")
		drop_items()
		#await agent.get_tree().create_timer(1.0).timeout 
		#agent.explode()
		#agent.queue_free()
	return SUCCESS
		

#func enter() -> void:
	#drop_items()

func drop_items() -> void:
	if drops.size() == 0:
		return
		
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
			
		var drop_count : int = drops[i].get_drop_count()
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			agent.get_parent().call_deferred("add_child", drop)
			drop.global_position = agent.global_position
			
			# Set initial velocity to shoot upward and outward
			var angle = randf_range(-PI / 4, PI / 4) # Random spread from -45 degress to 45
			var force = randf_range(150, 300) # Random force
			
			drop.velocity = Vector2.UP.rotated(angle) * force
			# old code drop.velocity = agent.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
