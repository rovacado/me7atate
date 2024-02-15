extends Node
var bgcolor: Color = Color(0, 0.102, 0.2)
var gridcolor: Color = Color(1, 0.502, 1)
var gridbrightness: float = 1.0
var vignette: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func save_settings():
	var data = {
		"bgcolor" : bgcolor.to_html(),
		"gridcolor" : gridcolor.to_html(),
		"gridbrightness" : gridbrightness,
		"vignette" : vignette
	}
		
	var file = FileAccess.open("user://tate.dat", FileAccess.WRITE)
	file.store_line(JSON.stringify(data))
	print(data)
	
func load_settings():
	if not FileAccess.file_exists("user://tate.dat"):
		print("no file")
		return
		
	var file = FileAccess.open("user://tate.dat", FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_line())
	if error == OK:
		var data = json.data
		bgcolor = Color.from_string(data["bgcolor"], bgcolor)
		gridcolor = Color.from_string(data["gridcolor"], gridcolor)
		gridbrightness = data["gridbrightness"] as float
		vignette = data["vignette"] as bool
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", file.get_line(), " at line ", json.get_error_line())
	
	
	
