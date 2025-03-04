extends Control
class_name InventoryUI

const INVENTORY_SLOT = preload("res://UI/PauseMenu/Inventory/inventory_slot.tscn")

@export var data : InventoryData


func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	clear_inventory()
	

# this function takes all the inventory slots and deletes them
func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()
		
func update_inventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		
	get_child(0).grab_focus() # Highlights the first item in inventory
