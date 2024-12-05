extends Node2D


#var time = 0.0
#var power = 0.1
@onready var color_rect = $ColorRect

#var initial_zoom = 4.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	time += delta
#	power += delta + 0.001
#	var zoom = initial_zoom / pow(time, power)
#	color_rect.get_material().set_shader_parameter("zoom", zoom)
