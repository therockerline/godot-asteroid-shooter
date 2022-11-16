extends Control
class_name LifeBar

var maxValue = 0 : set = _setMaxValue
var life_rect: ColorRect
# Called when the node enters the scene tree for the first time.
func _ready():
	life_rect = $LifeRect	

func _setMaxValue(value):
	maxValue = value
	setValue(value)

func setValue(value):
	life_rect.size.x = size.x * value/maxValue
