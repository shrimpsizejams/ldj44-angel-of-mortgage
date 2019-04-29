extends KinematicBody2D

signal soul_reaped
export (int) var speed
export (float) var scythe_cooldown

var velocity = Vector2()
var alive = true
var bloody = false
var current_animation = "down"

func _ready():
	$ScytheTimer.wait_time = scythe_cooldown
	set_animation(current_animation)

func set_animation(animation_str):
	if bloody:
		$Sprite/AnimatedSprite.animation = animation_str + "_blood"
	else:
		$Sprite/AnimatedSprite.animation = animation_str
	current_animation = animation_str

func control(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2(speed, 0)
		set_animation("right")
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2(-speed, 0)
		set_animation("left")
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2(0, speed)
		set_animation("down")
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2(0, -speed)
		set_animation("up")
	if Input.is_action_pressed("ui_accept"):
		$Sprite/AnimatedSprite.play()
		$ScytheTimer.start()
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)

func _on_ScytheTimer_timeout():
	$Sprite/AnimatedSprite.stop()
	$Sprite/AnimatedSprite.frame = 0
	
	var overlapping_bodies = $ScytheRadius.get_overlapping_bodies()
	if not overlapping_bodies:
		return
	for body in overlapping_bodies:
		body.alive = false
	
	$Camera2D.shake(0.2, 15, 8)
	bloody = true
	set_animation(current_animation)
	$BloodDry.start()
	

func _on_BloodDry_timeout():
	bloody = false
	set_animation(current_animation)
	