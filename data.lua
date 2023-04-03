if not SIInstrumentMode then
	require( "utils" )
end

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInit
.AutoLoadState( SIInit.StateCodeDefine.Data )
.AutoLoad()
-- 如果你想在附属 MOD 中使用这个框架 , 则仅需在 settings.lua , data.lua , control.lua 中使用 SIInit.AutoLoad 函数即可 ( 不要在其他文件中使用 )
-- 使用方法可以参考我做的其他附属 MOD
--
-- 定义 : package 中的每个文件夹都可以看作是一个 "功能包"
--
-- 函数 SIInit.AutoLoad( ModName , CustomPackageConfig , ConstantsDataPrefix , ShowNamePrefix ) 说明
-- 这个函数拥有 4 个参数 :
-- 参数 1 : MOD 的名称 , 即 info.json 中的 "name" 值
-- 参数 2 : MOD 内的 package 文件夹中的功能包设置数组 , 具体结构请见本 MOD 的 package 文件夹的结构和 PackageConfig.lua 文件
--         每个功能包都应该包含着此功能相关的所有实体 , 原型和逻辑相关的代码 ( 和资源 )
--         其中的 0_ConstantsData.lua 为保留名称 , 其结构含义请见 package/0000_core/0_ConstantsData.lua 中的注释
--         数据结构是 package 文件夹中这些的文件夹的名称字符串组成的数组
-- 参数 3 : MOD 中加载的 ConstantsData 在作为全局变量时添加的前缀 , 防止重名 , 不影响注册的原型数据
-- 参数 4 : MOD 中加载的 ConstantsData 在注册和显示时添加的前缀 , 防止重名 , 影响注册的原型数据和本地化字符串 , 生成原型数据名称时此前缀也会被包含进去
--
-- 外部调用这个函数时 , 除了第 2 个参数外 , 其余 3 个参数均不能为 nil
-- 对于第 2 个参数 , 如果值为 nil , 则会尝试加载 MOD 文件夹下的 PackageConfig.lua 文件 , 文件不存在则会报错
--
-- 使用栗子 :
-- SIInit.AutoLoad( "TextMOD" , { { PackageName = "feature1" } , { PackageName = "feature2" } } , "Text_" , "Text" )
--
-- 含义 :
-- 注册 TextMod 这个模组
-- 使用 "Text_" 作为加载的 ConstantsData 的 [ ClassName ] 前缀
-- 使用 "Text" 作为加载的 ConstantsData 的 [ ShowName ] 前缀 , [ ShowName ] 作为物品等的 [ name ] 中的前缀时 , 后面会自动添加 "-"
-- 加载 TextMOD 的文件 , __TextMOD__/package/feature1/0_ConstantsData.lua , 并根据其返回值加载其 FileList 子表中的文件
-- 加载 TextMOD 的文件 , __TextMOD__/package/feature2/0_ConstantsData.lua , 并根据其返回值加载其 FileList 子表中的文件
--
-- 实在不清楚 ConstantsData 的结构可以使用 SIPrint.ErrorTable( ConstantsData ) 来格式化输出 ConstantsData 的内容



-- ------------------------------------------------------------------------------------------------
-- ---------- 预备内容 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------
--
-- 待处理 :
-- 10.增加矿物
-- 18.增加超级坦克
-- 20.增加子弹和武装流程
-- 21.开局获得指导手册 ( 流程起点 )
-- 22.增加远端拍卖机
-- 24.权限管理增加管理员列表和权限组支持
-- 25.增加多周目继承
-- 27.增加传输机
-- 31.椰子产品线
-- 32.墨汁产品线
-- 33.造纸产品线
-- 34.一套新的传送带 , 包括地下传送带 , 筛选器 , 装卸机 , 堆叠机
-- 35.超级加倍污染仪 , 什么工作也不做 , 专业施放污染 , 有 1000 倍满效率矿机的污染能力
-- 36.一套新的箱子 , 包括各种尺寸 , 2x2 , 3x3 , 4x4 , 6x6 , 11x11 , 以及 4x2 和 11x3
-- 37.齿轮箱逻辑