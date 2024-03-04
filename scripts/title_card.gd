extends Label

@export var level_name:String
# Called when the node enters the scene tree for the first time.
func _ready():
	text = "There's too many "+level_name
	$AnimationPlayer.play("show")
