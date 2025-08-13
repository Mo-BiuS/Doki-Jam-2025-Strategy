class_name BuildingInfoBox extends PanelContainer

@export var typeLabel:Label
@export var teamLabel:Label
@export var captureLabel:Label
@export var infoLabel:Label

func refresh(buildingHandler:BuildingHandler, pos:Vector2i)->void:
	var building:Building = buildingHandler.getBuildingAtPos(pos)
	if(building == null):hide()
	else:
		if(building is Capital):
			typeLabel.text = "Capital"
			infoLabel.text = "Produce 400 gold per turn. "
			if(building.team == 1):infoLabel.text += "If you lose it you lose the game."
			if(building.team == 2):infoLabel.text += "If you capture it you win the game."
		elif(building is Base):
			typeLabel.text = "Base"
			infoLabel.text = "Can be used to recruit new unit"
		else:
			typeLabel.text = "City"
			infoLabel.text = "Produce 100 gold per turn"
		
		if(building.team == 0):teamLabel.text = "Neutral"
		elif(building.team == 1):teamLabel.text = "Dokibird"
		elif(building.team == 2):teamLabel.text = "Trickster"
		
		captureLabel.text = str(int(building.capture))+"/10"
		
		show()
