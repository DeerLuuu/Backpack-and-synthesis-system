#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name EquipItem extends BaseItem

# TODO 装备物品 ===============>信 号<===============
#region 信号

#endregion

# TODO 装备物品 ===============>常 量<===============
#region 常量
enum Equip{
	HELMET,
	ARMOR,
	ARMLET,
	TROUSERS,
	SHOES,
}
#endregion

# TODO 装备物品 ===============>变 量<===============
#region 变量
@export_enum("HELMET", "ARMOR", "ARMLET", "TROUSERS", "SHOES") var equip_type : int
@export var physical_reactance : float
@export var magic_reactance : float
#endregion

# TODO 装备物品 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 装备物品 ===============>工具方法<===============
#region 工具方法

#endregion
