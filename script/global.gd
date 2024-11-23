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
const BOARD = preload("res://resource/items/board.tres")
const BOARD_ARCHER = preload("res://resource/items/board_archer.tres")
const IRON = preload("res://resource/items/iron.tres")
const IRON_ARROW = preload("res://resource/items/iron_arrow.tres")
const LINE = preload("res://resource/items/line.tres")
const LONG_BOARD_STICK = preload("res://resource/items/long_board_stick.tres")
const NULL = preload("res://resource/items/null.tres")
const SHORT_BOARD_STICK = preload("res://resource/items/short_board_stick.tres")
const WOOD = preload("res://resource/items/wood.tres")
# /// /// /// /// /// /// ///
const THREE = preload("res://resource/craft_table/three.tres")
# UI /// /// /// /// /// ///
const SLOT = preload("res://scene/ui/slot.tscn")
# /// /// /// /// /// /// ///

# 配方 /// /// /// /// /// ///

# /// /// /// /// /// /// ///
#endregion

# TODO 全局属性 ===============>变 量<===============
#region 变量
var player_backpack = preload("res://resource/player_backpack.tres")
var dragged_slot_panel_container: SlotPanelContainer
var craft_table : Dictionary
var item_table : Dictionary
#endregion

# TODO 全局属性 ===============>信号链接方法<===============
#region 信号链接方法
func _on_slot_clicked(slot_index : int, mouse_button : int, backpack : Node) -> void:
	var click_slot : BaseSlot = backpack.get_child(slot_index).slot
	var dragged_slot : BaseSlot = dragged_slot_panel_container.slot

	if mouse_button == 0:
		if dragged_slot.has_item() and dragged_slot.can_stack(click_slot) and not click_slot.is_full():
			click_slot = dragged_slot.stack_item(click_slot)

			update_slot(dragged_slot, click_slot, slot_index, backpack)
			return

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

			if click_slot.can_stack(dragged_slot):
				click_slot = dragged_slot.stack_one_item(click_slot)

				update_slot(dragged_slot, click_slot, slot_index, backpack)
				return

	var temp_slot : BaseSlot = dragged_slot
	dragged_slot = click_slot
	click_slot = temp_slot

	update_slot(dragged_slot, click_slot, slot_index, backpack)
#endregion

# TODO 全局属性 ===============>工具方法<===============
#region 工具方法
func update_slot(dragged_slot : BaseSlot, click_slot : BaseSlot, slot_index : int, backpack : Node) -> void:
	dragged_slot_panel_container.slot = dragged_slot
	backpack.get_child(slot_index).slot = click_slot
#endregion
