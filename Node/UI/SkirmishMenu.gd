class_name SkirmishMenu extends CanvasLayer

signal toMainMenu
signal toGame(arena:PackedScene, campaignNumber:int)

@export var arenaNameLabel:Label
@export var view:Viewport
var id = 0;
var arena:Arena

func _ready() -> void:
	loadArena()

func loadArena()->void:
	arenaNameLabel.text = CONST_ARENA.SKIRMISH_LIST[id][0]
	view.remove_child(arena)
	arena = CONST_ARENA.SKIRMISH_LIST[id][1].instantiate()
	arena.hideSpawn = false
	arena.hide()
	arena.ready.connect(adjustScale)
	view.add_child(arena)
func adjustScale()->void:
	arena.show()
	var x:float = arena.tiles.get_used_rect().size.x*64
	var y:float = arena.tiles.get_used_rect().size.y*64
	
	var s:float = 512/max(x,y)
	arena.scale = Vector2(s,s)
	arena.position = Vector2((512-x*s)/2.0, (512-y*s)/2.0)

func _on_start_button_pressed() -> void:
	toGame.emit(CONST_ARENA.SKIRMISH_LIST[id][1], -1)
func _on_return_button_pressed() -> void:
	toMainMenu.emit()


func _on_next_pressed() -> void:
	id+=1
	if(id == CONST_ARENA.SKIRMISH_LIST.size()):id=0
	loadArena()
func _on_prev_pressed() -> void:
	id-=1
	if(id == -1):id=CONST_ARENA.SKIRMISH_LIST.size()-1
	loadArena()
