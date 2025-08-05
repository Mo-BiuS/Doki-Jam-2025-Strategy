class_name DragoonChick extends Entity

func _ready() -> void:
	super._ready()
	mvm		= CONST_UNIT.array[1][1]
	vision	= CONST_UNIT.array[1][2]
	attack	= CONST_UNIT.array[1][3]
	defence	= CONST_UNIT.array[1][4]
	cost		= CONST_UNIT.array[1][5]
