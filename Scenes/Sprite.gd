extends Sprite

var scene_res=preload("res://Scenes/TileTrap.tscn")

var count = 6
var xrad=60
var radius = Vector2(xrad, 0)
var center = Vector2(position.x, position.y)


func _input(event):
    if event is InputEventMouseButton and event.pressed:
        var step = 2 * PI / count

        for i in range(count):
            var node = scene_res.instance()
            node.position = center + radius.rotated(step * i)
            node.look_at(center)
            get_parent().add_child(node)

        count = 12
        radius = Vector2(xrad+60, 0)