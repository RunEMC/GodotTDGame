extends PathFollow2D

var speed = 100
var hp = 2


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset += speed * delta
	
	if unit_offset >= 1:
		reached_end()
#	pass


func reached_end():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("shot"):
		area.queue_free()
		hp -= 1
		if hp <= 0:
			queue_free()
	pass # Replace with function body.
