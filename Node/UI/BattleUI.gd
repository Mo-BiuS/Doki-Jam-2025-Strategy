class_name BattleUI extends PanelContainer

var entityHandler:EntityHandler
var buildingHandler:BuildingHandler
var arenaHandler:ArenaHandler

@export var captureUI:MarginContainer
@export var attackUI:MarginContainer

@export var buildingLabel:Label
@export var buildingHpBefore:Label
@export var buildingHpAfter:Label

@export var ennemyBefore:Label
@export var ennemyAfter:Label
@export var alliedBefore:Label
@export var alliedAfter:Label


func refresh(allyPos:Vector2i,ennemyPos:Vector2i):
	var alliedEntity:Entity = entityHandler.getUnitAt(allyPos)
	if(alliedEntity != null):
		if(allyPos == ennemyPos):
			captureUI.show()
			attackUI.hide()
			var ennemyBuilding:Building = buildingHandler.getBuildingAtPos(ennemyPos)
			if(ennemyBuilding != null):
				if(ennemyBuilding is Capital):buildingLabel.text = "Capital"
				elif(ennemyBuilding is Base):buildingLabel.text = "Base"
				elif(ennemyBuilding is City):buildingLabel.text = "City"
				
				buildingHpBefore.text = str(ennemyBuilding.capture) + "/10"
				
				var after = ennemyBuilding.capture - alliedEntity.getCapture()
				if(after <= 0):buildingHpAfter.text = "Captured"
				else:buildingHpAfter.text = str(float(int(after*10))/10)+"/10"
		else:
			captureUI.hide()
			attackUI.show()
			var ennemyEntity = entityHandler.getUnitAt(ennemyPos)
			if(ennemyEntity != null):
				ennemyBefore.text = str(ennemyEntity.life)+"/10"
				alliedBefore.text = str(alliedEntity.life)+"/10"
				
				var ennemyAfterLife:int = ennemyEntity.life - max (1,int(alliedEntity.getAttack()-ennemyEntity.defence-arenaHandler.arena.getDefenceAt(ennemyEntity.tilePos)))
				if(ennemyAfterLife <= 0):
					ennemyAfter.text = "Dead"
					alliedAfter.text = alliedBefore.text
				else:
					ennemyAfter.text = str(ennemyAfterLife)+"/10"
					alliedAfter.text = str(alliedEntity.life - max (1,int(ennemyEntity.attack*ennemyAfterLife/10-alliedEntity.defence-arenaHandler.arena.getDefenceAt(alliedEntity.tilePos))))+"/10"
