extends Node2D

var stages={
	"Plains":{
		1:[
		"res://scenes/waves/4x_bad_ship.tscn",
		"res://scenes/waves/4x_bad_ship_down.tscn",
		"res://scenes/waves/2x_enemy_sad.tscn",
		"res://scenes/waves/1x_enemy_pacman.tscn"
		]
		}
}

var current_stage="Plains"
var current_level=1
var level_waves_iterator=0
var current_wave_instance

var available_waves=[]
var level_waves=[]
var rand=RandomNumberGenerator.new()

var level_length = 3

func generateLevelWaves():
    for i in range(level_length):
        level_waves.append(available_waves[rand.randi_range(0,len(available_waves)-1)])

func appendAvailableWaves():
	available_waves=stages[current_stage][current_level]

func instanceCurrentWave():
	current_wave_instance=load(level_waves[level_waves_iterator]).instance()
	current_wave_instance.position=Vector2()
	get_node("/root/Root").add_child(current_wave_instance)

func _ready():
	rand.randomize()
	appendAvailableWaves()
	generateLevelWaves()
	instanceCurrentWave()

func _process(delta):
	if current_wave_instance.get_child_count()==0:
		level_waves_iterator+=1
		if level_waves_iterator<level_waves.size():
			instanceCurrentWave()
		else:
			get_tree().call_deferred("change_scene","res://scenes/win_scene/win_scene.tscn")
			set_process(false)