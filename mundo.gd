extends Node3D

@onready var jogador = preload("res://Char-Assets/Cena.tscn")

func _ready():
	if multiplayer.is_server():
		spawn(multiplayer.get_unique_id())
		Networking.jogadorConectado.connect(self.spawn)
	pass # Replace with function body.

func spawn(parID):
	var obj = jogador.instantiate()
	obj.name = str(parID)
	add_child(obj)
	if multiplayer.is_server():
		obj.position += Vector3(0, 0, 1)
	pass
