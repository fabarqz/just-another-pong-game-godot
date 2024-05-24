extends CanvasLayer

signal reset_game


func _ready():
	pass

func _on_Game_victory_achieved():
	self.visible=true
	$resultLabel.text="The winner is"+" "+str(get_parent().winner_result)+"!"
			# Replace with function body.


func _on_restartButton_pressed():
	emit_signal("reset_game")
	self.visible=false
