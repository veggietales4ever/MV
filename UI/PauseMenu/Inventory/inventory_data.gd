extends Resource
class_name InventoryData

@export var slots : Array[SlotData]

func add_item(item : ItemData, count : int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				s.quantity += count
				return true
				
	# Start at 0 and count up to however slots there are
	for i in slots.size():
		if slots[i] == null: # If a slot is empty
			var new = SlotData.new() # With resources we can call this and it'll create a new instance of that resource.
			new.item_data = item
			new.quantity = count
			slots[i] = new
			return true
			
	print("Inventory was full")
	return false
