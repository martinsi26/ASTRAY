extends Resource

class_name CountCode

signal update

@export var slots: Array[CountCodeSlot]

func increase(slot: CountCodeSlot):
	var id = slot.id
	if slots[id].value == 9:
		slots[id].value = 0
	else:
		slots[id].value = slots[id].value + 1
	update.emit()
	
func decrease(slot: CountCodeSlot):
	var id = slot.id
	if slots[id].value == 0:
		slots[id].value = 9
	else:
		slots[id].value = slots[id].value - 1
	update.emit()
