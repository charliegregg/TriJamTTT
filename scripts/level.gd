extends Node2D


func _ready():
	Globals.get_coin.connect(get_coin)
	get_coin()
	
func get_coin():
	%Coins.text = str(Globals.coins)
