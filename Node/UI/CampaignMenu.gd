class_name CampaignMenu extends CanvasLayer

signal toMainMenu
signal toCampaign(arena:PackedScene, campaignNumber:int)

@export var missionButton0:Button
@export var missionButton1:Button
@export var missionButton2:Button
@export var missionButton3:Button

func _ready() -> void:
	missionButton0.text = CONST_CAMPAIGN.campaignName[0]
	missionButton1.text = CONST_CAMPAIGN.campaignName[1]
	missionButton2.text = CONST_CAMPAIGN.campaignName[2]
	missionButton3.text = CONST_CAMPAIGN.campaignName[3]

func _on_return_button_pressed() -> void:
	toMainMenu.emit()

func _on_mission_1_pressed() -> void:
	toCampaign.emit(CONST_CAMPAIGN.arena[0],0)
func _on_mission_2_pressed() -> void:
	toCampaign.emit(CONST_CAMPAIGN.arena[1],1)
func _on_mission_3_pressed() -> void:
	toCampaign.emit(CONST_CAMPAIGN.arena[2],2)
func _on_mission_4_pressed() -> void:
	toCampaign.emit(CONST_CAMPAIGN.arena[3],3)
