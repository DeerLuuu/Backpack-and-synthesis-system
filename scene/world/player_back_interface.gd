#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name PlayerBackInterface extends GridContainer

# TODO 玩家背包UI ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家背包UI ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家背包UI ===============>变 量<===============
#region 变量
# 玩家鼠标格子容器
@onready var dragged_slot_panel_container: SlotPanelContainer = %DraggedSlotPanelContainer
#endregion

# TODO 玩家背包UI ===============>虚方法<===============
#region 常用的虚方法
func _ready() -> void:
	# 初始化
	for i in get_children():
		i.queue_free()

	# 创建背包格子并链接点击格子的全局信号方法
	for i in Global.player_backpack.slots:
		var slot : SlotPanelContainer = Global.SLOT.instantiate()
		add_child(slot)
		slot.slot_clicked.connect(Global._on_slot_clicked)
		if not i: continue
		slot.slot = i

	# 将全局鼠标格子容器指定为当前场景的鼠标格子容器
	Global.dragged_slot_panel_container = dragged_slot_panel_container

func _process(_delta: float) -> void:
	# 鼠标格子容器是否显示，以及鼠标格子容器跟随玩家鼠标
	if dragged_slot_panel_container.visible:
		dragged_slot_panel_container.global_position = get_global_mouse_position() + Vector2(16, 16)
	dragged_slot_panel_container.visible = dragged_slot_panel_container.slot != null
func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 玩家背包UI ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家背包UI ===============>工具方法<===============
#region 工具方法

#endregion
