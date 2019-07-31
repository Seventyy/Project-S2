extends Node2D

var rand=RandomNumberGenerator.new()

var screen_shake_scale=0
var screen_shake_time
var screen_shake_type

func _ready():
    pass

func start_screen_shake(_scale=8,_time=16,_type=0):
    screen_shake_scale=_scale
    screen_shake_time=_time
    screen_shake_type=_type

func screen_shake():
    position=Vector2(rand.randi_range(-63,63),rand.randi_range(-63,63)).normalized()*screen_shake_scale
    
    if screen_shake_scale>0.1:
        if screen_shake_type==0:
            screen_shake_scale-=ceil(screen_shake_scale/screen_shake_time)
        else:
            screen_shake_scale/=1.1
    else:
        screen_shake_scale=0
   	
func _process(delta):
    screen_shake()