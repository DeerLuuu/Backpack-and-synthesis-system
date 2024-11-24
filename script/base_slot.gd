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
# 格子中的物品
@export var item : BaseItem
# 格子中的物品数量
@export var count : int = 0:
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
# TODO_FUC 格子基类：判断是否有物品
func has_item() -> bool:
	return item != null

# TODO_FUC 格子基类：判断是否满了
func is_full() -> bool:
	return count == MAX_COUNT

# TODO_FUC 格子基类：判断是否能堆叠
func can_stack(other_slot : BaseSlot) -> bool:
	return item == other_slot.item and item.can_stack

# TODO_FUC 格子基类：添加单个物品
func add_one_item() -> BaseSlot:
	var current_slot : BaseSlot = duplicate()
	current_slot.count = 1
	count -= 1
	return current_slot

# TODO_FUC 格子基类：堆叠物品
func stack_item(other_slot : BaseSlot) -> BaseSlot:
	var current_slot : BaseSlot = other_slot
	current_slot.count += count
	if current_slot.count > MAX_COUNT:
		count = current_slot.count - 64
		current_slot.count = 64
	else :
		count = 0
	return current_slot

# TODO_FUC 格子基类：堆叠单个物品
func stack_one_item(other_slot : BaseSlot) -> BaseSlot:
	var current_slot : BaseSlot = other_slot
	current_slot.count += 1
	count -= 1
	return current_slot

# TODO_FUC 格子基类：拿取一半物品
func half_slot() -> BaseSlot:
	var current_slot : BaseSlot = duplicate()
	if count % 2 == 0:
		count /= 2
		current_slot.count = count
	else :
		count /= 2
		current_slot.count = count + 1
	return current_slot
#endregion
