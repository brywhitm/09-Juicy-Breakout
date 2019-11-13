extends Tween

export var min_time: =0.6
export var max_time: =1.8
var tweening:=true

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