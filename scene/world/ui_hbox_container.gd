#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name UIGridContainer extends GridContainer

# TODO 库存、合成系统的容器UI ===============>信 号<===============
#region 信号

#endregion

# TODO 库存、合成系统的容器UI ===============>常 量<===============
#region 常量

#endregion

# TODO 库存、合成系统的容器UI ===============>变 量<===============
#region 变量
# 玩家背包面板
@onready var player_backpack_panel: PanelContainer = %PlayerBackpackPanel
# 合成面板
@onready var craft_panel: PanelContainer = %CraftPanel
#endregion

# TODO 库存、合成系统的容器UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	# 如果事件是一个键盘事件
	# 如果按下了交互键
	# 开启/关闭合成面板
	if event is InputEventKey:
		if event.is_action_pressed("interact"):
			craft_panel.visible = ! craft_panel.visible


func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 库存、合成系统的容器UI ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 库存、合成系统的容器UI ===============>工具方法<===============
#region 工具方法

#endregion
