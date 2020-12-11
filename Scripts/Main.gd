extends Node

#export (PackedScene) var MobPath
var Mob = load("res://Scenes/MobPath.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var wave = 0
export var mobsLeft = 0
var waveMobs = [3, 5]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()
	pass # Replace with function body.

func new_game():
	$Player.start($StartPosition.position)
	
#	Start wave 1
	mobsLeft = waveMobs[wave]
	$MobTimer.start()
	$WaveTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WaveTimer_timeout():
	wave += 1
	if wave < len(waveMobs):
		mobsLeft = waveMobs[wave]
		$MobTimer.start()
		$WaveTimer.start()
	

func _on_MobTimer_timeout():
	var mob = Mob.instance()
	$Path.add_child(mob)
	mobsLeft -= 1
	if mobsLeft <= 0:
		$MobTimer.stop()
#		wave += 1
#		if wave < len(waveMobs):
#			$WaveTimer.start()
	
