#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name DismantleInterface extends GridContainer

# TODO 拆解台 ===============>信 号<===============
#region 信号

#endregion

# TODO 拆解台 ===============>常 量<===============
#region 常量

#endregion

# TODO 拆解台 ===============>变 量<===============
#region 变量
@onready var slot_panel_container_9: SlotPanelContainer = $"../../VBoxContainer2/SlotPanelContainer9"
@onready var craft_progress_bar: ProgressBar = %CraftProgressBar
@onready var craft_timer: Timer = %CraftTimer
@onready var dismantle_button: Button = $"../../VBoxContainer2/DismantleButton"
@onready var craft_h_box_container: HBoxContainer = %CraftHBoxContainer
@onready var dismantle_h_box_container: HBoxContainer = %DismantleHBoxContainer

#endregion

# TODO 拆解台 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	for i : SlotPanelContainer in get_children():
		i.slot_clicked.connect(Global._on_slot_clicked)

	slot_panel_container_9.slot_clicked.connect(Global._on_slot_clicked)
	slot_panel_container_9.slot_clicked.connect(_on_slot_clicked)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 拆解台 ===============>信号链接方法<===============
#region 信号链接方法
func _on_slot_clicked(_slot_index : int, _mouse_button : int, _backpack : Node) -> void:
	dismantle_button.disabled = true
	if not slot_panel_container_9.slot.has_item(): return
	dismantle_button.disabled = not slot_panel_container_9.slot.item.can_dismantle


func _on_dismantle_button_pressed() -> void:
	var item_name : String = slot_panel_container_9.slot.item.item_name
	var item_data : Dictionary = Global.item_table[item_name]
	var dismantle_items : Dictionary = Global.craft_table[item_name]
	var final_items : Array

	# 物品拆解时间开始
	craft_timer.start(item_data["制作时间"] * 2)
	# 物品制作进度条初始化
	craft_progress_bar.max_value = item_data["制作时间"] * 2
	# 制作物品按钮禁用
	dismantle_button.disabled = true
	# 等待计时结束
	await craft_timer.timeout
	# 制作物品按钮启用
	dismantle_button.disabled = false
	for i in dismantle_items["配方"]:
		var r : int = randi() % 100
		if r > 55: continue
		final_items.append(i)

	# 制作完成暂停计时器
	craft_timer.stop()

	slot_panel_container_9.slot.count -= 1
	dismantle_button.disabled = slot_panel_container_9.slot.count == 0
	slot_panel_container_9.set_slot_panel()

	for item in final_items:
		var current_slot : BaseSlot = BaseSlot.new()
		current_slot.count = 1
		current_slot.item = load(Global.items[item])
		for i : SlotPanelContainer in get_children():
			if not i.slot.has_item():
				i.slot = current_slot
				i.set_slot_panel()
				break

			if i.slot.item.item_name != current_slot.item.item_name: continue
			if not i.slot.item.can_stack: continue
			i.slot.count += 1
			i.set_slot_panel()
			break

func _on_switch_dismantle_button_pressed() -> void:
	dismantle_h_box_container.show()
	craft_h_box_container.hide()

#endregion

# TODO 拆解台 ===============>工具方法<===============
#region 工具方法

#endregion
