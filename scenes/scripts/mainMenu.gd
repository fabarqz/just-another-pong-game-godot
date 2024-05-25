extends CanvasLayer

signal new_game

# Called when the node enters the scene tree for the first time.
func _ready():
	#$newgame_button.connect("pressed",self,"_on_newgame_button_pressed")
	pass
func _on_newgame_button_pressed():
	var main_game=load("res://scenes/Game.tscn")
	var main_game_instance=main_game.instance()
	var root=get_tree().root
	
	root.remove_child(root.get_child(0))
	root.add_child(main_game_instance) # Replace with function body.
