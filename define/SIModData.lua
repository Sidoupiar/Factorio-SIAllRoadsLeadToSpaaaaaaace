SIModData =
{
	List =
	{
		base = "基础游戏"
	} ,
	Loaded = {} ,
	Data = {}
}

local modList = nil
if mods then
	modList = mods
elseif script and script.active_mods then
	modList = script.active_mods
end

if modList then
	for name , displayName in pairs( SIModData.List ) do
		local version = modList[name]
		local loaded = version ~= nil
		SIModData.Loaded[name] = loaded
		SIModData.Data[name] =
		{
			ID = name ,
			Name = displayName ,
			LocalisedName = { "mod-name." .. name } ,
			LocalisedDescription = { "mod-description." .. name } ,
			Loaded = loaded ,
			Version = version
		}
	end
end