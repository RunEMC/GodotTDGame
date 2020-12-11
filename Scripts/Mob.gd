extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minSpeed = 100
var MaxSpeed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	var mobTypes = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mobTypes[randi() % mobTypes.size()]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
