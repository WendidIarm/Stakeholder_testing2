extends Resource
class_name SlotData

const MAX_STACK_SIZE: int = 3 #change

@export var item_data: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1
