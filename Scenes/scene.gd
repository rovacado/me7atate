extends Node3D
var gridcolor: Color = Global.gridcolor
var bgcolor: Color = Global.bgcolor
var gridbrightness: float = Global.gridbrightness
var ui: bool = false
@export var GridNode: ColorRect = null
@export var World: WorldEnvironment = null
@onready var GridPick: ColorPickerButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ColorPickerButton
@onready var WorldPick: ColorPickerButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/ColorPickerButton2
@onready var Brightness: HSlider = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer/HSlider
@onready var VigCheck: CheckButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer6/CheckButton
@onready var GUI: CanvasLayer = $UI
@onready var VignetteUI: CanvasLayer = $Grid/Vignette

# Called when the node enters the scene tree for the first time.
func _ready():
	GUI.hide()
	Global.load_settings()
	gridcolor = Global.gridcolor
	bgcolor = Global.bgcolor
	gridbrightness = Global.gridbrightness
	Brightness.set_value(gridbrightness)
	WorldPick.set_pick_color(bgcolor)
	GridPick.set_pick_color(gridcolor)
	World.environment.set_bg_color(bgcolor)
	GridNode.material.set_shader_parameter("brightness", gridbrightness)
	GridNode.material.set_shader_parameter("background_color", bgcolor)
	GridNode.material.set_shader_parameter("grid_color", gridcolor)
	_vignette()
	
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if gridcolor != Global.gridcolor or bgcolor != Global.bgcolor or gridbrightness != Global.gridbrightness:
		Global.gridcolor = gridcolor
		Global.bgcolor = bgcolor
		Global.gridbrightness = gridbrightness
		Brightness.set_value(gridbrightness)
		WorldPick.set_pick_color(bgcolor)
		GridPick.set_pick_color(gridcolor)
		World.environment.set_bg_color(bgcolor)
		GridNode.material.set_shader_parameter("brightness", gridbrightness)
		GridNode.material.set_shader_parameter("background_color", bgcolor)
		GridNode.material.set_shader_parameter("grid_color", gridcolor)
		
func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		print(Global.bgcolor)
		print(Global.gridcolor)
	if Input.is_action_just_pressed("ui_cancel"):
		if ui != true:
			GUI.show()
			ui = true
		else:
			GUI.hide()
			ui = false

func _on_color_picker_button_color_changed(color: Color):
	gridcolor = color
	print(gridcolor)
	print(Global.gridcolor)


func _on_color_picker_button_2_color_changed(color: Color):
	bgcolor = color


func _on_button_pressed():
	Global.save_settings()


func _on_button_2_pressed():
	bgcolor = Color(0, 0.102, 0.2)
	WorldPick.set_pick_color(bgcolor)
	gridcolor = Color(1, 0.502, 1)
	GridPick.set_pick_color(gridcolor)
	gridbrightness = 1.0
	Brightness.set_value(1.0)
	Global.vignette = true
	_vignette()
	


func _on_button_3_button_up():
	get_tree().quit()


func _on_h_slider_value_changed(value):
	print(value)
	gridbrightness = value




func _on_button_4_pressed():
	DirAccess.remove_absolute("user://tate.dat")


func _on_check_box_toggled(toggled_on):
	Global.vignette = toggled_on
	_vignette()
	
func _vignette():
	VigCheck.set_pressed_no_signal(Global.vignette)
	if Global.vignette != false:
		VignetteUI.show()
	else:
		VignetteUI.hide()
