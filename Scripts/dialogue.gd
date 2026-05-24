extends Control

signal dialogue_finished

@export_file("*.json") var d_file
var dialogue = []
var current_dialogue_id = 0
var dialogue_active = false

func _ready():
	$Text.visible = false
#start dialogue
func start():
	if dialogue_active:
		return
	dialogue_active = true
	$Text.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_line()
#stop dialogue
func stop():
	dialogue_active = false
	current_dialogue_id = 0
	emit_signal("dialogue_finished")
# loads json file as text
func load_dialogue():
	var file = FileAccess.open("res://Dialogue/ryandialogue.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
# advances dialogue on button press
func _input(event):
	if event.is_action_pressed("interact"):
		if !dialogue_active:
			start()
		else:
			next_line()
# advances and displays dialogue until final line
func next_line():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false
		%Text.visible = false
		emit_signal("dialogue_finished")
		return
	%Text.visible = true
	%Text.text = dialogue[current_dialogue_id]['text']
