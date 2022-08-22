extends Node

const HOST: String = "127.0.0.1"
#const HOST: String = "192.168.1.1"
const PORT: int = 8000
const RECONNECT_TIMEOUT: float = 3.0

const Client = preload("res://Scripts/client.gd")
var _client: Client = Client.new()

signal serverMSG
var msg

func _ready() -> void:
	_client.connect("connected", self, "_handle_client_connected")
	_client.connect("disconnected", self, "_handle_client_disconnected")
	_client.connect("error", self, "_handle_client_error")
	_client.connect("data", self, "_handle_client_data")
	add_child(_client)
	_client.connect_to_host(HOST, PORT)

func _connect_after_timeout(timeout: float) -> void:
	yield(get_tree().create_timer(timeout), "timeout") # Delay for timeout
	_client.connect_to_host(HOST, PORT)

func _handle_client_connected() -> void:
	print("Client connected to server.")
	sendMsg("Hello")

func _handle_client_data(data: PoolByteArray) -> void:
	msg = data.get_string_from_utf8()
	print("Client data: ", data.get_string_from_utf8())
	emit_signal("serverMSG", msg)

func _handle_client_disconnected() -> void:
	print("Client disconnected from server.")
	_connect_after_timeout(RECONNECT_TIMEOUT) # Try to reconnect after 3 seconds

func _handle_client_error() -> void:
	print("Client error.")
	_connect_after_timeout(RECONNECT_TIMEOUT) # Try to reconnect after 3 seconds
	
func sendMsg(configContents):
	var message = configContents.to_utf8()
	_client.send(message)
	
