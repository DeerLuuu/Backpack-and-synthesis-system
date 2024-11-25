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
	# 当前合成台上的物品组成的合成表
	var current_craft_table : Dictionary
	# 当前合成的物品数据
	var current_item_table : Dictionary

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
	index.append(-1)
	current_craft_table = {"位码" : index, "配方" : craft}
	current_item_table = {"制作时间" : time_spin.value, "数量" : count_spin.value}

	Global.craft_table[slot_9.slot.item.item_name] = {"位码" : index, "配方" : craft}
	Global.item_table[slot_9.slot.item.item_name] = {"制作时间" : time_spin.value, "数量" : count_spin.value}
	#print(Global.craft_table)
	#print(Global.item_table)
	var file : BaseCraftTable = load("res://resource/craft_table/three.tres") as BaseCraftTable
	file.craft_table_dic = Global.craft_table
	file.item_table_dic = Global.item_table
	ResourceSaver.save(file, "res://resource/craft_table/three.tres")
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
