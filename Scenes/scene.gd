extends Node3D

#Set our needed vars
var gridcolor: Color = Global.gridcolor
var bgcolor: Color = Global.bgcolor
var gridbrightness: float = Global.gridbrightness
var ui: bool = false

#Prepare our UI nodes for use later
@onready var GUI: CanvasLayer = $UI
@onready var GridPick: ColorPickerButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ColorPickerButton
@onready var WorldPick: ColorPickerButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/ColorPickerButton2
@onready var Brightness: HSlider = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer/HSlider
@onready var VigCheck: CheckButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer6/CheckButton
@onready var CRTCheck: CheckButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer7/CheckButton
@onready var RainCheck: CheckButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer8/CheckButton
@onready var VHSCheck: CheckButton = $UI/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer9/CheckButton


#Grab our nodes that the UI will interact with
@onready var World: WorldEnvironment = $WorldEnvironment
@onready var GridUI: ColorRect = $EffectsContainer/SubViewport/PostProcess/VaporGrid
@onready var VignetteUI: ColorRect = $EffectsContainer/SubViewport/PostProcess/Vignette
@onready var VhsUI: ColorRect = $EffectsContainer/SubViewport/PostProcess/Vhs
@onready var RainUI: ColorRect = $EffectsContainer/SubViewport/PostProcess/Rain
@onready var CRTUI: ColorRect = $Scanlines/Scanlines
@onready var VHSUI: ColorRect = $EffectsContainer/SubViewport/PostProcess/Vhs

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
	GridUI.material.set_shader_parameter("brightness", gridbrightness)
	GridUI.material.set_shader_parameter("background_color", bgcolor)
	GridUI.material.set_shader_parameter("grid_color", gridcolor)
	_vignette()
	_rain()
	_crt()
	_vhs()
	
	




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
		GridUI.material.set_shader_parameter("brightness", gridbrightness)
		GridUI.material.set_shader_parameter("background_color", bgcolor)
		GridUI.material.set_shader_parameter("grid_color", gridcolor)
		
func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if ui != true:
			GUI.show()
			ui = true
		else:
			GUI.hide()
			ui = false

func _on_color_picker_button_color_changed(color: Color):
	gridcolor = color


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
	Global.crt = true
	Global.rain = true
	Global.vhs = true
	_vignette()
	_crt()
	_rain()
	_vhs()
	


func _on_button_3_button_up():
	get_tree().quit()


func _on_h_slider_value_changed(value):
	gridbrightness = value




func _on_button_4_pressed():
	DirAccess.remove_absolute("user://tate.dat")


func _on_vignette_toggled(toggled_on):
	Global.vignette = toggled_on
	_vignette()
	
func _vignette():
	VigCheck.set_pressed_no_signal(Global.vignette)
	if Global.vignette != false:
		VignetteUI.show()
	else:
		VignetteUI.hide()

func _on_crt_toggled(toggled_on):
	Global.crt = toggled_on
	_crt()

func _crt():
	CRTCheck.set_pressed_no_signal(Global.crt)
	if Global.crt != false:
		CRTUI.show()
	else:
		CRTUI.hide()

func _on_rain_toggled(toggled_on):
	Global.rain = toggled_on
	_rain()

func _rain():
	RainCheck.set_pressed_no_signal(Global.rain)
	if Global.rain != false:
		RainUI.show()
	else:
		RainUI.hide()


func _on_vhs_toggled(toggled_on):
	Global.vhs = toggled_on
	_vhs()

func _vhs():
	VHSCheck.set_pressed_no_signal(Global.vhs)
	if Global.vhs != false:
		VHSUI.show()
	else:
		VHSUI.hide()
