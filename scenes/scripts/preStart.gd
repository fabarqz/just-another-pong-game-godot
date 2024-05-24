extends CanvasLayer

var countdown_items=["3","2","1","GO!"]
var current_index=0
signal countdown_started
signal countdown_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func countdown():
	current_index=0
	$countdownLabel.visible=true
	emit_signal("countdown_started")
	_on_inBetween_timeout()

func _on_inBetween_timeout():
	if current_index<countdown_items.size():
		$countdownLabel.text=countdown_items[current_index]
		$inBetween.start()
		current_index+=1
	else:
		$inBetween.stop()
		$countdownLabel.visible=false
		emit_signal("countdown_finished")	 # Replace with function body.



