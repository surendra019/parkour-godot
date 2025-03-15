extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var level_container: Node3D = $LevelContainer

var levels: Array = []

var current_level_index: int =  0
var level_ref: Node3D

func _ready() -> void:
	dir_contents("res://Scenes/Levels/")
	load_level()


func load_level() -> void:
	if level_container.get_child_count() > 0:
		for i in level_container.get_children():
			level_container.remove_child(i)
	var level: PackedScene = load(levels[current_level_index])
	level_ref = level.instantiate()
	level_container.add_child(level_ref)
	player.global_position = level_ref.spawn_point.global_position
	
	
	

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				#print("Found file: " + file_name)
				levels.push_back(path + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
func _physics_process(delta: float) -> void:
	if player.position.y <= -10:
		game_over()
		

func game_over() -> void:
	if level_ref:
		player.global_position = level_ref.spawn_point.global_position

func game_win() -> void:
	current_level_index += 1
	load_level()
