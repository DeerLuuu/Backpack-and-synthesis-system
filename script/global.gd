#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends Node

# TODO 全局属性 ===============>信 号<===============
#region 信号

#endregion

# TODO 全局属性 ===============>常 量<===============
#region 常量
# 物品 /// /// /// /// /// ///

# /// /// /// /// /// /// ///

# UI /// /// /// /// /// ///
const SLOT = preload("res://scene/ui/slot.tscn")
# /// /// /// /// /// /// ///

# 配方 /// /// /// /// /// ///
const THREE = preload("res://resource/craft_table/three.tres")
# /// /// /// /// /// /// ///
#endregion

# TODO 全局属性 ===============>变 量<===============
#region 变量
var items : Dictionary = {
	"木板" : "res://resource/items/board.tres",
	"木弓" : "res://resource/items/board_archer.tres",
	"铁锭" : "res://resource/items/iron.tres",
	"铁箭" : "res://resource/items/iron_arrow.tres",
	"线" : "res://resource/items/line.tres",
	"长木棍" : "res://resource/items/long_board_stick.tres",
	"空" : "res://resource/items/null.tres",
	"短木棍" : "res://resource/items/short_board_stick.tres",
	"木头" : "res://resource/items/wood.tres",
	"铁铲" : "res://resource/items/iron_shovel.tres"
}
# 玩家背包
var player_backpack = preload("res://resource/player_backpack.tres")
# 玩家鼠标格子容器
var dragged_slot_panel_container: SlotPanelContainer
# 玩家背包格子容器
var player_backpack_grid: PlayerBackInterface
# 合成字典
var craft_table : Dictionary
# 物品字典
var item_table : Dictionary
# Shift 快捷键
var is_shift : bool = false
#endregion

func _shortcut_input(event: InputEvent) -> void:
	if event.is_released():
		is_shift = false
	if event.is_pressed():
		is_shift = event.as_text().begins_with("Shift")

# TODO 全局属性 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 全局：格子按下方法
func _on_slot_clicked(slot_index : int, mouse_button : int, backpack : Node) -> void:
	# 被点击的格子容器
	var click_slot : BaseSlot = backpack.get_child(slot_index).slot
	# 鼠标格子容器
	var dragged_slot : BaseSlot = dragged_slot_panel_container.slot

	# 鼠标左键的操作
	if mouse_button == 0:
		if dragged_slot.has_item() and dragged_slot.can_stack(click_slot) and not click_slot.is_full():
			click_slot = dragged_slot.stack_item(click_slot)

			update_slot(dragged_slot, click_slot, slot_index, backpack)
			return

	# 鼠标右键的操作
	if mouse_button == 1:
		if not dragged_slot.has_item():
			if not click_slot.has_item(): return

			if click_slot.count > 1:
				dragged_slot = click_slot.half_slot()

				update_slot(dragged_slot, click_slot, slot_index, backpack)
				return

		if dragged_slot.count >= 1:
			if not click_slot.has_item():
				click_slot = dragged_slot.add_one_item()

				update_slot(dragged_slot, click_slot, slot_index, backpack)
				return

			if click_slot.can_stack(dragged_slot) and not click_slot.is_full():
				click_slot = dragged_slot.stack_one_item(click_slot)

				update_slot(dragged_slot, click_slot, slot_index, backpack)
				return

	if mouse_button == 2:
		if not click_slot.has_item(): return
		if backpack is PlayerBackInterface: return

		add_item(click_slot.duplicate(), player_backpack_grid)
		click_slot.count = 0

		# 更新格子容器数据
		update_slot(dragged_slot, click_slot, slot_index, backpack)
		return

	var temp_slot : BaseSlot = dragged_slot
	dragged_slot = click_slot
	click_slot = temp_slot

	# 更新格子容器数据
	update_slot(dragged_slot, click_slot, slot_index, backpack)
#endregion

# TODO 全局属性 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 全局：更新格子容器数据方法
func update_slot(dragged_slot : BaseSlot, click_slot : BaseSlot, slot_index : int, backpack : Node) -> void:
	dragged_slot_panel_container.slot = dragged_slot
	backpack.get_child(slot_index).slot = click_slot

func add_item(slot : BaseSlot, backpack_grid : GridContainer) -> void:
	for i : SlotPanelContainer in backpack_grid.get_children():
		if not i.slot.has_item(): continue

		if i.slot.item != slot.item: continue

		if not slot.item.can_stack: continue

		i.slot = slot.stack_item(i.slot)
		i.set_slot_panel()

	for i : SlotPanelContainer in backpack_grid.get_children():
		if slot.count == 0: break

		if i.slot.has_item(): continue

		i.slot = slot
		i.set_slot_panel()
		break

func update_backpack(backpack_grid : GridContainer) -> void:
	for i in backpack_grid.get_child_count():
		player_backpack.slots[i] = backpack_grid.get_child(i).slot

	ResourceSaver.save(player_backpack, "res://resource/player_backpack.tres")
#endregion
