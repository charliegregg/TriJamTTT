extends TextureRect


func _ready():
	%AnimationPlayer.play("reveal")

func hide_level():
	%AnimationPlayer.play("load")
