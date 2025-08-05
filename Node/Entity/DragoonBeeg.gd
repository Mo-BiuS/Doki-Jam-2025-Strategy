class_name DragoonBeeg extends Entity

func _ready() -> void:
	super._ready()
	mvm		= CONST_UNIT.array[3][1]
	vision	= CONST_UNIT.array[3][2]
	attack	= CONST_UNIT.array[3][3]
	defence	= CONST_UNIT.array[3][4]
	cost		= CONST_UNIT.array[3][5]
