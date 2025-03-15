extends StaticBody3D


@export var duration: float


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(duration).timeout
		queue_free()
