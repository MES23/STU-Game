extends Node2D

var game_started = false
var wavecount
@onready var screensize = get_viewport_rect().size

@export var enemy1 : PackedScene
@export var enemy2 : PackedScene
@export var enemy3 : PackedScene

func _ready():
	$CanvasLayer/TextureRect.hide()


func _on_startbutton_pressed():
	$CanvasLayer/startbutton.hide()
	$Ship.start()
	wavecount = 0
	game_started = true

func spawn_enemies1():
	
	for x in 9:
		for y in 3:
			var e = enemy1.instantiate()
			var pos = Vector2(x * (16+8) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.start(pos)

func spawn_enemies2():
	for x in 9:
		for y in 3:
			var e = enemy2.instantiate()
			var pos = Vector2(x * (16+8) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.start(pos)

func spawn_enemies3():
	for x in 9:
		for y in 3:
			var e = enemy3.instantiate()
			var pos = Vector2(x * (16+8) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.start(pos)

func _on_ship_dead():
	$Endgametimer.start()
	game_started = false
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullet", "queue_free")
	$CanvasLayer/TextureRect.show()

func _on_timer_timeout():
	$CanvasLayer/TextureRect.hide()
	$CanvasLayer/startbutton.show()

func _process(_delta):
	if game_started:
		if get_tree().get_nodes_in_group("enemies").size() == 0:
			if wavecount % 3 == 0:
				spawn_enemies1()
			elif wavecount % 3 == 1:
				spawn_enemies2()
			else:
				spawn_enemies3()
			
			wavecount += 1

