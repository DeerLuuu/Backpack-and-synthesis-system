#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name BaseCraftTable extends Resource

# TODO 合成表基类 ===============>信 号<===============
#region 信号

#endregion

# TODO 合成表基类 ===============>常 量<===============
#region 常量
enum CraftTabelType{
	THREE,
	FOUR,
	FIVE
}
#endregion

# TODO 合成表基类 ===============>变 量<===============
#region 变量
# 合成表名字
@export var craft_name : String
# 合成表类型
@export_enum("THREE", "FOUR", "FIVE") var craft_table_type : int
# 合成表字典
@export var craft_table_dic : Dictionary
# 物品字典
@export var item_table_dic : Dictionary
# 合成表介绍
@export_multiline var desc : String
#endregion

# TODO 合成表基类 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 合成表基类 ===============>工具方法<===============
#region 工具方法

#endregion
