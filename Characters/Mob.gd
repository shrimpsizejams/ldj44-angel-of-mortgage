extends KinematicBody2D

export (int) var speed

var velocity = Vector2()
var alive = true

onready var parent = get_parent()

func _ready():
	pass

func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
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