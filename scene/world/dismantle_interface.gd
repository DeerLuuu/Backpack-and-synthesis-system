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
@onready var dismantle_button: Button = $"../../VBoxContainer2/DismantleButton"

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
	print(item_data)
	print(dismantle_items)
#endregion

# TODO 拆解台 ===============>工具方法<===============
#region 工具方法

#endregion
