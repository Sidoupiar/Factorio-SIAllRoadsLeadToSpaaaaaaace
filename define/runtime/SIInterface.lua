-- ------------------------------------------------------------------------------------------------
-- ------------ 说明 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- [接口管理]
-- 用于管理各种外部接口
-- 由于 MOD 中的各种接口非常多 , 于是有了此功能
-- ----------------------------------------
-- [作用]
-- 对接口进行管理 , 可以方便的导出所有接口
-- ----------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface =
{
	ID = "SIInterface" ,
	Name = "接口管理" ,
	InterfaceID = "SIInterface" ,
	Interfaces = {}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 接口管理 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 注册接口<br>
-- 接口最终会注册进 remote 中<br>
-- 参数的含义对应 remote.add_interface 函数<br>
-- ----------------------------------------
-- interfaceID   = 接口 ID<br>
-- interfaceList = 接口列表<br>
-- ----------------------------------------
function SIInterface.Add( interfaceID , interfaceList )
	if not interfaceID then
		return CodeE( SIInterface , "注册接口时 , 接口 ID 不能为空" )
	end
	if not interfaceList or SITable.Size( interfaceList ) < 1 then
		return CodeE( SIInterface , "注册接口时 , 接口列表不能为空" )
	end
	SIInterface.Interfaces[interfaceID] = interfaceList
	remote.add_interface( interfaceID , interfaceList )
	return SIInterface
end

-- ----------------------------------------
-- 把所有已经注册的接口整理成可以输出的字符串的形式<br>
-- 以表的形式<br>
-- ----------------------------------------
-- 返回值 = 所有已经注册的接口整理成的字符串<br>
-- ----------------------------------------
function SIInterface.ConcatAllInterfaceAsTable()
	local output = {}
	for interfaceID , interfaceList in pairs( SIInterface.Interfaces ) do
		local interfaceIDOut = interfaceID:gsub( "-" , "_" )
		output[interfaceIDOut] =
		{
			ID = interfaceID
		}
		local interfaceListOut = output[interfaceIDOut]
		for interfaceName , interfaceFunction in pairs( interfaceList ) do
			local interfaceNameOut = interfaceName:gsub( "-" , "_" )
			interfaceListOut[interfaceNameOut] = interfaceName
		end
	end
	return SITable.TableToString( output )
end

-- ----------------------------------------
-- 在日志文件中输出所有已经注册的接口<br>
-- 以表的形式<br>
-- ----------------------------------------
function SIInterface.LogAllInterfaceAsTable()
	SIPrint.Log( SIInterface.ConcatAllInterfaceAsTable() )
end

-- ------------------------------------------------------------------------------------------------
-- -------- 添加信息接口 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIInterface.Add( SIInterface.InterfaceID ,
{
	-- 输出信息
	ConcatAllInterfaceAsTable = SIInterface.ConcatAllInterfaceAsTable ,
	LogAllInterfaceAsTable = SIInterface.LogAllInterfaceAsTable
} )