extends Node
signal get_coin

var coins = 0
var saved_coins = 0

func add_coin():
	coins += 1
	get_coin.emit()

func save_coins():
	saved_coins = coins
	
func load_coins():
	coins = saved_coins
