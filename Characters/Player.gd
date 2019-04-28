extends KinematicBody2D

signal soul_reaped
export (int) var speed
export (float) var scythe_cooldown

var velocity = Vector2()
var alive = true

func _ready():
	$ScytheTimer.wait_time = scythe_cooldown

func control(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2(speed, 0)
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(-speed, 0)
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(0, speed)
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(0, -speed)	

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)