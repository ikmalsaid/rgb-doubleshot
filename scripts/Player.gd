extends KinematicBody2D
#
# GE Jam #5 Submission - Dual Shootah
# 2022 - ikmalsaid - godot_3.4.4
#
# Set respective variables
var move_speed = 250
var bull_speed = 500
var bullet1 = preload("res://world/Bullet1.tscn")
var bullet2 = preload("res://world/Bullet2.tscn")
var bullet1_ins = bullet1.instance()
var bullet2_ins = bullet2.instance()
#
# Executes during startup
func _ready():
	pass
#
# Executes every frame
func _process(delta):
	get_parent().get_node("HUD/Killed").text = str("Killed: ", global.killed)
	get_parent().get_node("HUD/Kills").text = str("Kills: ", global.kills)
	get_parent().get_node("HUD/Score").text = str("Score: ", global.score)
#
# Executes during physics processing
func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	
	if Input.is_action_pressed("down"):
		motion.y += 1
		
	if Input.is_action_pressed("left"):
		motion.x -= 1
	
	if Input.is_action_pressed("right"):
		motion.x += 1		
	
	motion = motion.normalized()
	motion = move_and_slide(motion * move_speed)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot1"):
		bullet1()
	
	if Input.is_action_just_pressed("shoot2"):
		bullet2()
#
#
# Executes during left click
func bullet1():
	$Shoot1.play()
	var bullet1_ins = bullet1.instance()
	bullet1_ins.position = get_global_position()
	bullet1_ins.rotation_degrees = rotation_degrees
	bullet1_ins.apply_impulse(Vector2(), Vector2(bull_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet1_ins)
	
	yield(get_tree().create_timer(1.0), "timeout")
	bullet1_ins.queue_free()
#
# Executes during right click
func bullet2():
	$Shoot2.play()
	var bullet2_ins = bullet2.instance()
	bullet2_ins.position = get_global_position()
	bullet2_ins.rotation_degrees = rotation_degrees
	bullet2_ins.apply_impulse(Vector2(), Vector2(bull_speed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet2_ins)

	yield(get_tree().create_timer(1.0), "timeout")
	bullet2_ins.queue_free()
#
# Executes when enemy hits the player
func killed():
	$Killed.play()
	global.killed += 1
	print("[INFO] Killed: ", global.killed)
	get_tree().get_root().call_deferred("remove_child", bullet1_ins)
	get_tree().get_root().call_deferred("remove_child", bullet2_ins)
	get_tree().reload_current_scene()
#
func _on_player_body_entered(body):
	if "Enemy" in body.name:
		killed()
