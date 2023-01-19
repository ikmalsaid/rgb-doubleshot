extends KinematicBody2D
#
#
var motion = Vector2()
var life1 = 1
var life2 = 2
#
#
func _ready():
	pass
#
#
func _physics_process(delta):
	var player = get_parent().get_node("Player")
	position += (player.position - position) / 50
	look_at(player.position)
	move_and_collide(motion)
#
#
func _on_enemy_body_entered(body):
	if "Bullet1" in body.name:
		life1 -= 1

	elif "Bullet2" in body.name:
		life2 -= 2
		
	if int(life1 + life2) == 0:
		$Killed.play()
		global.kills += 1
		print("[INFO] Kills: ", global.kills)
		queue_free()
