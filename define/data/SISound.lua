SISound =
{
	-- 固定属性
	ID = "SISound" ,
	Name = "声音管理"
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 原版声音 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SISound.Core( filename , volume , minSpeed , maxSpeed )
	return
	{
		filename = "__core__/sound/" .. filename .. ".ogg" ,
		volume = volume ,
		min_speed = minSpeed ,
		max_speed = maxSpeed
	}
end

function SISound.Base( filename , volume , minSpeed , maxSpeed )
	if SIModData.Loaded.base then
		return
		{
			filename = "__base__/sound/" .. filename .. ".ogg" ,
			volume = volume ,
			min_speed = minSpeed ,
			max_speed = maxSpeed
		}
	else
		return nil
	end
end