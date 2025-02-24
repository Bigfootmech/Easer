extends Control

var grandma_scene = preload("res://Grandma.tscn").instance()
var self_scene = preload("res://Self.tscn").instance()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_node("/root/Top").queue_free()
	get_tree().get_root().add_child(grandma_scene)
	
	pass # Replace with function body.
