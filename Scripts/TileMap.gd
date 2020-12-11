extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Player_collided(collision):
	print_debug("collidedWithBuildArea")
#	if collision.collidedr is TileMap:
#		print_debug("collidedWithBuildArea")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
