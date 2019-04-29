extends KinematicBody2D

var speed = 70

export (int) var walk_speed
export (int) var run_speed
export (int) var detect_radius

var alive = true

onready var parent = get_parent()

func _ready():
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	speed = walk_speed

func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2()
	else:
		pass


func _physics_process(delta):
	if not alive:
		return
	control(delta)
#	move_and_slide(velocity)

#func _physics_process(delta):
#	if not alive:
#		return
#	control(delta)
#	move_and_slide(velocity)

func _on_DetectRadius_body_entered(body):
	if body.name == "Player":
		speed = run_speed

func _on_DetectRadius_body_exited(body):
	if body.name == "Player":
		speed = walk_speed
