extends Area2D
signal hit
signal build(tower)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 250
var screen_size
var inBuildZone = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#	Movement
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		if velocity.x != 0:
			$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#	Build Zone Detection
	$Label.visible = inBuildZone
	if Input.is_action_pressed("ui_build"):
		emit_signal("build", 0)

func start(pos):
	position = pos
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
	emit_signal("hit")
#	$CollisionShape2D.set_deferred("disabled", true)
	print_debug("collided with")
	print_debug(body)
#	pass # Replace with function body.

func _on_Player_area_entered(area):
	emit_signal("hit")
#	$CollisionShape2D.set_deferred("disabled", true)
	print_debug("collided with")
	print_debug(area)
#	pass # Replace with function body.

func _on_Tower_canBuild():
	inBuildZone = true


func _on_Tower_leftBuildZone():
	inBuildZone = false
