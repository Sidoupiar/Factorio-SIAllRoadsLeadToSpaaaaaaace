-- ------------------------------------------------------------------------------------------------
-- ---------- 定义数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen =
{
	-- 固定属性
	ID = "SIGen" ,
	Name = "构造器" ,
	StylePath = GetCorePath() .. "/define/data/graphic/控件贴图.png" ,
	-- 动态属性
	CurrentPrototypeData = nil ,
	CurrentStyleData = nil ,
	CurrentGroup = nil ,
	CurrentSubgroup = nil ,
	TempConstantsData = nil ,
	TypeCallback = {}
}

local raw = {}
local style = {}
local hasFinish = false

-- ------------------------------------------------------------------------------------------------
-- --- 查询数据和修改原型数据 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 根据给定的 type 和 name 查找原型数据<br>
-- 如果找到了匹配的原型数据 , 则把这个原型数据作为参数调用回调函数<br>
-- 位于 SIGen 内部和 data 内部的原型数据均可被查找到<br>
-- 如果 SIGen 内部和 data 内部均有匹配的原型数据 , 则以 SIGen 中的为准<br>
-- 只有第一个被找到的原型数据会调用回调函数<br>
-- 如果没有找到任何匹配的原型数据 , 则会调用一次参数为 nil 的回调函数<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- prototypeName         = 原型数据的 [ name ] 值<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.Find( typeCode , prototypeName , callback )
	if not typeCode then
		return CodeE( SIGen , "查找原型数据时 , 不能使用空的原型类型" )
	end
	if not hasFinish and raw[typeCode] and raw[typeCode][prototypeName] then
		local prototypeData = raw[typeCode][prototypeName]
		callback( prototypeName , prototypeData )
		if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
			return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
		end
		return SIGen
	end
	if data.raw[typeCode] and data.raw[typeCode][prototypeName] then
		local prototypeData = data.raw[typeCode][prototypeName]
		callback( prototypeName , prototypeData )
		if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
			return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
		end
		return SIGen
	end
	callback( nil , nil )
	return SIGen
end

-- ----------------------------------------
-- 根据给定的 type 查找原型数据 , 会找到所有符合的原型数据<br>
-- 对于每个匹配的原型数据 , 都会把那个原型数据作为参数调用一次回调函数<br>
-- 位于 SIGen 内部和 data 内部的原型数据均可被查找到<br>
-- 如果 SIGen 内部和 data 内部均有匹配的原型数据 , 则它们都会被找到<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.ForEach( typeCode , callback )
	if not typeCode then
		return CodeE( SIGen , "遍历原型数据时 , 不能使用空的原型类型" )
	end
	if not hasFinish and raw[typeCode] then
		for prototypeName , prototypeData in pairs( raw[typeCode] ) do
			callback( prototypeName , prototypeData )
			if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
				return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
			end
		end
	end
	if data.raw[typeCode] then
		for prototypeName , prototypeData in pairs( data.raw[typeCode] ) do
			callback( prototypeName , prototypeData )
			if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
				return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
			end
		end
	end
	return SIGen
end

-- ----------------------------------------
-- 根据一个 type 数组来查找原型数据 , 会找到所有符合的原型数据<br>
-- type 数组中的每个 type 值都会作为条件进行查找<br>
-- 对于每个匹配的原型数据 , 都会把那个原型数据作为参数调用一次回调函数<br>
-- 位于 SIGen 内部和 data 内部的原型数据均可被查找到<br>
-- 如果 SIGen 内部和 data 内部均有匹配的原型数据 , 则它们都会被找到<br>
-- ----------------------------------------
-- typeCodeList          = 原型数据的 [ type ] 值数组 , 这个数组只关心它的 [值] 的部分<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.ForEachType( typeCodeList , callback )
	if not typeCodeList then
		return CodeE( SIGen , "遍历原型数据时 , 不能使用空的原型类型列表" )
	end
	for typeCodeIndex , typeCode in pairs( typeCodeList ) do
		if not hasFinish and raw[typeCode] then
			for prototypeName , prototypeData in pairs( raw[typeCode] ) do
				callback( prototypeName , prototypeData )
				if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
					return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
				end
			end
		end
		if data.raw[typeCode] then
			for prototypeName , prototypeData in pairs( data.raw[typeCode] ) do
				callback( prototypeName , prototypeData )
				if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
					return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
				end
			end
		end
	end
	return SIGen
end

-- ----------------------------------------
-- 根据给定的 type 和 name 查找原型数据<br>
-- 如果找到了匹配的原型数据 , 则把这个原型数据作为参数调用回调函数<br>
-- 只有位于 SIGen 内部的原型数据可被查找到<br>
-- 只有第一个被找到的原型数据会调用回调函数<br>
-- 如果没有找到任何匹配的原型数据 , 则会调用一次参数为 nil 的回调函数<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- prototypeName         = 原型数据的 [ name ] 值<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.FindInner( typeCode , prototypeName , callback )
	if not typeCode then
		return CodeE( SIGen , "查找原型数据时 , 不能使用空的原型类型" )
	end
	if not hasFinish and raw[typeCode] and raw[typeCode][prototypeName] then
		local prototypeData = raw[typeCode][prototypeName]
		callback( prototypeName , prototypeData )
		if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
			return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
		end
		return SIGen
	end
	callback( nil , nil )
	return SIGen
end

-- ----------------------------------------
-- 根据给定的 type 查找原型数据 , 会找到所有符合的原型数据<br>
-- 对于每个匹配的原型数据 , 都会把那个原型数据作为参数调用一次回调函数<br>
-- 只有位于 SIGen 内部的原型数据可被查找到<br>
-- 如果 SIGen 内部有匹配的原型数据 , 则它们会被找到<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.ForEachInner( typeCode , callback )
	if not typeCode then
		return CodeE( SIGen , "遍历原型数据时 , 不能使用空的原型类型" )
	end
	if not hasFinish and raw[typeCode] then
		for prototypeName , prototypeData in pairs( raw[typeCode] ) do
			callback( prototypeName , prototypeData )
			if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
				return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
			end
		end
	end
	return SIGen
end

-- ----------------------------------------
-- 根据一个 type 数组来查找原型数据 , 会找到所有符合的原型数据<br>
-- type 数组中的每个 type 值都会作为条件进行查找<br>
-- 对于每个匹配的原型数据 , 都会把那个原型数据作为参数调用一次回调函数<br>
-- 只有位于 SIGen 内部的原型数据可被查找到<br>
-- 如果 SIGen 内部有匹配的原型数据 , 则它们会被找到<br>
-- ----------------------------------------
-- typeCodeList          = 原型数据的 [ type ] 值数组 , 这个数组只关心它的 [值] 的部分<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.ForEachTypeInner( typeCodeList , callback )
	if not typeCodeList then
		return CodeE( SIGen , "遍历原型数据时 , 不能使用空的原型类型列表" )
	end
	for typeCodeIndex , typeCode in pairs( typeCodeList ) do
		if not hasFinish and raw[typeCode] then
			for prototypeName , prototypeData in pairs( raw[typeCode] ) do
				callback( prototypeName , prototypeData )
				if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
					return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
				end
			end
		end
	end
	return SIGen
