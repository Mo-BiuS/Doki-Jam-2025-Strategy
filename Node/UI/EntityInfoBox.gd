class_name EntityInfoBox extends PanelContainer

@export var typeLabel:Label
@export var hpLabel:Label
@export var mvmLabel:Label
@export var attackLabel:Label
@export var captureLabel:Label
@export var defenceLabel:Label

func refresh(entityHandler:EntityHandler,arenaHandler:ArenaHandler, pos:Vector2i)->void:
	var entity:Entity = entityHandler.getUnitAt(pos)
	if(entity == null):hide()
	else:
		show()
		var constData = CONST_UNIT.array[entity.typeId]
		typeLabel.text = constData[0]
		hpLabel.text = str(entity.life)+"/10"
		mvmLabel.text = str(constData[1])
		attackLabel.text = str(float(int(entity.getAttack()*10))/10)
		captureLabel.text = str(float(int(entity.getCapture()*10))/10)
		defenceLabel.text = str(constData[4]+arenaHandler.arena.getDefenceAt(pos))
