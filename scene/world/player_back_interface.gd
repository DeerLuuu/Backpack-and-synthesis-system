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
@onready var dragged_slot_panel_container: SlotPanelContainer = %DraggedSlotPanelContainer
#endregion

# TODO 玩家背包UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	for i in get_children():
		i.queue_free()

	for i in Global.player_backpack.slots:
		var slot : SlotPanelContainer = Global.SLOT.instantiate()
		add_child(slot)
		slot.slot_clicked.connect(_on_slot_clicked)
		if i:
			slot.slot = i

func _process(_delta: float) -> void:
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
func _on_slot_clicked(slot_index : int, mouse_button : int) -> void:
	var click_slot : BaseSlot = get_child(slot_index).slot
	var dragged_slot : BaseSlot = dragged_slot_panel_container.slot

	if mouse_button == 0:
		if dragged_slot.has_item():
			if dragged_slot.item == click_slot.item and click_slot.item.can_stack:
				dragged_slot.item = null
				click_slot.count += dragged_slot.count
				dragged_slot.count = 0
			else :
				var temp_slot : BaseSlot = dragged_slot
				dragged_slot = click_slot
				click_slot = temp_slot

		else :
			var temp_slot : BaseSlot = dragged_slot
			dragged_slot = click_slot
			click_slot = temp_slot
	if mouse_button == 1:
		if dragged_slot.has_item():
			if dragged_slot.count == 1:
				var temp_slot : BaseSlot = dragged_slot
				dragged_slot = click_slot
				click_slot = temp_slot
			elif dragged_slot.count > 1 :
				if click_slot.has_item() and click_slot.item == dragged_slot.item and click_slot.item.can_stack:
					dragged_slot.count -= 1
					click_slot.count += 1
				elif click_slot.has_item() and click_slot.item != dragged_slot.item:
					var temp_slot : BaseSlot = dragged_slot
					dragged_slot = click_slot
					click_slot = temp_slot
				else :
					dragged_slot.count -= 1
					click_slot = dragged_slot.duplicate()
					click_slot.count = 1
		else :
			if click_slot.has_item() and click_slot.count > 1:
				if click_slot.count % 2 == 0:
					click_slot.count /= 2
					dragged_slot = click_slot.duplicate()
				else :
					click_slot.count /= 2
					dragged_slot = click_slot.duplicate()
					dragged_slot.count += 1

	dragged_slot_panel_container.slot = dragged_slot
	get_child(slot_index).slot = click_slot

#endregion

# TODO 玩家背包UI ===============>工具方法<===============
#region 工具方法

#endregion
