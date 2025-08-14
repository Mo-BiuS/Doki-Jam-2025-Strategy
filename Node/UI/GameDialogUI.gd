class_name GameDialogUI extends CanvasLayer

const MODE_STANDBY = 0
const MODE_INTRO = 1
const MODE_OUTRO = 2

signal introOver
signal outroOver

@export var textLabel:Label
@export var leftSprite:Sprite2D
@export var rightSprite:Sprite2D

var mode:int = MODE_STANDBY
var wait:float = 0

func _process(delta: float) -> void:
	if(wait < .2):wait+=delta
	elif(mode != MODE_STANDBY):
		if(Input.is_action_just_pressed("action")):
			match mode:
				MODE_INTRO:
					if(CONST_CAMPAIGN.hasIntroLeft()):loadNextDialog()
					else:
						mode = MODE_STANDBY
						introOver.emit()
				MODE_OUTRO:
					if(CONST_CAMPAIGN.hasOutroLeft()):loadNextDialog()
					else:
						mode = MODE_STANDBY
						outroOver.emit()

func loadNextDialog():
	wait = 0
	var d:Array = CONST_CAMPAIGN.getNextDialog()
	textLabel.text = d[2]
	leftSprite.texture = d[1][0]
	match d[1][1]:
		CONST_CAMPAIGN.EFFECT_NONE:leftSprite.modulate = Color(1,1,1)
		CONST_CAMPAIGN.EFFECT_GREY:leftSprite.modulate = Color(.5,.5,.5)
	rightSprite.texture = d[1][2]
	match d[1][3]:
		CONST_CAMPAIGN.EFFECT_NONE:rightSprite.modulate = Color(1,1,1)
		CONST_CAMPAIGN.EFFECT_GREY:rightSprite.modulate = Color(.5,.5,.5)

func startIntro():
	if(CONST_CAMPAIGN.hasIntroLeft()):
		mode = MODE_INTRO
		loadNextDialog()
	else:introOver.emit()
func startOutro():
	if(CONST_CAMPAIGN.hasOutroLeft()):
		mode = MODE_OUTRO
		loadNextDialog()
	else:outroOver.emit()
