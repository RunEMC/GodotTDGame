extends Area2D
signal canBuild
signal leftBuildZone

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BuildableZone_area_entered(area):
	print_debug(area.name)
	if area.name == "Player":
		emit_signal("canBuild")
	
#	pass # Replace with function body.


func _on_BuildableZone_area_exited(area):
	print_debug(area.name)
	if area.name == "Player":
		emit_signal("leftBuildZone")
#	pass # Replace with function body.


func _on_Player_build(tower):
	$AnimatedSprite.animation = "tower1"
#	pass # Replace with function body.
