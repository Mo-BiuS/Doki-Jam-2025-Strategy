class_name Entity extends Node2D

@onready var sprite:AnimatedSprite2D = $AnimatedSprite
@onready var lifeCounterContainer:PanelContainer = $LifeCounterContainer
@onready var lifeCounterLabel:Label = $LifeCounterContainer/LifeCounterLabel

const SPEED = 400

var tilePos:Vector2i

var team:int = -1
var life:int = 10
var veterancy:int = 0

var mvm:int	= 0
var vision:int	= 0
var attack:int	= 0
var defence:int	= 0
var cost:int		= 0

var mvmMap:Array
var isMoving:bool = false
var isActivated:bool = true

func _ready() -> void:
	sprite.play(str(team)+"-MovingSouth")

func _process(delta: float) -> void:
	if isMoving:
		if(mvmMap.is_empty()):
			isMoving=false
		else:
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
				if(mvmMap.is_empty()):isMoving=false

func activate():
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
