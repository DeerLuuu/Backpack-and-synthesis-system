#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name CraftInterface extends GridContainer

# TODO 合成台UI ===============>信 号<===============
#region 信号

#endregion

# TODO 合成台UI ===============>常 量<===============
#region 常量

#endregion

# TODO 合成台UI ===============>变 量<===============
#region 变量

#endregion

# TODO 合成台UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	for i : SlotPanelContainer in get_children():
		i.slot_clicked.connect(Global._on_slot_clicked)
		i.slot_clicked.connect(_on_slot_clicked)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 合成台UI ===============>信号链接方法<===============
#region 信号链接方法
func _on_slot_clicked(slot_index : int, mouse_button : int, backpack : Node) -> void:
	print("合成表检测")
#endregion

# TODO 合成台UI ===============>工具方法<===============
#region 工具方法

#endregion
