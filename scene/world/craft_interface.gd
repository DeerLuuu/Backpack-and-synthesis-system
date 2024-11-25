#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name CraftInterface extends GridContainer

# TODO 合成台UI ===============>信 号<===============
#region 信号
# WARNING 还没用
# 制作的物品满了时发出的信号
signal final_slot_panel_is_full(slot : BaseSlot)
#endregion

# TODO 合成台UI ===============>常 量<===============
#region 常量

#endregion

# TODO 合成台UI ===============>变 量<===============
#region 变量
# 当前制作的物品的格子容器
@onready var slot_panel_container_9: SlotPanelContainer = %SlotPanelContainer9
# 制作完的物品的格子容器
@onready var slot_panel_container_10: SlotPanelContainer = %SlotPanelContainer10
# 制作按钮
@onready var craft_button: Button = %CraftButton
# 物品制作数量输入框
@onready var craft_item_count_spin: SpinBox = %CraftItemCountSpin
# 物品制作进度条
@onready var craft_progress_bar: ProgressBar = %CraftProgressBar
# 物品制作计时器
@onready var craft_timer: Timer = %CraftTimer

# 最大物品数量
var max_craft_item_count : int = 1
# 配方单词制作多少个物品
var craft_item_count : int = 1:
	set(v):
		craft_item_count = v
		max_craft_item_count = craft_item_count
		craft_item_count_spin.value = craft_item_count
# 物品制作时间
var craft_item_time : float = 0.

#endregion

# TODO 合成台UI ===============>虚方法<===============
#region 常用的虚方法
func _ready() -> void:
	# 将合成台中的格子进行信号链接
	for i : SlotPanelContainer in get_children():
		i.slot_clicked.connect(Global._on_slot_clicked)
		i.slot_clicked.connect(_on_slot_clicked)

	slot_panel_container_9.slot_clicked.connect(Global._on_slot_clicked)
	slot_panel_container_10.slot_clicked.connect(Global._on_slot_clicked)
	slot_panel_container_10.slot_clicked.connect(_on_slot_clicked)

	# 获得合成字典和物品字典
	Global.craft_table = Global.THREE.craft_table_dic
	Global.item_table = Global.THREE.item_table_dic

func _process(_delta: float) -> void:
	# 制作物品进度条的更新
	craft_progress_bar.value = craft_progress_bar.max_value - craft_timer.time_left
#endregion

# TODO 合成台UI ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 合成台：格子容器：点击信号
func _on_slot_clicked(_slot_index : int, mouse_button : int, _backpack : Node) -> void:
	# 物品位码数组
	var index : Array[int]
	# 物品配方数组
	var craft : Array[String]
	# 单个位码的临时存储变量
	var number : int = 0
	# 当前合成台上的物品组成的合成表
	var current_craft_table : Dictionary

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

	# 初始化配方物品格子
	slot_panel_container_9.slot.item = null

	# 如果没找到直接跳过后续代码
	if not Global.craft_table.find_key(current_craft_table): return

	# 物品名称、物品数组、物品路径、物品资源、格子资源的变量
	var item_name : String = Global.craft_table.find_key(current_craft_table)
	var item_dic : Dictionary = Global.item_table[item_name]
	var item_path : String = item_dic["资源路径"]
	var item : BaseItem = load(item_path)
	var slot : BaseSlot = BaseSlot.new()

	# 单次制作物品的数量、物品制作时间
	craft_item_count = item_dic["数量"]
	craft_item_time = item_dic["制作时间"]

	# 配方物品格子的更新
	slot.count = craft_item_count
	slot.item = item
	slot_panel_container_9.slot = slot

	# 更新物品最大合成数量
	craft_item_max_value()

# TODO_FUC 合成台：制作按钮：pressed 信号方法
func _on_craft_button_pressed() -> void:
	# 如果当前没有配方跳过
	if not slot_panel_container_9.slot.has_item(): return

	# 制作多少次
	for count in max_craft_item_count / craft_item_count:
		# 如果当前物品满了跳过
		if slot_panel_container_10.slot.is_full(): break

		# 物品制作时间开始
		craft_timer.start(craft_item_time)
		# 物品制作进度条初始化
		craft_progress_bar.max_value = craft_item_time
		# 制作物品按钮禁用
		craft_button.disabled = true
		# 等待计时结束
		await craft_timer.timeout
		# 制作物品按钮启用
		craft_button.disabled = false

		# 消耗物品
		for i : SlotPanelContainer in get_children():
			if i.slot.count <= 0: continue
			i.slot.count -= 1
			i.set_slot_panel()

		# 如果制作完物品格子容器里面已经有物品直接加数字，否则直接复制配方格子
		if slot_panel_container_10.slot.has_item():
			slot_panel_container_10.slot.count += craft_item_count
			slot_panel_container_10.set_slot_panel()
			continue

		slot_panel_container_10.slot = slot_panel_container_9.slot.duplicate()
		slot_panel_container_10.set_slot_panel()

	# 制作完成暂停计时器
	craft_timer.stop()
	# 更新最大制作数量
	craft_item_max_value()

# TODO_FUC 合成台：制作数量输入框：指更新信号方法
func _on_craft_item_count_spin_value_changed(value: float) -> void:
	if value > craft_item_count_spin.max_value:
		max_craft_item_count = craft_item_count_spin.max_value
		return
	max_craft_item_count = value

# TODO_FUC 合成台：最小制作数量按钮：pressed 信号方法
func _on_min_count_button_pressed() -> void:
	craft_item_count_spin.value = craft_item_count

# TODO_FUC 合成台：最大制作数量按钮：pressed 信号方法
func _on_max_count_button_pressed() -> void:
	craft_item_count_spin.value = craft_item_count_spin.max_value
#endregion

# TODO 合成台UI ===============>工具方法<===============
#region 工具方法
# TODO_FUC 合成台：获取最大制作数量
func craft_item_max_value() -> void:
	var min_number : int = 64
	var is_null : bool = true
	for i : SlotPanelContainer in get_children():
		if i.slot.count <= 0: continue

		if i.slot.count >= min_number: continue

		is_null = false
		min_number = i.slot.count

	if is_null:
		craft_item_count_spin.max_value = 0
	else :
		craft_item_count_spin.max_value = min_number * craft_item_count
#endregion
