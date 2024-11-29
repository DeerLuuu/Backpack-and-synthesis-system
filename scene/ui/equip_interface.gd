#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name EquipInterface extends HBoxContainer

# TODO 装备UI ===============>信 号<===============
#region 信号

#endregion

# TODO 装备UI ===============>常 量<===============
#region 常量
enum Equip{
	HELMET,
	ARMOR,
	ARMLET,
	TROUSERS,
	SHOES,
}
#endregion

# TODO 装备UI ===============>变 量<===============
#region 变量
@onready var head_slot_panel_container: SlotPanelContainer = %HeadSlotPanelContainer
@onready var hand_slot_panel_container: SlotPanelContainer = %HandSlotPanelContainer
@onready var u_body_slot_panel_container: SlotPanelContainer = %UBodySlotPanelContainer
@onready var d_body_slot_panel_container: SlotPanelContainer = %DBodySlotPanelContainer
@onready var leg_slot_panel_container: SlotPanelContainer = %LegSlotPanelContainer
#endregion

# TODO 装备UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	for i in get_children():
		if i is SlotPanelContainer:
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

# TODO 装备UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 装备：格子按下方法
func _on_slot_clicked(slot_index : int, _mouse_button : int, _backpack : Node) -> void:
	if not get_child(slot_index).slot.has_item(): return
	var slot_panel : SlotPanelContainer = get_child(slot_index)
	var equit_index = slot_index / 2
	match equit_index:
		Equip.HELMET:
			if not item_is_equip(slot_panel, equit_index):
				Global.add_item(slot_panel.slot, Global.player_backpack_grid)
				slot_panel.slot = BaseSlot.new()
				return
			print("更新玩家属性···")
		Equip.ARMOR:
			if not item_is_equip(slot_panel, equit_index):
				Global.add_item(slot_panel.slot, Global.player_backpack_grid)
				slot_panel.slot = BaseSlot.new()
				return
			print("更新玩家属性···")
		Equip.ARMLET:
			if not item_is_equip(slot_panel, equit_index):
				Global.add_item(slot_panel.slot, Global.player_backpack_grid)
				slot_panel.slot = BaseSlot.new()
				return
			print("更新玩家属性···")
		Equip.TROUSERS:
			if not item_is_equip(slot_panel, equit_index):
				Global.add_item(slot_panel.slot, Global.player_backpack_grid)
				slot_panel.slot = BaseSlot.new()
				return
			print("更新玩家属性···")
		Equip.SHOES:
			if not item_is_equip(slot_panel, equit_index):
				Global.add_item(slot_panel.slot, Global.player_backpack_grid)
				slot_panel.slot = BaseSlot.new()
				return
			print("更新玩家属性···")

#endregion

# TODO 装备UI ===============>工具方法<===============
#region 工具方法
func item_is_equip(slot_panel : SlotPanelContainer, equit_index : int) -> bool:
	if not slot_panel.slot.has_item(): return false
	if slot_panel.slot.item is not EquipItem: return false
	if slot_panel.slot.item.equip_type != equit_index: return false
	return true
#endregion
