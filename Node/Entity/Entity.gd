class_name Entity extends Node2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite
@onready var lifeCounterContainer:PanelContainer = $LifeCounterContainer
@onready var lifeCounterLabel:Label = $LifeCounterContainer/LifeCounterLabel

const SPEED = 400

var tilePos:Vector2i

var team:int = -1
var life:int = 10
var veterancy:int = 0
var typeId:int = -1

var mvm:int	= 0
var vision:int	= 0
var attack:int	= 0
var defence:int	= 0
var cost:int		= 0

var areaDict:Dictionary
var mvmMap:Array
var isMoving:bool = false
var isActivated:bool = true

var captureObjectif:Building = null
var killObjectif:Entity = null
var hasMoved:bool = false
#FUUUUUUUUUUUUUUUUUUUCK
var arena:Arena

func _ready() -> void:
	sprite.play(str(team)+"-MovingSouth")

func _process(delta: float) -> void:
	if isMoving:
		if(mvmMap.is_empty()):
			isMoving=false
		else:
			hasMoved = true
			var pos = mvmMap[mvmMap.size()-1]
			var targetPos:Vector2 = Vector2(pos)*64+Vector2(32,32)
			var newPosition:Vector2 = position.move_toward(targetPos, SPEED * delta)
			
			if(newPosition.x-position.x > 0):sprite.play(str(team)+"-MovingEast")
			if(newPosition.x-position.x < 0):sprite.play(str(team)+"-MovingWest")
			if(newPosition.y-position.y > 0):sprite.play(str(team)+"-MovingSouth")
			if(newPosition.y-position.y < 0):sprite.play(str(team)+"-MovingNorth")
			
			position = newPosition 
			
			if position == targetPos:
				tilePos = Vector2i(position / (32 * 2))
				mvmMap.erase(pos)
				if(mvmMap.is_empty()):
					isMoving=false
					if(captureObjectif != null):
						if(captureObjectif.tilePos == tilePos):
							capture(captureObjectif)
							captureObjectif = null
						else:desactivate()
					if(killObjectif != null):
						if(isAroundKillObjectif()):
							damage(killObjectif,arena.getDefenceAt(killObjectif.tilePos),arena.getDefenceAt(tilePos))
							killObjectif = null
						else:desactivate()

func activate():
	hasMoved = false
	isActivated = true
	sprite.modulate = Color(1,1,1)
func desactivate():
	isActivated = false
	sprite.modulate = Color(.5,.5,.5)

func setPosition(pos:Vector2i):
	tilePos = pos
	position = (Vector2(pos)*32+Vector2(16,16))*2

func startMoving()->void:
	pass

func damage(ennemy:Entity, ennemyDefenseBonus:int, defenseBonus)->void:
	ennemy.life -= max (1,attack*life/10-ennemy.defence-ennemyDefenseBonus)
	if(ennemy.life < 10):
		ennemy.lifeCounterContainer.show()
		ennemy.lifeCounterLabel.text = str(ennemy.life)
	
	if(ennemy.life <= 0):ennemy.queue_free()
	else:
		life -= max (1,ennemy.attack*ennemy.life/10-defence-defenseBonus)
		if(life < 10):
			lifeCounterContainer.show()
			lifeCounterLabel.text = str(life)
		if(life <= 0):queue_free()
	desactivate()

func capture(building:Building):
	if(building.teamCapturng != team):
		building.teamCapturng = team
		building.capture = 10
	building.capture-=5*life/10
	if(building.capture < 10):
		building.captureCounterContainer.show()
		building.captureCounterLabel.text = str(int(building.capture))
	if(building.capture <= 0):
		building.capture = 10
		building.team = team+1
		building.captureCounterContainer.hide()
		match building.team:
			0:building.sprite.play("N")
			1:building.sprite.play("A")
			2:building.sprite.play("B")
		building.changedTeam.emit(building)
	desactivate()

func heal():
	if(life < 10):life = min(life+4,10)
	if(life < 10):
		lifeCounterContainer.show()
		lifeCounterLabel.text = str(life)
	else:lifeCounterContainer.hide()

func goCapture(b:Building)->void:
	trace(b.tilePos)
	var nMap:Array
	for i in mvmMap:
		if(areaDict.get(i) <= mvm):nMap.append(i)
	mvmMap = nMap
	captureObjectif = b
	isMoving = true
func goAttack(e:Entity, pos:Vector2i):
	trace(pos)
	var nMap:Array
	for i in mvmMap:
		if(areaDict.get(i) <= mvm):nMap.append(i)
	mvmMap = nMap
	killObjectif = e
	isMoving = true
	
func trace(pos:Vector2i):
	mvmMap.append(pos)
	if(pos != tilePos):
		var validDirection:Array
		for i in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
			if(areaDict.has(pos+i)):validDirection.append(i)
		var minAround = 1000000000
		for i in validDirection:
			minAround = min(minAround,areaDict[pos+i])
		for i in validDirection:
			if(areaDict[pos+i] == minAround):
				trace(pos+i)
				break
	

func isAroundKillObjectif()->bool:
	for i in [Vector2i(-1,0),Vector2i(1,0),Vector2i(0,-1),Vector2i(0,1)]:
		if tilePos+i == killObjectif.tilePos: return true
	return false
