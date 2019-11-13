extends Label

func _ready():
    update_Core()

func update_Core():
    text = "Core: " + str(get_parent().Core)