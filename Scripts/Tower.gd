extends Area2D
signal canBuild
signal leftBuildZone

var Shot = load("res://Scenes/Shot.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemyArray = []
var currentTarget


# Called when the node enters the scene tree for the first time.
func _ready():
	$TowerGun.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
#	Target Selection
	if !currentTarget:
		var distToTarget = 99999999
		for target in enemyArray:
			var targetPos = target.get_global_transform().origin
			if (position - targetPos).length() < distToTarget:
				currentTarget = weakref(target)
				distToTarget = (position - targetPos).length()
		if currentTarget:
			$ShootTimer.start()
#	Target Found
	else:
		if (!currentTarget.get_ref()):
			currentTarget = null
			$ShootTimer.stop()
		else:
			var curTargetPos = currentTarget.get_ref().get_global_transform().origin
			$TowerGun.rotation = (curTargetPos - position).angle()

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
		if area.get_parent() == currentTarget.get_ref():
			currentTarget = null
			$ShootTimer.stop()


func _on_ShootTimer_timeout():
	if currentTarget.get_ref():
		var shot = Shot.instance()
		shot.setTarget(currentTarget.get_ref())
		shot.position = $TowerGun/ShotPosition.get_global_transform().origin
		get_parent().add_child(shot)
		
		
