extends Node
signal add_score
#Load level Image
#replace texture pixel with a prick of same color

#Colors
const RED = Color.RED
const GREEN = Color.GREEN
const BLUE = Color.BLUE
const SKY_BLUE = Color(0,1,1,1)
const MAGENTA = Color.MAGENTA
const WHITE = Color.WHITE
const BLACK = Color.BLACK

const levels_path = "res://levels/"

const WORLD_WIDTH = 160
const WORLD_HEIGHT = 144
const BLOCK_SIZE = 6
var block = preload("res://objects/Block.tscn")
func _ready():
	Globals.level_complete.connect(level_complete)
	var next_path = levels_path+"level%d.png" % Globals.current_level
	if FileAccess.file_exists(next_path):
		load_level(next_path)
	else:
		load_level(levels_path+"level0.png")
		
func level_complete(level):
	var next_level = level + 1
	Globals.current_level = next_level
	get_tree().reload_current_scene()

func load_level(level_path):
	var levelimg :Texture2D = load(level_path)
	var width = levelimg.get_width()
	var height = levelimg.get_height()
	var offsetX = width+BLOCK_SIZE/2
	var offsetY = 20
	for i in range(0,height):
		var y = i * BLOCK_SIZE
		for j in range(0,width):
			var x = j * BLOCK_SIZE
			var pix = levelimg.get_image().get_pixel(j,i)
			print(pix)
			if pix.a != 0.0:
				Globals.add_block()
				var b = block.instantiate()
				add_child(b)
				b.set_color(pix)
				b.global_position = Vector2(offsetX+x,offsetY+y)
