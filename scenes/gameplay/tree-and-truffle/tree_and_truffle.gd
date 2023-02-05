@tool
extends StaticBody3D

@export var tree: int = 1:
	set(new):
		print ("Am I getting called?")
		tree = wrapi(new, 0, get_node("trees").get_child_count())
		for child in get_node("trees").get_children():
			child.visible = child.get_index() == tree

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_node("trees").get_children():
		child.visible = child.get_index() == tree


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
