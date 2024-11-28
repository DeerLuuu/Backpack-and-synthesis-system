#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name EquipInterface extends VBoxContainer

# TODO 装备UI ===============>信 号<===============
#region 信号

#endregion

# TODO 装备UI ===============>常 量<===============
#region 常量

#endregion

# TODO 装备UI ===============>变 量<===============
#region 变量
@onready var head_slot_panel_container: SlotPanelContainer = %HeadSlotPanelContainer
@onready var l_hand_slot_panel_container: SlotPanelContainer = %LHandSlotPanelContainer
@onready var u_body_slot_panel_container: SlotPanelContainer = %UBodySlotPanelContainer
@onready var r_hand_slot_panel_container: SlotPanelContainer = %RHandSlotPanelContainer
@onready var d_body_slot_panel_container: SlotPanelContainer = %DBodySlotPanelContainer
@onready var l_leg_slot_panel_container: SlotPanelContainer = %LLegSlotPanelContainer
@onready var r_leg_slot_panel_container: SlotPanelContainer = %RLegSlotPanelContainer

#endregion

# TODO 装备UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	head_slot_panel_container.slot_clicked.connect(Global._on_slot_clicked)
	l_hand_slot_panel_container.slot_clicked.connect(Global._on_slot_clicked)
	u_body_slot_panel_container.slot_clicked.connect(Global._on_slot_clicked)
	r_hand_slot_panel_container.slot_clicked.connect(Global._on_slot_clicked)
	d_body_slot_panel_container.slot_clicked.connect(Global._on_slot_clicked)
	l_leg_slot_panel_container.slot_clicked.connect(Global._on_slot_clicked)
	r_leg_slot_panel_container.slot_clicked.connect(Global._on_slot_clicked)

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

#endregion

# TODO 装备UI ===============>工具方法<===============
#region 工具方法

#endregion
