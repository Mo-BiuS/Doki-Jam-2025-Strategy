class_name DragoonLong extends Entity

func _ready() -> void:
	super._ready()
	mvm		= CONST_UNIT.array[2][1]
	vision	= CONST_UNIT.array[2][2]
	attack	= CONST_UNIT.array[2][3]
	defence	= CONST_UNIT.array[2][4]
	cost		= CONST_UNIT.array[2][5]
