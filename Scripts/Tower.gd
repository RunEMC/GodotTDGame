extends Area2D
signal canBuild
signal leftBuildZone


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemyArray = []
var currentTarget

var RADIUS = 48

# Called when the node enters the scene tree for the first time.
func _ready():
	$TowerGun.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if !currentTarget:
		var distToTarget = 9999
		for target in enemyArray:
			var targetPos = target.get_global_transform().origin
#			print_debug(targetPos)
			print_debug((position - targetPos).length())
			if (position - targetPos).length() < distToTarget:
				currentTarget = weakref(target)
				distToTarget = (position - targetPos).length()
		if currentTarget:
			$ShootTimer.start()
	else:
		print_debug("target found")
		print_debug(currentTarget)
		if (!currentTarget.get_ref()):
			currentTarget = null
			$ShootTimer.stop()
		else:
			var curTargetPos = currentTarget.get_ref().get_global_transform().origin
			$TowerGun.rotation = (curTargetPos - position).angle()
			if enemyArray.find(currentTarget.get_ref()) == -1:
				currentTarget = null
				$ShootTimer.stop()

func _on_Tower_area_entered(area):
	if area.name == "Player":
		emit_signal("canBuild")


func _on_Tower_area_exited(area):
	if area.name == "Player":
		emit_signal("leftBuildZone")


func _on_Player_build(tower):
	var towerTypes = $TowerBase.frames.get_animation_names()
	if tower < len(towerTypes):
		$TowerBase.animation = towerTypes[tower]
		$TowerGun.visible = true
	else:
		print_debug("Invalid tower type " + tower)


func _on_Aggro_area_entered(area):
	if area.is_in_group("enemy"):
		enemyArray.append(area.get_parent())
#		print_debug("Added enemy")

func _on_Aggro_area_exited(area):
	if area.is_in_group("enemy"):
		enemyArray.erase(area.get_parent())
#		print_debug("Removed enemy")
