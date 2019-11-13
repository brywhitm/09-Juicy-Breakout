extends Sprite

var scene_res=preload("res://Scenes/TileTrap.tscn")

var count = 9
var xrad=80
var radius = Vector2(xrad, 0)
var center = Vector2(position.x, position.y)
var counter=0

func _input(event):
    if event is InputEventMouseMotion and counter<3:
        var step = 2 * PI / count
        counter+=1
        for i in range(count):
            var node = scene_res.instance()
            node.position = center + radius.rotated(step * i)
            node.look_at(center)
            get_parent().add_child(node)
        if counter==1:
            count = 12
            radius = Vector2(xrad+40, 0)
        if counter==2:
            count=16
            radius = Vector2(xrad+80,0)