class_name DragoonChick extends Entity

func _ready() -> void:
	super._ready()
	typeId = 1
	mvm		= CONST_UNIT.array[typeId][1]
	vision	= CONST_UNIT.array[typeId][2]
	attack	= CONST_UNIT.array[typeId][3]
	defence	= CONST_UNIT.array[typeId][4]
	cost		= CONST_UNIT.array[typeId][5]
