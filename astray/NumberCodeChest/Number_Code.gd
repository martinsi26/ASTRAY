extends Resource

class_name NumberCode

signal update

@export var slots: Array[NumberCodeSlot]

func increase(slot: NumberCodeSlot):
	var id = slot.id
	if slots[id].value == 9:
		slots[id].value = 0
	else:
		slots[id].value = slots[id].value + 1
	update.emit()
	
func decrease(slot: NumberCodeSlot):
	var id = slot.id
	if slots[id].value == 0:
		slots[id].value = 9
	else:
		slots[id].value = slots[id].value - 1
	update.emit()
