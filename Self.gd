extends Control

var speed_factor = 4

var fade_to_black = false
var fading_mug = false
var fading_inspirational = false
var fade_time = 5 # 5
var fade_time_mug = 3 # 5
var faded = 0
var mug_faded = 0
var inspire_faded = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_min_fade()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fade_to_black == true: 
		exit_fade(delta)
	if fading_mug == true: 
		mug_fade(delta)
	if fading_inspirational == true: 
		inspir_fade(delta)
		
		

func exit_fade(delta):
	faded += delta
	var weight = faded / fade_time / speed_factor
	set_fade_opacity(lerp(get_fade_opacity(), 1, weight))
	
func mug_fade(delta):
	mug_faded += delta
	var current_track = mug_faded
	
	var past_half = mug_faded > fade_time_mug
	
	var current_state = $"Mug".modulate.a
	var goal = 0.8
	if(past_half): 
		goal = 0
		current_track -= fade_time_mug
		
	var weight = current_track / fade_time_mug / speed_factor
	
	$"Mug".modulate.a = (lerp(current_state, goal, weight))
	
func inspir_fade(delta):
	inspire_faded += delta
	var current_track = inspire_faded
	
	var current_state = $"SelfHelp".modulate.a
	var goal = 1
		
	var weight = current_track / fade_time / speed_factor
	
	$"SelfHelp".modulate.a = (lerp(current_state, goal, weight))
		

func set_min_fade():
	set_fade_opacity(0.0)
func set_max_fade():
	set_fade_opacity(1.0)
	
func set_fade_opacity(op):
	$"FadeCover".modulate.a = op

func get_fade_opacity():
	return $"FadeCover".modulate.a

func end_day():
	fade_to_black = true
	$"FadeCover".show()
	$"FadeCover/Timer".start(fade_time)
	
func _on_Timer_timeout():
	set_max_fade()
	fade_to_black = false
	
	$"SelfHelp".modulate.a = 0
	$"SelfHelp".show()
	fading_inspirational = true
	
func fade_in_out():
	fading_mug = true
	$"Mug".modulate.a = 0
	$"Mug".show()
	$"Mug/Timer".start(fade_time_mug * 2)
	
func _on_MugTimer_timeout():
	fade_to_black = false
	$"Mug".modulate.a = 0
	$"Mug".hide()
	
	
	

func _on_WindowButton_pressed():
	pass # Replace with function body.

func _on_Shrine_Static_pressed():
	$"Shrine_Incense".show()

func _on_Kettle_pressed():
	$"KettleSteam".hide()
	fade_in_out()

func _on_Pot_pressed():
	$"PotBoilingHead".hide()
	$"FoodEaten".show()
	
	
	
	
	

func _on_ClockButton_pressed():
	$"EndDayDialog".popup_centered()

func _on_DoorOpen_pressed():
	$"SleepDialog".popup_centered()

func _on_EndDayDialog_confirmed():
	end_day()

func _on_SleepDialog_confirmed():
	$"DoorOpen".hide()
	end_day()


