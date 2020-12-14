extends Area2D


var target = null
var speed = 700
var velocity
var moved = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if target.get_ref() and !moved:
		velocity = ((target.get_ref().get_global_transform().origin - position).normalized() * speed)
		position += velocity * delta
		rotation = velocity.angle()
		moved = true
	else:
		position += velocity * delta
		
func setTarget(newTarget):
	target = weakref(newTarget)
#	if target.get_ref():
#	velocity = ((target.get_ref().get_global_transform().origin - position).normalized() * speed)
#	rotation = velocity.angle()
#	print_debug(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
