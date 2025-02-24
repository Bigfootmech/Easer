extends Control

var self_scene = preload("res://Self.tscn").instance()

var window_closed = false
var grammophone_playing = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClockButton_pressed():
	go_next_scene()
	
func go_next_scene():
	get_node("/root/GrandmaTop").queue_free()
	get_tree().get_root().add_child(self_scene)
	
	

func _on_WindowOpen_pressed():
	$"WindowOpen".hide()
	$"WindowClosed".show()
	window_closed = true
	
	update_noise_visual()
	
func _on_GrammophoneButton_pressed():
	$"Notes".show()
	grammophone_playing = true
	
	update_noise_visual()
	
func update_noise_visual():
	var noise_state = count_noise_state()
	if noise_state == 2:
		$"NoiseLarge".show()
		$"NoiseSmall".hide()
	elif noise_state == 1:
		$"NoiseLarge".hide()
		$"NoiseSmall".show()
	else:
		$"NoiseLarge".hide()
		$"NoiseSmall".hide()
		
func count_noise_state():
	var count = 2
	if window_closed:
		count -= 1
	if grammophone_playing:
		count -= 1
	return count

