extends Node2D

export (int) var tweak_left
export (int) var tweak_right
export (int) var tweak_top
export (int) var tweak_bottom

func _ready():
	set_camera_limits()
	
func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var map_cellsize = $Ground.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x + tweak_left
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x + tweak_right
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y + tweak_top
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y + tweak_bottom