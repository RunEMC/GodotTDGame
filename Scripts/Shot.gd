extends Area2D


var target = null
var speed = 200
var velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if target.get_ref():
		velocity = ((target.get_ref().get_global_transform().origin - position).normalized() * speed)
		position += velocity * delta
		rotation = velocity.angle()
	else:
		queue_free()
		
func setTarget(newTarget):
	target = weakref(newTarget)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
