extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !emptyslots.is_empty():
		emptyslots[0].item = item
	update.emit()
	
func remove(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	itemslots[0].item = null
	update.emit()
