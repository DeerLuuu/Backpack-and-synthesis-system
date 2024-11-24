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
var current_craft_table : Dictionary
@onready var slot_panel_container_9: SlotPanelContainer = %SlotPanelContainer9
@onready var slot_panel_container_10: SlotPanelContainer = %SlotPanelContainer10
@onready var craft_button: Button = %CraftButton
@onready var craft_item_count_spin: SpinBox = %CraftItemCountSpin
@onready var craft_progress_bar: ProgressBar = %CraftProgressBar
@onready var craft_timer: Timer = $"../../../CraftTimer"

var craft_item_count : int = 1
#endregion

# TODO 合成台UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	for i : SlotPanelContainer in get_children():
		i.slot_clicked.connect(Global._on_slot_clicked)
		i.slot_clicked.connect(_on_slot_clicked)

	slot_panel_container_9.slot_clicked.connect(Global._on_slot_clicked)
	slot_panel_container_10.slot_clicked.connect(Global._on_slot_clicked)
	slot_panel_container_10.slot_clicked.connect(_on_slot_clicked)

	Global.craft_table = Global.THREE.craft_table_dic
	Global.item_table = Global.THREE.item_table_dic


func _process(_delta: float) -> void:
	craft_progress_bar.value = craft_timer.time_left

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 合成台UI ===============>信号链接方法<===============
#region 信号链接方法
func _on_slot_clicked(_slot_index : int, mouse_button : int, _backpack : Node) -> void:
	var index : Array[int]
	var craft : Array[String]
	var number : int = 0
	for i : SlotPanelContainer in get_children():
		if i.slot.item == null:
			number += 1
			continue
		craft.append(i.slot.item.item_name)
		if not craft.is_empty():
			index.append(number)
			number = 0
	index.pop_front()
	index.append(-1)
	current_craft_table = {"位码" : index, "配方" : craft}

	if Global.craft_table.find_key(current_craft_table):
		var item_name : String = Global.craft_table.find_key(current_craft_table)
		var item_path : String = Global.item_table[item_name]

		var item : BaseItem = load(item_path)
		var slot : BaseSlot = BaseSlot.new()
		slot.count = 1
		slot.item = item
		slot_panel_container_9.slot = slot
		craft_item_max_value()
	else :
		var slot : BaseSlot = BaseSlot.new()
		slot_panel_container_9.slot = slot

func _on_craft_button_pressed() -> void:
	if slot_panel_container_9.slot.has_item():
		for count in craft_item_count:
			for i : SlotPanelContainer in get_children():
				if i.slot.count > 0:
					i.slot.count -= 1
					i.set_slot_panel()

			if slot_panel_container_10.slot.has_item():
				slot_panel_container_10.slot.count += 1
				slot_panel_container_10.set_slot_panel()
			else :
				slot_panel_container_10.slot = slot_panel_container_9.slot.duplicate()
				slot_panel_container_10.slot.count = 1
				slot_panel_container_10.set_slot_panel()

			craft_timer.start(.1)
			craft_progress_bar.max_value = .1
			await craft_timer.timeout
		craft_timer.stop()
	craft_item_max_value()

func _on_craft_item_count_spin_value_changed(value: float) -> void:
	if value > craft_item_count_spin.max_value:
		craft_item_count = craft_item_count_spin.max_value
	else :
		craft_item_count = value

func _on_min_count_button_pressed() -> void:
	craft_item_count_spin.value = 1

func _on_max_count_button_pressed() -> void:
	craft_item_count_spin.value = craft_item_count_spin.max_value
#endregion

# TODO 合成台UI ===============>工具方法<===============
#region 工具方法
func craft_item_max_value() -> void:
	var min_number : int = 0
	for i : SlotPanelContainer in get_children():
		if i.slot.count > 0:
			if i.slot.count < min_number and min_number != 0:
				min_number = i.slot.count
			else :
				min_number = i.slot.count
	craft_item_count_spin.max_value = min_number
#endregion