end

-- ----------------------------------------
-- 根据给定的 type 和 name 查找原型数据<br>
-- 如果找到了匹配的原型数据 , 则把这个原型数据作为参数调用回调函数<br>
-- 只有位于 data 内部的原型数据可被查找到<br>
-- 只有第一个被找到的原型数据会调用回调函数<br>
-- 如果没有找到任何匹配的原型数据 , 则会调用一次参数为 nil 的回调函数<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- prototypeName         = 原型数据的 [ name ] 值<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.FindOuter( typeCode , prototypeName , callback )
	if not typeCode then
		return CodeE( SIGen , "查找原型数据时 , 不能使用空的原型类型" )
	end
	if data.raw[typeCode] and data.raw[typeCode][prototypeName] then
		local prototypeData = data.raw[typeCode][prototypeName]
		callback( prototypeName , prototypeData )
		if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
			return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
		end
		return SIGen
	end
	callback( nil , nil )
	return SIGen
end

-- ----------------------------------------
-- 根据给定的 type 查找原型数据 , 会找到所有符合的原型数据<br>
-- 对于每个匹配的原型数据 , 都会把那个原型数据作为参数调用一次回调函数<br>
-- 只有位于 data 内部的原型数据可被查找到<br>
-- 如果 data 内部有匹配的原型数据 , 则它们会被找到<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.ForEachOuter( typeCode , callback )
	if not typeCode then
		return CodeE( SIGen , "遍历原型数据时 , 不能使用空的原型类型" )
	end
	if data.raw[typeCode] then
		for prototypeName , prototypeData in pairs( data.raw[typeCode] ) do
			callback( prototypeName , prototypeData )
			if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
				return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
			end
		end
	end
	return SIGen
end

