#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name ToolTipPanel extends PanelContainer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
var name_label: Label
var texture_rect: TextureRect
var desc_label: Label
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func set_tool_tip(_name : String, desc : String, texture) -> void:
	name_label = %NameLabel
	texture_rect = %TextureRect
	desc_label = %DescLabel
	name_label.text = _name
	desc_label.text = desc
	texture_rect.texture = texture
#endregion
