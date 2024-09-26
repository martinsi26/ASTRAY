extends Panel

@onready var number_text: Label = $CenterContainer/Panel/NumberSelected
@onready var digit: CountCode = preload("res://CountCodeChest/Count_Code.tres")

var digit_slot

func update(slot: CountCodeSlot):
	digit_slot = slot
	number_text.text = str(slot.value)
	
func on_button_left_down() -> void:
	digit.decrease(digit_slot)

func on_button_right_down() -> void:
	digit.increase(digit_slot)
