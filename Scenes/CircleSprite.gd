extends Tween


export var min_time: =0.4
export var max_time: =0.9
var tweening:=false

func _ready() -> void:
	if not tweening:
		return
	
	randomize()
	var parent:= get_parent()
	
	interpolate_property(parent,
		"scale",
		Vector2.ZERO,
		Vector2.ONE,
		rand_range(min_time, max_time),
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	start()