-- ----------------------------------------
-- 根据一个 type 数组来查找原型数据 , 会找到所有符合的原型数据<br>
-- type 数组中的每个 type 值都会作为条件进行查找<br>
-- 对于每个匹配的原型数据 , 都会把那个原型数据作为参数调用一次回调函数<br>
-- 只有位于 data 内部的原型数据可被查找到<br>
-- 如果 data 内部有匹配的原型数据 , 则它们会被找到<br>
-- ----------------------------------------
-- typeCodeList          = 原型数据的 [ type ] 值数组 , 这个数组只关心它的 [值] 的部分<br>
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.ForEachTypeOuter( typeCodeList , callback )
	if not typeCodeList then
		return CodeE( SIGen , "遍历原型数据时 , 不能使用空的原型类型列表" )
	end
	for typeCodeIndex , typeCode in pairs( typeCodeList ) do
		if data.raw[typeCode] then
			for prototypeName , prototypeData in pairs( data.raw[typeCode] ) do
				callback( prototypeName , prototypeData )
				if typeCode ~= prototypeData.type or prototypeName ~= prototypeData.name then
					return CodeE( SIGen , "修改原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
				end
			end
		end
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- -------- 添加原型数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 在 SIGen 中注册原型数据<br>
-- 用法与 data:extend 一致 , 效果也一致<br>
-- 但是效果仅局限在 SIGen 内部<br>
-- ----------------------------------------
-- prototypeList         = 原型数据的数组<br>
-- ----------------------------------------
function SIGen.Extend( prototypeList )
	if hasFinish then
		return CodeE( SIGen , "流程已经结束 , 无法使用 SIGen.Extend 函数" )
	end
	if not prototypeList or SITable.Size( prototypeList ) < 1 then
		return SIGen
	end
	for prototypeIndex , prototypeData in pairs( prototypeList ) do
		if prototypeData then
			if not prototypeData.type then
				return CodeE( SIGen , "添加原型时 , 原型数据必须包含 [ type ] 属性" )
			end
			if not prototypeData.name then
				return CodeE( SIGen , "添加原型时 , 原型数据必须包含 [ name ] 属性" )
			end
			if raw[prototypeData.type] then
				raw[prototypeData.type][prototypeData.name] = prototypeData
			else
				raw[prototypeData.type] = { [prototypeData.name] = prototypeData }
			end
		end
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ----- 创建和完善原型数据 -----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 设置 SIGen 在创建原型数据时使用的分组信息<br>
-- ----------------------------------------
-- subgroupName          = 子分组的 [ name ] 值<br>
-- ----------------------------------------
function SIGen.SetGroup( subgroupName )
	return SIGen.Find( SICommon.Types.Subgroup , subgroupName , function( prototypeName , prototypeData )
		if prototypeData and prototypeData.group then
			SIGen.CurrentGroup = prototypeData.group
			SIGen.CurrentSubgroup = subgroupName
		else
			CodeE( SIGen , "设置子分组时 , 不能设置不存在或没有 <group> 属性的子分组" )
		end
	end )
end

-- ----------------------------------------
-- 设置 SIGen 在创建原型数据时使用的 ConstantsData<br>
-- 如果不设置默认使用 SIInit.CurrentPrototypeData<br>
-- ----------------------------------------
-- ConstantsData         = 任意一个 ConstantsData 表<br>
-- ----------------------------------------
function SIGen.SetConstantsData( ConstantsData )
	SIGen.TempConstantsData = ConstantsData
	return SIGen
end

-- ----------------------------------------
-- 移除 SIGen 中的 ConstantsData 设置<br>
-- 不设置时使用 SIInit.CurrentPrototypeData<br>
-- ----------------------------------------
function SIGen.RemoveConstantsData()
	SIGen.TempConstantsData = nil
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 创建一个新的原型数据 , 并使用 prototypeDataToCopy 来作为数据的基础<br>
-- 不设置 prototypeDataToCopy 则是一个空的原型数据<br>
-- SIGen 会自动将新的原型数据进行注册 , 并自动生成一些属性<br>
-- localised_name        = { "[ CodeName ]Name.[ 类型别名 ]-[ 别名或 ID ]" } , 子分组就时子分组的别名和 ID<br>
-- localised_description = { "[ CodeName ]Description.[ 类型别名 ]-[ 别名或 ID ]" } , 子分组就时子分组的别名和 ID<br>
-- group , subgroup 和 order 会被自动补充<br>
-- 当用来复制数据的原型数据中存在 localised_name 和 localised_description 时 , 对应的属性不会再自动创建<br>
-- ----------------------------------------
-- typeCode              = 原型数据的类型 , 等于 [ type ] 属性<br>
-- prototypeID           = ID , 用于计算 [ name ] 值和在 ConstantsData.raw 中注册<br>
-- aliasName             = 别名 , 和 ConstantsData.Autoload 中的别名一样 , 在计算 [ name ] 值时代替 ID 进行计算 , 影响本地化字符串 , 不影响 ConstantsData.raw 中的注册<br>
-- prototypeDataToCopy   = 用来复制数据的原型数据<br>
-- ----------------------------------------
function SIGen.New( typeCode , prototypeID , aliasName , prototypeDataToCopy )
	if not typeCode then
		return CodeE( SIGen , "创建原型数据时 , [ type ] 的值不能为空" )
	end
	if not prototypeID then
		return CodeE( SIGen , "创建原型数据时 , ID 不能为空" )
	end
	if not SIGen.CurrentSubgroup then
		return CodeE( SIGen , "创建原型数据时 , 需要先通过 SIGen.SetGroup 函数设置一个可用的子分组" )
	end
	if not SICommon.ShowNamePrefix[typeCode] then
		return CodeE( SIGen , "构造器无法创建不支持的类型的原型数据 , 当前类型 = " .. typeCode )
	end
	if typeCode == SICommon.Types.Group or typeCode == SICommon.Types.Subgroup then
		return CodeE( SIGen , "构造器不可以创建分组 , 请使用 ConstantsData.Autoload 进行创建" )
	end
	if hasFinish then
		return CodeE( SIGen , "流程已经结束 , 无法使用 SIGen.New 函数" )
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local showNamePrefix = SICommon.ShowNamePrefix[typeCode]
	local showName = showNamePrefix .. ( aliasName or prototypeID ):gsub( "_" , "-" )
	local realName = constantsData.ShowNamePrefix .. showName
	if raw[typeCode] and raw[typeCode][realName] then
		return CodeE( SIGen , "同名原型数据已存在 , prototypeName = " .. realName )
	end
	local rawCode = SICommon.Types.Raw[typeCode]
	if constantsData.raw[rawCode] and constantsData.raw[rawCode][prototypeID] then
		return CodeE( SIGen , "同 ID 原型数据已存在 , prototypeID = " .. prototypeID )
	end
	local prototypeData = prototypeDataToCopy and SIUtils.table.deepcopy( prototypeDataToCopy ) or {}
	prototypeData.type = typeCode
	prototypeData.name = realName
	if not prototypeData.localised_name then
		prototypeData.localised_name = { constantsData.CodeName .. "Name." .. showName }
	end
	if not prototypeData.localised_description then
		prototypeData.localised_description = { constantsData.CodeName .. "Description." .. showName }
	end
	prototypeData.group = SIGen.CurrentGroup
	prototypeData.subgroup = SIGen.CurrentSubgroup
	prototypeData.order = constantsData.GetOrderString()
	prototypeData.SIGenData =
	{
		ShowName = showName ,
		ShowNamePrefix = showNamePrefix
	}
	SIGen.CurrentPrototypeData = prototypeData
	if raw[typeCode] then
		raw[typeCode][realName] = prototypeData
	else
		raw[typeCode] = { [realName] = prototypeData }
	end
	if constantsData.raw[rawCode] then
		constantsData.raw[rawCode][prototypeID] = realName
	else
		constantsData.raw[rawCode] = { [prototypeID] = realName }
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 向此原型数据中添加另一个原型的数据 , 普通表也可以<br>
-- 添加的数据会被直接复制 , 被复制的原型数据中的表或数组发了的修改的话 , 此原型数据的相应表或数组也会发生修改<br>
-- ----------------------------------------
-- prototypeData         = 被复制的原型数据 , 其中 [ type ] 属性和 [ name ] 属性不会被复制<br>
-- ----------------------------------------
function SIGen.Append( prototypeData )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	for key , value in pairs( prototypeData ) do
		if key ~= "type" and key ~= "name" and key ~= "SIGenData" then
			SIGen.CurrentPrototypeData[key] = value
		end
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 向此原型数据中添加另一个原型的数据 , 普通表也可以<br>
-- 添加的数据会被深度复制 , 被复制的原型数据发了的修改不会影响此原型数据<br>
-- ----------------------------------------
-- prototypeDataToCopy   = 被复制的原型数据 , 其中 [ type ] 属性和 [ name ] 属性不会被复制<br>
-- ----------------------------------------
function SIGen.Import( prototypeDataToCopy )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	local prototypeData = SIUtils.table.deepcopy( prototypeDataToCopy )
	for key , value in pairs( prototypeData ) do
		if key ~= "type" and key ~= "name" and key ~= "SIGenData" then
			SIGen.CurrentPrototypeData[key] = value
		end
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 向此原型数据中添加一对键值对<br>
-- ----------------------------------------
-- key                   = 属性名称 , 不能是 [ type ] 和 [ name ]<br>
-- value                 = 属性的值 , 不限类型<br>
-- ----------------------------------------
function SIGen.AddParameter( key , value )
	if key == "type" or key == "name" then
		return CodeE( SIGen , "完善原型数据属性时 , 不允许修改其 [ type ] 属性和 [ name ] 属性的值" )
	end
	if key == "SIGenData" then
		return CodeE( SIGen , "完善原型数据属性时 , 不允许修改其 [ SIGenData ] 属性的值" )
	end
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	SIGen.CurrentPrototypeData[key] = value
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 向此原型数据中添加图标代码<br>
-- icon                  = "[ PicturePath ][ 类型别名 ]-[ 别名或 ID ]-[ 类型别名 ICON 项 ].png"<br>
-- ----------------------------------------
-- iconFileName          = 图标文件名 , 文件位置是相对于 ConstantsData.PicturePath 的 , 不需要后缀<br>
-- size                  = 图标的宽高像素数量<br>
-- mipmaps               = 图标分级 , 默认是 0 , 原版物品图标是 4 , 查看原版的图片文件就能知道它的含义了<br>
-- ----------------------------------------
function SIGen.AddIcon( iconFileName , size , mipmaps )
	if not iconFileName then
		return CodeE( SIGen , "完善原型数据属性时 , 图标文件名称不能为空" )
	end
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	if SIGen.CurrentPrototypeData.icon then
		local oldIcon =
		{
			icon = SIGen.CurrentPrototypeData.icon ,
			icon_size = SIGen.CurrentPrototypeData.icon_size ,
			icon_mipmaps = SIGen.CurrentPrototypeData.icon_mipmaps
		}
		SIGen.CurrentPrototypeData.icon = nil
		if SIGen.CurrentPrototypeData.icons then
			table.insert( SIGen.CurrentPrototypeData.icons , oldIcon )
		else
			SIGen.CurrentPrototypeData.icons = { oldIcon }
		end
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local iconSettings = SICommon.Numbers.IconSettings[SIGen.CurrentPrototypeData.type] or SICommon.Numbers.IconSettings.Default
	local icon =
	{
		icon = constantsData.PicturePath .. SIGen.CurrentPrototypeData.SIGenData.ShowNamePrefix .. iconFileName .. SICommon.ShowNameSuffix.ICON .. ".png" ,
		icon_size = size or iconSettings.size ,
		icon_mipmaps = mipmaps or iconSettings.mipmaps
	}
	if SIGen.CurrentPrototypeData.icons then
		table.insert( SIGen.CurrentPrototypeData.icons , icon )
	else
		SIGen.CurrentPrototypeData.icons = { icon }
		SIGen.CurrentPrototypeData.icon_size = iconSettings.size
		SIGen.CurrentPrototypeData.icon_mipmaps = iconSettings.mipmaps
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 向此原型数据中添加图标代码<br>
-- 根据给定的 [ type ] 值进行计算 , 而非使用原型数据自己的 [ type ] 值<br>
-- icon                  = "[ PicturePath ][ 类型别名 ]-[ 别名或 ID ]-[ 类型别名 ICON 项 ].png"<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- iconFileName          = 图标文件名 , 文件位置是相对于 ConstantsData.PicturePath 的 , 不需要后缀<br>
-- size                  = 图标的宽高像素数量<br>
-- mipmaps               = 图标分级 , 默认是 0 , 原版物品图标是 4 , 查看原版的图片文件就能知道它的含义了<br>
-- ----------------------------------------
function SIGen.MakeIcon( typeCode , iconFileName , size , mipmaps )
	if not iconFileName then
		return CodeE( SIGen , "完善原型数据属性时 , 图标文件名称不能为空" )
	end
	if not typeCode or not SICommon.ShowNamePrefix[typeCode] then
		return CodeE( SIGen , "构造器无法创建不支持的类型的原型数据 , 当前类型 = " .. tostring( typeCode ) )
	end
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	if SIGen.CurrentPrototypeData.icon then
		local oldIcon =
		{
			icon = SIGen.CurrentPrototypeData.icon ,
			icon_size = SIGen.CurrentPrototypeData.icon_size ,
			icon_mipmaps = SIGen.CurrentPrototypeData.icon_mipmaps
		}
		SIGen.CurrentPrototypeData.icon = nil
		if SIGen.CurrentPrototypeData.icons then
			table.insert( SIGen.CurrentPrototypeData.icons , oldIcon )
		else
			SIGen.CurrentPrototypeData.icons = { oldIcon }
		end
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local iconSettings = SICommon.Numbers.IconSettings[SIGen.CurrentPrototypeData.type] or SICommon.Numbers.IconSettings.Default
	local icon =
	{
		icon = constantsData.PicturePath .. SICommon.ShowNamePrefix[typeCode] .. iconFileName .. SICommon.ShowNameSuffix.ICON .. ".png" ,
		icon_size = size or iconSettings.size ,
		icon_mipmaps = mipmaps or iconSettings.mipmaps
	}
	if SIGen.CurrentPrototypeData.icons then
		table.insert( SIGen.CurrentPrototypeData.icons , icon )
	else
		SIGen.CurrentPrototypeData.icons = { icon }
		SIGen.CurrentPrototypeData.icon_size = iconSettings.size
		SIGen.CurrentPrototypeData.icon_mipmaps = iconSettings.mipmaps
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 向此原型数据中添加图标代码 , 使用默认值<br>
-- icon                  = "[ PicturePath ][ 类型别名 ]-[ 别名或 ID ]-[ 类型别名 ICON 项 ].png"<br>
-- ----------------------------------------
function SIGen.AutoIcon()
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	if SIGen.CurrentPrototypeData.icon then
		local oldIcon =
		{
			icon = SIGen.CurrentPrototypeData.icon ,
			icon_size = SIGen.CurrentPrototypeData.icon_size ,
			icon_mipmaps = SIGen.CurrentPrototypeData.icon_mipmaps
		}
		SIGen.CurrentPrototypeData.icon = nil
		if SIGen.CurrentPrototypeData.icons then
			table.insert( SIGen.CurrentPrototypeData.icons , oldIcon )
		else
			SIGen.CurrentPrototypeData.icons = { oldIcon }
		end
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local iconSettings = SICommon.Numbers.IconSettings[SIGen.CurrentPrototypeData.type] or SICommon.Numbers.IconSettings.Default
	local icon =
	{
		icon = constantsData.PicturePath .. SIGen.CurrentPrototypeData.SIGenData.ShowName .. SICommon.ShowNameSuffix.ICON .. ".png" ,
		icon_size = iconSettings.size ,
		icon_mipmaps = iconSettings.mipmaps
	}
	if SIGen.CurrentPrototypeData.icons then
		table.insert( SIGen.CurrentPrototypeData.icons , icon )
	else
		SIGen.CurrentPrototypeData.icons = { icon }
		SIGen.CurrentPrototypeData.icon_size = iconSettings.size
		SIGen.CurrentPrototypeData.icon_mipmaps = iconSettings.mipmaps
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 根据宽高的值来创建实体的选择区域和碰撞区域<br>
-- 由于游戏引擎限制 , 碰撞区域时整数的话 , 会导致实体无法相邻摆放 , 因此默认碰撞区域比选择区域小 0.025 单位<br>
-- 正是因为小了 0.025 单位 , 这就导致了实体之间实际上是有一条小缝的 , 玩家或许可以挤过去 , 大概<br>
-- 如果需要控制缩放比例可以使用 SIGen.SetSizeSize 函数 , 或干脆直接手写属性<br>
-- ----------------------------------------
-- width                 = 实体的宽度<br>
-- height                = 实体的高度<br>
-- ----------------------------------------
function SIGen.SetSize( width , height )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	local halfWidth = width / 2.0
	local halfHeight = height / 2.0
	SIGen.CurrentPrototypeData.selection_box = { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	halfWidth = halfWidth - 0.025
	halfHeight = halfHeight - 0.025
	if halfWidth > 0 and halfHeight > 0 then
		SIGen.CurrentPrototypeData.collision_box = { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 根据宽高的值来创建实体的选择区域和碰撞区域<br>
-- 和 SIGen.SetSize 函数的效果一样 , 只不过可以自己调节碰撞区域到底缩小多少<br>
-- ----------------------------------------
-- width                 = 实体的宽度<br>
-- height                = 实体的高度<br>
-- size                  = 碰撞区域的减小量 , 相比于选择区域<br>
-- ----------------------------------------
function SIGen.SetSizeSize( width , height , size )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	local halfWidth = width / 2.0
	local halfHeight = height / 2.0
	local halfSize = size / 2.0
	SIGen.CurrentPrototypeData.selection_box = { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	halfWidth = halfWidth - halfSize
	halfHeight = halfHeight - halfSize
	if halfWidth > 0 and halfHeight > 0 then
		SIGen.CurrentPrototypeData.collision_box = { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的原型数据<br>
-- 根据宽高的值来创建实体的选择区域和碰撞区域<br>
-- 和 SIGen.SetSize 函数的效果一样 , 只不过可以自己调节碰撞区域到底缩小多少<br>
-- ----------------------------------------
-- width                 = 实体的宽度<br>
-- height                = 实体的高度<br>
-- scale                 = 碰撞区域的实际大小倍率 , 相比于选择区域<br>
-- ----------------------------------------
function SIGen.SetSizeScale( width , height , scale )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	local halfWidth = width / 2.0
	local halfHeight = height / 2.0
	SIGen.CurrentPrototypeData.selection_box = { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	if scale > 0 then
		halfWidth = halfWidth * scale
		halfHeight = halfHeight * scale
		SIGen.CurrentPrototypeData.collision_box = { { -halfWidth , -halfHeight } , { halfWidth , halfHeight } }
	end
	return SIGen
end

-- ----------------------------------------
-- 借助函数来使用 SIGen 完善最新创建的原型数据<br>
-- 参数中的回调函数会立刻被调用<br>
-- 这只是一种语法糖 , 并没有什么特别的含义<br>
-- ----------------------------------------
-- callback              = 回调函数 , 有 2 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身<br>
-- ----------------------------------------
function SIGen.AddFunction( callback )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	callback( SIGen.CurrentPrototypeData.name , SIGen.CurrentPrototypeData )
	return SIGen
end

-- ----------------------------------------
-- 在 SIGen 中可以给一个原型数据添加最终构建回调函数<br>
-- 当 SIGen 处于流程末尾时 , 内部逻辑会按照添加的顺序挨个调用最终构建回调函数<br>
-- 这些最终构建回调函数会在 type 的最终构建回调函数调用完毕后再调用<br>
-- 可以添加多个最终构建回调函数<br>
-- ----------------------------------------
-- callback              = 回调函数 , 有 3 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身 , 参数 3 = 注册的顺序索引<br>
-- ----------------------------------------
function SIGen.AddCallback( callback )
	if not callback then
		return CodeE( SIGen , "完善原型数据属性时 , 回调函数不能为空" )
	end
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以完善它" )
	end
	if SIGen.CurrentPrototypeData.SIGenData.Callbacks then
		table.insert( SIGen.CurrentPrototypeData.SIGenData.Callbacks , callback )
	else
		SIGen.CurrentPrototypeData.SIGenData.Callbacks = { callback }
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---- 类型默认值和回调函数 ----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 在 SIGen 中可以给一个 type 的原型数据添加最终构建回调函数<br>
-- 当 SIGen 处于流程末尾时 , 内部逻辑会按照添加的顺序挨个调用最终构建回调函数<br>
-- 位于 SIGen 中的符合给定 type 的所有原型数据都会作为参数调用一次回调函数<br>
-- 如果原型数据也存在最终构建回调函数 , 则此处的最终构建回调函数会在它们之前完成全部调用<br>
-- 每个 type 都可以添加多个最终构建回调函数<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- callback              = 回调函数 , 有 3 个参数 , 参数 1 = 原型数据的 [ name ] 值 , 参数 2 = 原型数据本身 , 参数 3 = 注册的顺序索引<br>
-- ----------------------------------------
function SIGen.AddFinalCallback( typeCode , callback )
	if not callback then
		return CodeE( SIGen , "不能添加空值作为原型数据最终构建回调函数" )
	end
	if hasFinish then
		return CodeE( SIGen , "流程已经结束 , 无法使用 SIGen.AddFinalCallback 函数" )
	end
	if SIGen.TypeCallback[typeCode] then
		table.insert( SIGen.TypeCallback[typeCode] , callback )
	else
		SIGen.TypeCallback[typeCode] = { callback }
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 交叉数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 把当前实体类型的原型数据添加至目标物品的 place_result 属性中<br>
-- ----------------------------------------
-- targetPrototypeType   = 目标物品的类型<br>
-- targetPrototypeName   = 目标物品的名称<br>
-- ----------------------------------------
function SIGen.ReferencePlaceResult( targetPrototypeType , targetPrototypeName )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以使用 SIGen.ReferencePlaceResult 函数" )
	end
	if not SITable.Has( SICommon.Types.Entities , SIGen.CurrentPrototypeData.type ) then
		return CodeE( SIGen , "无法把非实体类型的原型数据添加至目标物品的 place_result 属性中 , 当前类型 = " .. tostring( SIGen.CurrentPrototypeData.type ) )
	end
	if not SITable.Has( SICommon.Types.Items , targetPrototypeType ) then
		return CodeE( SIGen , "无法给非物品类型的原型数据添加交叉引用数据 , 当前类型 = " .. tostring( targetPrototypeType ) )
	end
	SIGen.Find( targetPrototypeType , targetPrototypeName , function( prototypeName , prototypeData )
		if prototypeData then
			prototypeData.place_result = SIGen.CurrentPrototypeData.name
		else
			CodeE( SIGen , "无法给不存在的目标物品添加交叉引用数据 , 当前类型 = " .. tostring( targetPrototypeType ) .. " , 原型名称 = " .. tostring( targetPrototypeName )  )
		end
	end )
	return SIGen
end

-- ----------------------------------------
-- 把当前模块类型的原型数据添加至目标物品的 placed_as_equipment_result 属性中<br>
-- ----------------------------------------
-- targetPrototypeType   = 目标物品的类型<br>
-- targetPrototypeName   = 目标物品的名称<br>
-- ----------------------------------------
function SIGen.ReferenceEquipmentResult( targetPrototypeType , targetPrototypeName )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以使用 SIGen.ReferenceEquipmentResult 函数" )
	end
	if not SITable.Has( SICommon.Types.Equipments , SIGen.CurrentPrototypeData.type ) then
		return CodeE( SIGen , "无法把非模块类型的原型数据添加至目标物品的 placed_as_equipment_result 属性中 , 当前类型 = " .. tostring( SIGen.CurrentPrototypeData.type ) )
	end
	if not SITable.Has( SICommon.Types.Items , targetPrototypeType ) then
		return CodeE( SIGen , "无法给非物品类型的原型数据添加交叉引用数据 , 当前类型 = " .. tostring( targetPrototypeType ) )
	end
	SIGen.Find( targetPrototypeType , targetPrototypeName , function( prototypeName , prototypeData )
		if prototypeData then
			prototypeData.placed_as_equipment_result = SIGen.CurrentPrototypeData.name
		else
			CodeE( SIGen , "无法给不存在的目标物品添加交叉引用数据 , 当前类型 = " .. tostring( targetPrototypeType ) .. " , 原型名称 = " .. tostring( targetPrototypeName )  )
		end
	end )
	return SIGen
end

-- ----------------------------------------
-- 把当前配方类型的原型数据添加至目标科技的 effects 属性中<br>
-- ----------------------------------------
-- technologyName        = 目标科技的名称<br>
-- ----------------------------------------
function SIGen.ReferenceUnlockRecipe( technologyName )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以使用 SIGen.ReferenceUnlockRecipe 函数" )
	end
	if SIGen.CurrentPrototypeData.type ~= SICommon.Types.Recipe then
		return CodeE( SIGen , "无法把非配方类型的原型数据添加至目标科技的 effects 属性中 , 当前类型 = " .. tostring( SIGen.CurrentPrototypeData.type ) )
	end
	SIGen.Find( SICommon.Types.Technology , technologyName , function( prototypeName , prototypeData )
		if prototypeData then
			table.insert( prototypeData.effects ,
			{
				type = SICommon.Flags.TechnologyModifier.UnlockRecipe ,
				recipe = SIGen.CurrentPrototypeData.name
			} )
		else
			CodeE( SIGen , "无法给不存在的目标科技添加交叉引用数据 , 当前类型 = " .. SICommon.Types.Technology .. " , 原型名称 = " .. tostring( technologyName )  )
		end
	end )
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 辅助函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 用于计算作为原型数据显示名称的本地化字符串<br>
-- 使用原型数据自己的 [ type ] 值进行计算<br>
-- ----------------------------------------
-- name                  = 本地化字符串的键后半部分的值<br>
-- ...                   = 本地化字符串的追加参数 , 不定长<br>
-- ----------------------------------------
-- 返回值                 = 计算好的本地化字符串<br>
-- ----------------------------------------
function SIGen.MakeSelfLocalisedName( name , ... )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以使用 SIGen.MakeSelfLocalisedName 函数" )
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local localisedString = { constantsData.CodeName .. "Name." .. SIGen.CurrentPrototypeData.SIGenData.ShowNamePrefix .. name }
	for index , parameter in pairs{ ... } do
		table.insert( localisedString , parameter )
	end
	return localisedString
end

-- ----------------------------------------
-- 用于计算作为原型数据显示名称的本地化字符串<br>
-- 根据给定的 [ type ] 值进行计算 , 而非使用原型数据自己的 [ type ] 值<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- name                  = 本地化字符串的键后半部分的值<br>
-- ...                   = 本地化字符串的追加参数 , 不定长<br>
-- ----------------------------------------
-- 返回值                 = 计算好的本地化字符串<br>
-- ----------------------------------------
function SIGen.MakeLocalisedName( typeCode , name , ... )
	if not SICommon.ShowNamePrefix[typeCode] then
		return CodeE( SIGen , "构造器无法操作不支持的类型的原型数据 , 当前类型 = " .. typeCode )
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local localisedString = { constantsData.CodeName .. "Name." .. SICommon.ShowNamePrefix[typeCode] .. name }
	for index , parameter in pairs{ ... } do
		table.insert( localisedString , parameter )
	end
	return localisedString
end

-- ----------------------------------------
-- 用于计算作为原型数据显示描述的本地化字符串<br>
-- 使用原型数据自己的 [ type ] 值进行计算<br>
-- ----------------------------------------
-- name                  = 本地化字符串的键后半部分的值<br>
-- ...                   = 本地化字符串的追加参数 , 不定长<br>
-- ----------------------------------------
-- 返回值                 = 计算好的本地化字符串<br>
-- ----------------------------------------
function SIGen.MakeSelfLocalisedDescription( name , ... )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以使用 SIGen.MakeSelfLocalisedDescription 函数" )
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local localisedString = { constantsData.CodeName .. "Description." .. SIGen.CurrentPrototypeData.SIGenData.ShowNamePrefix .. name }
	for index , parameter in pairs{ ... } do
		table.insert( localisedString , parameter )
	end
	return localisedString
end

-- ----------------------------------------
-- 用于计算作为原型数据显示描述的本地化字符串<br>
-- 根据给定的 [ type ] 值进行计算 , 而非使用原型数据自己的 [ type ] 值<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- name                  = 本地化字符串的键后半部分的值<br>
-- ...                   = 本地化字符串的追加参数 , 不定长<br>
-- ----------------------------------------
-- 返回值                 = 计算好的本地化字符串<br>
-- ----------------------------------------
function SIGen.MakeLocalisedDescription( typeCode , name , ... )
	if not SICommon.ShowNamePrefix[typeCode] then
		return CodeE( SIGen , "构造器无法操作不支持的类型的原型数据 , 当前类型 = " .. typeCode )
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local localisedString = { constantsData.CodeName .. "Description." .. SICommon.ShowNamePrefix[typeCode] .. name }
	for index , parameter in pairs{ ... } do
		table.insert( localisedString , parameter )
	end
	return localisedString
end

-- ----------------------------------------
-- 用于计算图片位置的函数<br>
-- 此处的图片位置不会自动添加名称后缀 , 会自动添加文件扩展名 (.png)<br>
-- 使用原型数据自己的 [ type ] 值进行计算<br>
-- ----------------------------------------
-- pictureName           = 图片名称 , 不需要添加扩展名<br>
-- ----------------------------------------
-- 返回值                 = 计算好的图片位置<br>
-- ----------------------------------------
function SIGen.MakeSelfPicturePath( pictureName )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以使用 SIGen.GetPicturePath 函数" )
	end
	return ( SIGen.TempConstantsData or SIInit.CurrentConstantsData ).PicturePath .. SIGen.CurrentPrototypeData.SIGenData.ShowNamePrefix .. pictureName .. ".png"
end

-- ----------------------------------------
-- 用于计算图片位置的函数<br>
-- 此处的图片位置不会自动添加名称后缀 , 会自动添加文件扩展名 (.png)<br>
-- 根据给定的 [ type ] 值进行计算 , 而非使用原型数据自己的 [ type ] 值<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- pictureName           = 图片名称 , 不需要添加扩展名<br>
-- ----------------------------------------
-- 返回值                 = 计算好的图片位置<br>
-- ----------------------------------------
function SIGen.MakePicturePath( typeCode , pictureName )
	if not SICommon.ShowNamePrefix[typeCode] then
		return CodeE( SIGen , "构造器无法操作不支持的类型的原型数据 , 当前类型 = " .. typeCode )
	end
	return ( SIGen.TempConstantsData or SIInit.CurrentConstantsData ).PicturePath .. SICommon.ShowNamePrefix[typeCode] .. pictureName .. ".png"
end

-- ----------------------------------------
-- 用于计算图片位置的函数<br>
-- 此处的图片位置不会自动添加名称后缀 , 会自动添加文件扩展名 (.png)<br>
-- 不使用 [ type ] 值进行计算<br>
-- ----------------------------------------
-- pictureName           = 图片名称 , 不需要添加扩展名<br>
-- ----------------------------------------
-- 返回值                 = 计算好的图片位置<br>
-- ----------------------------------------
function SIGen.MakeRawPicturePath( pictureName )
	return ( SIGen.TempConstantsData or SIInit.CurrentConstantsData ).PicturePath .. pictureName .. ".png"
end

-- ----------------------------------------
-- 用于计算声音位置的函数<br>
-- 此处的声音位置不会自动添加名称后缀 , 会自动添加文件扩展名 (.png)<br>
-- 使用原型数据自己的 [ type ] 值进行计算<br>
-- ----------------------------------------
-- soundName             = 声音名称 , 不需要添加扩展名<br>
-- ----------------------------------------
-- 返回值                 = 计算好的声音位置<br>
-- ----------------------------------------
function SIGen.MakeSelfSoundPath( soundName )
	if not SIGen.CurrentPrototypeData then
		return CodeE( SIGen , "需要先创建新的原型数据 , 之后才可以使用 SIGen.GetSoundPath 函数" )
	end
	return ( SIGen.TempConstantsData or SIInit.CurrentConstantsData ).SoundPath .. SIGen.CurrentPrototypeData.SIGenData.ShowNamePrefix .. soundName .. ".ogg"
end

-- ----------------------------------------
-- 用于计算声音位置的函数<br>
-- 此处的声音位置不会自动添加名称后缀 , 会自动添加文件扩展名 (.png)<br>
-- 根据给定的 [ type ] 值进行计算 , 而非使用原型数据自己的 [ type ] 值<br>
-- ----------------------------------------
-- typeCode              = 原型数据的 [ type ] 值<br>
-- soundName             = 声音名称 , 不需要添加扩展名<br>
-- ----------------------------------------
-- 返回值                 = 计算好的声音位置<br>
-- ----------------------------------------
function SIGen.MakeSoundPath( typeCode , soundName )
	if not SICommon.ShowNamePrefix[typeCode] then
		return CodeE( SIGen , "构造器无法操作不支持的类型的原型数据 , 当前类型 = " .. typeCode )
	end
	return ( SIGen.TempConstantsData or SIInit.CurrentConstantsData ).SoundPath .. SICommon.ShowNamePrefix[typeCode] .. soundName .. ".ogg"
end

-- ----------------------------------------
-- 用于计算声音位置的函数<br>
-- 此处的声音位置不会自动添加名称后缀 , 会自动添加文件扩展名 (.png)<br>
-- 不使用 [ type ] 值进行计算<br>
-- ----------------------------------------
-- soundName             = 声音名称 , 不需要添加扩展名<br>
-- ----------------------------------------
-- 返回值                 = 计算好的声音位置<br>
-- ----------------------------------------
function SIGen.MakeRawSoundPath( soundName )
	return ( SIGen.TempConstantsData or SIInit.CurrentConstantsData ).SoundPath .. soundName .. ".ogg"
end

-- ----------------------------------------
-- 使用数据表来批量创建图标物品<br>
-- 仍然需要先通过 SIGen.SetGroup 函数设置一个可用的子分组<br>
-- 会创建图标物品 , 图标放置在地上的实体 , 以及图标放在模块区域的实体<br>
-- ----------------------------------------
-- iconItemDataList      = 图标物品的数字表 , 由键值对组成 , 键为 ID , 值为别名<br>
-- ----------------------------------------
function SIGen.AutoIconItem( iconItemDataList )
	if not SIGen.CurrentSubgroup then
		return CodeE( SIGen , "创建原型数据时 , 需要先通过 SIGen.SetGroup 函数设置一个可用的子分组" )
	end
	if not iconItemDataList then
		return SIGen
	end
	for itemID , alias in pairs( iconItemDataList ) do
		local itemPrototypeData = nil
		SIGen
		.New( SICommon.Types.Items.Item , itemID , alias ,
		{
			flags = { SICommon.Flags.Item.Hidden } ,
			stack_size = 1000 ,
			default_request_amount = 1000 ,
			fuel_category = SIConstants_Core.raw.Categories.Fuel.Special ,
			fuel_value = "1KJ" ,
			fuel_acceleration_multiplier = 0.3 ,
			fuel_top_speed_multiplier = 0.3 ,
			fuel_emissions_multiplier = 9000 ,
			fuel_glow_color = { 0.70 , 0.70 , 0.70 } ,
			burnt_result = "wood" ,
			place_result = nil ,
			placed_as_equipment_result = nil ,
			rocket_launch_products =
			{
				{
					type = SICommon.Types.Items.Item ,
					name = "small-lamp" ,
					amount_min = 0 ,
					amount_max = 3 ,
					catalyst_amount = 3
				} ,
				{
					type = SICommon.Types.Items.Item ,
					name = "coin" ,
					amount_min = 0 ,
					amount_max = 210 ,
					catalyst_amount = 210
				}
			}
		} )
		.AutoIcon()
		.AddFunction( function( prototypeName , prototypeData )
			itemPrototypeData = prototypeData
		end )
		.New( SICommon.Types.Entities.SimpleOwner , itemID , alias ,
		{
			flags = { SICommon.Flags.Entity.PlaceablePlayer , SICommon.Flags.Entity.PlayerCreation , SICommon.Flags.Entity.HideAltInfo , SICommon.Flags.Entity.Hidden } ,
			minable =
			{
				mining_time = 1.0 ,
				results =
				{
					{
						type = SICommon.Types.Items.item ,
						name = itemPrototypeData.name ,
						amount = 1
					}
				}
			} ,
			loot =
			{
				{
					item = itemPrototypeData.name ,
					count_min = 0 ,
					count_max = 1
				} ,
				{
					item = "coin" ,
					count_min = 0 ,
					count_max = 40
				}
			} ,
			max_health = 400 ,
			corpse = "small-remnants" ,
			dying_explosion = "wall-explosion" ,
			map_color = { r = 1.0 , g = 1.0 , b = 1.0 } ,
			friendly_map_color = { r = 0.2 , g = 0.2 , b = 1.0 } ,
			enemy_map_color = { r = 1.0 , g = 0.2 , b = 0.2 } ,
			alert_when_damaged = false ,
			create_ghost_on_death = false ,
			hide_resistances = true ,
			resistances = nil ,
			render_layer = SICommon.Flags.RenderLayer.FloorMechanics ,
			pictures =
			{
				{
					layers =
					{
						{
							filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , alias .. SICommon.ShowNameSuffix.ICON ) ,
							priority = "medium" ,
							width = 64 ,
							height = 64 ,
							scale = 0.5
						}
					}
				}
			} ,
			mined_sound =
			{
				SISound.Core( "deconstruct-small" , 1 )
			} ,
			vehicle_impact_sound =
			{
				SISound.Base( "car-metal-impact" , 1 )
			} ,
			repair_sound =
			{
				SISound.Core( "manual-repair-advanced-1" , 0.5 ) ,
				SISound.Core( "manual-repair-advanced-2" , 0.5 )
			} ,
			open_sound =
			{
				SISound.Base( "machine-open" , 0.5 )
			} ,
			close_sound =
			{
				SISound.Base( "machine-close" , 0.5 )
			}
		} )
		.MakeIcon( SICommon.Types.Items.Item , alias , 64 , 4 )
		.SetSize( 1 , 1 )
		.AddFunction( function( prototypeName , prototypeData )
			itemPrototypeData.place_result = prototypeData.name
		end )
		.New( SICommon.Types.Equipments.Battery , itemID , alias ,
		{
			take_result = itemPrototypeData.name ,
			categories =
			{
				SIConstants_Core.raw.Categories.Equipment.Special
			} ,
			background_color = SICommon.Colors.Equipment.Default ,
			background_border_color = SICommon.Colors.Equipment.Border ,
			grabbed_background_color = SICommon.Colors.Equipment.DefaultHover ,
			shape =
			{
				type = SICommon.Flags.EquipmentShapeType.Full ,
				width = 1 ,
				height = 1
			} ,
			energy_source =
			{
				type = SICommon.Flags.EnergySourceType.Electric ,
				emissions_per_minute = 0 ,
				render_no_power_icon = false ,
				render_no_network_icon = false ,
				usage_priority = SICommon.Flags.ElectricUsagePriority.Tertiary ,
				buffer_capacity = "0J" ,
				input_flow_limit = "0W" ,
				output_flow_limit = "0W" ,
				drain = "0J"
			} ,
			sprite =
			{
				filename = SIGen.MakePicturePath( SICommon.Types.Items.Item , alias .. SICommon.ShowNameSuffix.ICON ) ,
				priority = "medium" ,
				width = 64 ,
				height = 64 ,
				scale = 0.5
			}
		} )
		.MakeIcon( SICommon.Types.Items.Item , alias , 64 , 4 )
		.AddFunction( function( prototypeName , prototypeData )
			itemPrototypeData.placed_as_equipment_result = prototypeData.name
		end )
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建控件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 使用 SIGen 创建一个新的字体数据<br>
-- SIGen 会自动将新的字体数据进行注册 , 并自动生成一些属性<br>
-- ----------------------------------------
-- fontID                = ID , 用于计算 [ name ] 值和在 ConstantsData.raw.Fonts 中注册<br>
-- aliasName             = 别名 , 和 ConstantsData.Autoload 中的别名一样 , 在计算 [ name ] 值时代替 ID 进行计算 , 不影响 ConstantsData.raw.Fonts 中的注册<br>
-- fontSize              = 字体的字号<br>
-- hasBorder             = 是否拥有边框<br>
-- borderColor           = 如果有边框的话 , 这里定义它的颜色 , 默认是 000 纯黑<br>
-- from                  = 使用的字体<br>
-- ----------------------------------------
function SIGen.AddFont( fontID , aliasName , fontSize , hasBorder , borderColor , from )
	if not fontID then
		return CodeE( SIGen , "创建原型数据时 , ID 不能为空" )
	end
	if hasFinish then
		return CodeE( SIGen , "流程已经结束 , 无法使用 SIGen.AddFont 函数" )
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local realName = constantsData.ShowNamePrefix .. SICommon.ShowNamePrefix[SICommon.Types.Font] .. ( aliasName or fontID ):gsub( "_" , "-" )
	local fontData =
	{
		type = SICommon.Types.Font ,
		name = realName ,
		size = fontSize or 14 ,
		border = hasBorder or false ,
		border_color = hasBorder and ( borderColor or {} ) or nil ,
		from = from or "default"
	}
	if raw[SICommon.Types.Font] then
		raw[SICommon.Types.Font][realName] = fontData
	else
		raw[SICommon.Types.Font] = { [realName] = fontData }
	end
	local rawCode = SICommon.Types.Raw[SICommon.Types.Font]
	if constantsData.raw[rawCode] then
		constantsData.raw[rawCode][fontID] = realName
	else
		constantsData.raw[rawCode] = { [fontID] = realName }
	end
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 创建一个新的控件样式 , 并使用 styleDataToCopy 来作为数据的基础<br>
-- 不设置 styleDataToCopy 则是一个空的控件样式<br>
-- SIGen 会自动将新的控件样式进行注册 , 并自动生成一些属性<br>
-- 新的控件样式会自动使用新的贴图 , 如果不想使用新样式 , 则需要添加 oldGUI = true 属性<br>
-- ----------------------------------------
-- styleID               = ID , 用于计算 [ name ] 值和在 ConstantsData.raw.Styles 中注册<br>
-- aliasName             = 别名 , 和 ConstantsData.Autoload 中的别名一样 , 在计算 [ name ] 值时代替 ID 进行计算 , 不影响 ConstantsData.raw.Styles 中的注册<br>
-- styleDataToCopy       = 用来复制数据的控件样式<br>
-- ----------------------------------------
function SIGen.AddStyle( styleID , aliasName , styleDataToCopy )
	if not styleID then
		return CodeE( SIGen , "创建控件样式时 , ID 不能为空" )
	end
	if hasFinish then
		return CodeE( SIGen , "流程已经结束 , 无法使用 SIGen.AddStyle 函数" )
	end
	local constantsData = SIGen.TempConstantsData or SIInit.CurrentConstantsData
	local realName = constantsData.ShowNamePrefix .. ( aliasName or styleID ):gsub( "_" , "-" )
	if style[realName] then
		return CodeE( SIGen , "同名控件样式已存在 , styleName = " .. realName )
	end
	if constantsData.raw.Styles then
		if constantsData.raw.Styles[styleID] then
			return CodeE( SIGen , "同 ID 控件样式已存在 , styleID = " .. styleID )
		end
		constantsData.raw.Styles[styleID] = realName
	else
		constantsData.raw.Styles = { [styleID] = realName }
	end
	local styleData = styleDataToCopy and SIUtils.table.deepcopy( styleDataToCopy ) or {}
	SIGen.CurrentStyleData = styleData
	style[realName] = styleData
	return SIGen
end

-- ----------------------------------------
-- 使用 SIGen 完善最新创建的控件样式<br>
-- 向此控件样式中添加另一个控件的样式 , 普通表也可以<br>
-- 添加的数据会被直接复制 , 被复制的控件样式中的表或数组发了的修改的话 , 此控件样式的相应表或数组也会发生修改<br>
-- ----------------------------------------
-- styleDataToCopy       = 被复制的控件样式<br>
-- ----------------------------------------
function SIGen.AppendStyleData( styleDataToCopy )
	if not SIGen.CurrentStyleData then
		return CodeE( SIGen , "需要先创建新的控件样式 , 之后才可以完善它" )
	end
	for key , value in pairs( styleDataToCopy ) do
		SIGen.CurrentStyleData[key] = value
	end
	return SIGen
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 流程控制 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- 重置 SIGen 的动态数据<br>
-- ----------------------------------------
function SIGen.Fresh()
	SIGen.CurrentPrototypeData = nil
	SIGen.CurrentStyleData = nil
	SIGen.CurrentGroup = nil
	SIGen.CurrentSubgroup = nil
	SIGen.TempConstantsData = nil
	return SIGen
end

-- ----------------------------------------
-- 重置 SIGen 的动态数据并结束使用<br>
-- 请勿在外部使用此函数<br>
-- ----------------------------------------
function SIGen.Finish()
	if hasFinish then
		return CodeE( SIGen , "流程已经结束 , 无法使用 SIGen.Finish 函数" )
	end
	SIGen.Fresh()
	hasFinish = true
	-- 转存原型数据
	local prototypes = {}
	for typeCode , prototypeList in pairs( raw ) do
		for prototypeName , prototypeData in pairs( prototypeList ) do
			if prototypeData then
				local callbackList = SIGen.TypeCallback[typeCode]
				if callbackList then
					for callBackIndex , callback in pairs( callbackList ) do
						callback( prototypeName , prototypeData , callBackIndex )
					end
				end
				if prototypeData.SIGenData then
					callbackList = prototypeData.SIGenData.Callbacks
					if callbackList then
						for callBackIndex , callback in pairs( callbackList ) do
							callback( prototypeName , prototypeData , callBackIndex )
						end
					end
				end
				prototypeData.SIGenData = nil
				table.insert( prototypes , prototypeData )
			end
		end
	end
	if #prototypes > 0 then
		data:extend( prototypes )
	end
	-- 更新控件样式
	local styleList = data.raw[SICommon.Types.Style]["default"]
	for styleRealName , styleData in pairs( style ) do
		if not styleData.oldGUI then
			for key , value in pairs( styleData ) do
				if key:EndsWith( "graphical_set" ) then
					local noSub = true
					if value.base then
						if not value.base.filename then
							value.base.filename = SIGen.StylePath
						end
						noSub = false
					end
					if value.shadow then
						if not value.shadow.filename then
							value.shadow.filename = SIGen.StylePath
						end
						noSub = false
					end
					if value.glow then
						if not value.glow.filename then
							value.glow.filename = SIGen.StylePath
						end
						noSub = false
					end
					if noSub and not value.filename then
						value.filename = SIGen.StylePath
					end
				end
			end
		end
		if not styleData.type then
			return CodeE( SIGen , "控件样式的 type 不能为空 , 样式名称 = " .. styleRealName )
		end
		styleList[styleRealName] = styleData
	end
	return SIGen
end