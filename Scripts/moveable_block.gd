extends StaticBody3D

@onready var _mesh: MeshInstance3D = $MeshInstance3D
@onready var _collision: CollisionShape3D = $CollisionShape3D

@export var start: Vector3
@export var end: Vector3
@export var duration: float
@export var _size: Vector3 = Vector3.ONE

enum LAST_FLAG {START, END}

var last_flag: LAST_FLAG

func _ready() -> void:
	global_position = start
	toggle_animation()
	assign_size()
	

func assign_size() ->void:
	var mesh: BoxMesh = _mesh.mesh.duplicate()
	mesh.size = _size
	
	var collision_shape: BoxShape3D = _collision.shape.duplicate()
	collision_shape.size = _size
	
	_mesh.mesh = mesh
	_collision.shape = collision_shape
	
	

func toggle_animation() -> void:
	var tween: Tween = create_tween()
	if last_flag == LAST_FLAG.START:
		tween.tween_property(self, "position", end, duration)
	else:
		tween.tween_property(self, "position", start, duration)
	
	tween.finished.connect(func():
		if last_flag == LAST_FLAG.START:
			last_flag = LAST_FLAG.END
		else:
			last_flag = LAST_FLAG.START
		toggle_animation()
		)
	
