extends RigidBody2D

export var maxspeed = 300

signal lives
signal score

var _start_size
var _start_position
var _trauma=0.0
var _rotation=0
var _rotation_speed=0.05
var _color=0.0
var _color_decay=1
var _normal_color
var _decay_rate=0.0
var _max_offset=4
var trauma_color=Color(1,0,0)


func _ready():
 contact_monitor = true
 set_max_contacts_reported(4)
 var WorldNode = get_node("/root/World")
 connect("score", WorldNode, "increase_score")
 connect("lives", WorldNode, "decrease_lives")

 _start_position=$ColorRect.rect_position
 #_start_size=$ColorRect.get_transform().size
 _normal_color= Color(1,1,1)

func _physics_process(delta):
 var bodies = get_colliding_bodies()
 for body in bodies:
  if body.is_in_group("Tiles"):
   emit_signal("score",body.score)

   body.shake()

   add_color(1.0)
   Shatter()
   var shake=get_node("/root/World/Camera2D")
   shake.inputshake()
   body.queue_free()
  add_trauma(2.0)
  if body.is_in_group("Core"):
   get_tree().change_scene("res://Scenes/CompLvl.tscn")
  if body.is_in_group("Core1"):
   get_tree().change_scene("res://Scenes/Win.tscn")
  if body.get_name() == "Paddle":
    pass
  
 if position.y > get_viewport_rect().end.y:
  emit_signal("lives")
  queue_free()

func Shatter():
	var test=get_node("TileBreak")
	test.Shatter()
func Stop():
	var test=get_node("TileBreak")
	test.Stop()


func _process(delta):
	if _trauma>0:
		_decay_trauma(delta)
		_apply_shake()
	if _color>0:
		_decay_color(delta)
		_apply_color()
	if _color ==0 and $ColorRect/Sprite.modulate != _normal_color:
		$ColorRect/Sprite.modulate=_normal_color


func add_color(amount):
	_color +=amount
func _apply_color():
	var a= min(1,_color)
	$ColorRect/Sprite.modulate=_normal_color.linear_interpolate(trauma_color,a)
func _decay_color(delta):
	var change=_color_decay*delta
	_color=max(_color-change,0)

func add_trauma(amount):
	_trauma=min(_trauma+amount,1)

func _decay_trauma(delta):
	var change=_decay_rate*delta
	_trauma=max(_trauma-change,0)
	
func _apply_shake():
	var shake= _trauma*_trauma
	var o_x=_max_offset*shake*_get_neg_pos_scaler()
	var o_y=_max_offset*shake*_get_neg_pos_scaler()
	$ColorRect.rect_position*_start_position+Vector2(o_x,o_y)

func _get_neg_pos_scaler():
	return rand_range(-1.0,1.0)