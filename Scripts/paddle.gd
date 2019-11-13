extends KinematicBody2D

var new_ball = preload("res://Scenes/Ball.tscn")

export var distort_x=2.0
export var distort_y=1.2
onready var _view=get_viewport().get_visible_rect().size
onready var _collision_transform=$CollisionShape2D.get_transform().get_scale()
onready var _shape=$ColorRect.get_rect().size

func _ready():
    set_process_input(true)

func _physics_process(delta):
    var mouse_x = get_viewport().get_mouse_position().x

    #stretch test
    var target=get_viewport().get_mouse_position().x
    if target != position.x:
        var x=position.x + ((target - position.x)*0.2)
        var w = 1+(distort_x*(abs(target-position.x)/ _view.x))
        var h = 1-(1/distort_y*(abs(target-position.x)/ _view.y))
        _change_size(w,h)
        position = Vector2(x, position.y)
    else:
        _change_size(1,1)
func _change_size(w,h):
    $ColorRect.rect_scale=Vector2(w,h)
    $CollisionShape2D.set_scale(Vector2(_collision_transform.x*w,_collision_transform.y*h))




func _input(event):
    if event is InputEventMouseButton and event.pressed:
        if not get_parent().has_node("Ball"):
            var ball = new_ball.instance()
            ball.position = position - Vector2(0, 32)
            ball.name = "Ball"
            ball.linear_velocity = Vector2(200, -200)
            get_parent().add_child(ball)
