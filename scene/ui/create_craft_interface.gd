#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends GridContainer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var slot_9: SlotPanelContainer = $"../Slot9"
@onready var count_spin: SpinBox = %CountSpin
@onready var time_spin: SpinBox = %TimeSpin
@onready var create_craft_button: Button = %CreateCraftButton
@onready var ui_grid_container: UIGridContainer = $"../../../../../../.."
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	for i : SlotPanelContainer in get_children():
		i.slot_clicked.connect(Global._on_slot_clicked)
		i.slot_clicked.connect(_on_slot_clicked)

	slot_9.slot_clicked.connect(Global._on_slot_clicked)
	slot_9.slot_clicked.connect(_on_slot_clicked)

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
# TODO_FUC 创建合成表：格子容器：点击信号
func _on_slot_clicked(_slot_index : int, _mouse_button : int, _backpack : Node) -> void:
	var create_slot_is_null = true
	var final_slot_is_null = true
	for i : SlotPanelContainer in get_children():
		if i.slot.has_item():
			create_slot_is_null = false
			continue

	final_slot_is_null = not slot_9.slot.has_item()

	create_craft_button.disabled = create_slot_is_null or final_slot_is_null

func _on_create_craft_button_pressed() -> void:
	# 物品位码数组
	var index : Array[int]
	# 物品配方数组
	var craft : Array[String]
	# 单个位码的临时存储变量
	var number : int = 0
	# 覆盖合成表
	var overwrite_craft_teable : Callable = func(selected : bool) -> void:
		if not selected: return
		save_carft_table(index, craft)

	# 判断并生成合成台中格子物品对应的配方表
	for i : SlotPanelContainer in get_children():
		if i.slot.item == null:
			number += 1
			continue
		craft.append(i.slot.item.item_name)
		if not craft.is_empty():
			index.append(number)
			number = 0

	# 去掉第一个位码，在结尾添加-1位码
	index.pop_front()
	index.push_back(-1)

	if Global.craft_table.has(slot_9.slot.item.item_name):
		var warning_select_panel : WarningSelectPanel = Global.WARNING_SELECT_PANEL.instantiate()
		ui_grid_container.get_parent().add_child(warning_select_panel)
		warning_select_panel.warning_selected.connect(overwrite_craft_teable)
		return

	save_carft_table(index, craft)
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func save_carft_table(indexs, crafts) -> void:
	Global.craft_table[slot_9.slot.item.item_name] = {"位码" : indexs, "配方" : crafts}
	Global.item_table[slot_9.slot.item.item_name] = {"制作时间" : time_spin.value, "数量" : count_spin.value}

	var file : BaseCraftTable = load("res://resource/craft_table/three.tres") as BaseCraftTable
	file.craft_table_dic = Global.craft_table
	file.item_table_dic = Global.item_table
	ResourceSaver.save(file, "res://resource/craft_table/three.tres")
#endregion
