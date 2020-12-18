extends Node2D


#export var toolBoxCount = 2
var toolBoxes = []
var currentlySelectedToolBox = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	toolBoxes.append($ToolBox)
	toolBoxes.append($ToolBox2)
	pass # Replace with function body.

func updateToolBar():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_1"):
		_select_new_toolbox(0)
	elif Input.is_action_just_pressed("ui_2"):
		_select_new_toolbox(1)

func _select_new_toolbox(boxnum):
#	print("selected: " + str(boxnum) + " cur: " + str(currentlySelectedToolBox))
#	print(currentlySelectedToolBox)
	if boxnum != currentlySelectedToolBox:
		var newToolBox = toolBoxes[boxnum]
		newToolBox.get_child(0).animation = "selected"
		print(newToolBox.get_child(0).animation)
	#	Reset old selection
		if currentlySelectedToolBox >= 0 and currentlySelectedToolBox < len(toolBoxes):
			var oldToolBox = toolBoxes[currentlySelectedToolBox]
			oldToolBox.get_child(0).animation = "default"
#			print("reset animation on " + str(currentlySelectedToolBox))
		currentlySelectedToolBox = boxnum
