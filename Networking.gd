extends Node

const IPPADRAO = "127.0.0.1"
const PORTAPADRAO = 6007
const MAXJOGADORES = 32

var par = null

signal jogadorConectado

func criarServidor():
	par = ENetMultiplayerPeer.new()
	par.create_server(PORTAPADRAO, MAXJOGADORES)
	multiplayer.multiplayer_peer = par
	multiplayer.peer_connected.connect(self.parConectado)
	pass

func entrarServidor():
	par = ENetMultiplayerPeer.new()
	par.create_client(IPPADRAO, PORTAPADRAO)
	multiplayer.multiplayer_peer = par
	pass

func parConectado(parID):
	emit_signal("jogadorConectado", parID)
	pass
