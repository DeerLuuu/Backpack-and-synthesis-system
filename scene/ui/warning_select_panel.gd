#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name WarningSelectPanel extends PanelContainer

# TODO 警告选择弹窗UI ===============>信 号<===============
#region 信号
signal warning_selected(selected : bool)
#endregion

# TODO 警告选择弹窗UI ===============>常 量<===============
#region 常量

#endregion

# TODO 警告选择弹窗UI ===============>变 量<===============
#region 变量
@onready var warning_label: Label = $MarginContainer/VBoxContainer/WarningLabel

#endregion

# TODO 警告选择弹窗UI ===============>虚方法<===============
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

# TODO 警告选择弹窗UI ===============>信号链接方法<===============
#region 信号链接方法
func _on_yes_button_pressed() -> void:
	warning_selected.emit(true)
	queue_free()

func _on_no_button_pressed() -> void:
	warning_selected.emit(false)
	queue_free()
#endregion

# TODO 警告选择弹窗UI ===============>工具方法<===============
#region 工具方法

#endregion
