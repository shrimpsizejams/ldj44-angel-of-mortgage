extends KinematicBody2D

signal soul_reaped
export (int) var speed
export (float) var scythe_cooldown

var velocity = Vector2()
var alive = true

func _ready():
	$ScytheTimer.wait_time = scythe_cooldown
	set_animation("down")

func set_animation(animation_str):
	$Sprite/AnimatedSprite.animation = animation_str

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