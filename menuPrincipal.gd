extends Control

func _on_criar_servidor_pressed():
	Networking.criarServidor()
	get_tree().change_scene_to_file("res://mundo.tscn")
	pass # Replace with function body.

func _on_entrar_servidor_pressed():
	Networking.entrarServidor()
	get_tree().change_scene_to_file("res://mundo.tscn")
	pass # Replace with function body.
