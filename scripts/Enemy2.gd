extends KinematicBody2D
#
#
var motion = Vector2()
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
	if "Bullet2" in body.name:
		$Killed.play()
		global.kills += 1
		print("[INFO] Kills: ", global.kills)
		queue_free()
