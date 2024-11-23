#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name BaseSlot extends Resource

# TODO 格子基类 ===============>信 号<===============
#region 信号

#endregion

# TODO 格子基类 ===============>常 量<===============
#region 常量
const MAX_COUNT : int = 64
#endregion

# TODO 格子基类 ===============>变 量<===============
#region 变量
@export var item : BaseItem
@export var count : int = 1:
	set(v):
		count = v
		if count == 0:
			item = null
#endregion

# TODO 格子基类 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 格子基类 ===============>工具方法<===============
#region 工具方法
func has_item() -> bool:
	return item != null

func can_stack(other_slot : BaseSlot) -> bool:
	return item == other_slot.item and item.can_stack and count + other_slot.count < MAX_COUNT

func add_one_item(other_slot : BaseSlot) -> BaseSlot:
	var current_slot : BaseSlot = duplicate()
	current_slot.count = 1
	count -= 1
	return current_slot

func stack_item(other_slot : BaseSlot) -> BaseSlot:
	var current_slot : BaseSlot = other_slot
	current_slot.count += count
	count = 0
	return current_slot

func stack_one_item(other_slot : BaseSlot) -> BaseSlot:
	var current_slot : BaseSlot = other_slot
	current_slot.count += 1
	count -= 1
	return current_slot

func half_slot(other_slot : BaseSlot) -> BaseSlot:
	var current_slot : BaseSlot = duplicate()
	if count % 2 == 0:
		count /= 2
		current_slot.count = count
	else :
		count /= 2
		current_slot.count = count + 1
	return current_slot
#endregion
