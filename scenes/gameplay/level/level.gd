extends Node3D

const truffle = preload("res://scenes/gameplay/diggable/truffle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = $CSGMesh3D.get_children()
	for child in children:
		var child_copy = child as Node3D
		if child_copy:
			if child_copy.global_position.x < -100:
				child_copy.add_to_group("dig_zone_1")
			elif child_copy.global_position.x < 0:
				child_copy.add_to_group("dig_zone_2")
			elif child_copy.global_position.x < 100:
				child_copy.add_to_group("dig_zone_3")
			else:
				child_copy.add_to_group("dig_zone_4")
	var group_1 = get_tree().get_nodes_in_group("dig_zone_1")
	var group_2 = get_tree().get_nodes_in_group("dig_zone_2")
	var group_3 = get_tree().get_nodes_in_group("dig_zone_3")
	var group_4 = get_tree().get_nodes_in_group("dig_zone_4")
	group_1.shuffle()
	group_2.shuffle()
	group_3.shuffle()
	group_4.shuffle()
	var truf = truffle.instantiate()
	group_1[0].get_node("truffle_spot").add_child(truf)
	truf = truffle.instantiate()
	group_1[1].get_node("truffle_spot").add_child(truf)
	truf = truffle.instantiate()
	group_2[0].get_node("truffle_spot").add_child(truf)
	truf = truffle.instantiate()
	group_2[1].get_node("truffle_spot").add_child(truf)
	truf = truffle.instantiate()
	group_3[0].get_node("truffle_spot").add_child(truf)
	truf = truffle.instantiate()
	group_3[1].get_node("truffle_spot").add_child(truf)
	truf = truffle.instantiate()
	group_4[0].get_node("truffle_spot").add_child(truf)
	truf = truffle.instantiate()
	group_4[1].get_node("truffle_spot").add_child(truf)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
