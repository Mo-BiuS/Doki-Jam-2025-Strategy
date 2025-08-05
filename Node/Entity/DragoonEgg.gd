class_name DragoonEgg extends Entity

func _ready() -> void:
	super._ready()
	mvm		= CONST_UNIT.array[0][1]
	vision	= CONST_UNIT.array[0][2]
	attack	= CONST_UNIT.array[0][3]
	defence	= CONST_UNIT.array[0][4]
	cost		= CONST_UNIT.array[0][5]
