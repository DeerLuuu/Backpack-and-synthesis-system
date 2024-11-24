#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name SlotPanelContainer extends PanelContainer

# TODO 格子UI ===============>信 号<===============
#region 信号
signal slot_clicked(slot_index : int, mouse_index : int, slot_parent : Node)
#endregion

# TODO 格子UI ===============>常 量<===============
#region 常量
@onready var slot_texture: TextureRect = %SlotTexture
@onready var count_label: Label = %CountLabel
@export var slot : BaseSlot :
	set(v):
		slot = v
		if slot == null: return
		if slot.item == null or slot.item == Global.NULL: return
		set_slot_panel(slot)
#endregion

# TODO 格子UI ===============>变 量<===============
#region 变量

#endregion

# TODO 格子UI ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if not slot.has_item():
		reset_slot_panel()

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_left"):
			slot_clicked.emit(get_index(), 0, get_parent())
		elif event.is_action_pressed("mouse_right"):
			slot_clicked.emit(get_index(), 1, get_parent())
#endregion

# TODO 格子UI ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 格子UI ===============>工具方法<===============
#region 工具方法
func reset_slot_panel() -> void:
	slot_texture.texture = null
	count_label.hide()
	count_label.text = ""

func set_slot_panel(_slot : BaseSlot = slot) -> void:
	if _slot.item:
		if _slot.item.item_texture:
			slot_texture.texture = _slot.item.item_texture

	if _slot.count > 1:
		count_label.show()
		count_label.text = "%s" % _slot.count
	else :
		count_label.hide()
		count_label.text = ""
#endregion
