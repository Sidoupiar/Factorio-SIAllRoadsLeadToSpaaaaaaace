-- ------------------------------------------------------------------------------------------------
-- ------------ 说明 ------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ----------------------------------------
-- [常用函数]
-- 其中包含了一些常用的函数
-- 不同于 define 中的函数 , 这些函数均或多或少的使用了 SICore 中携带的数据
-- ----------------------------------------
-- [作用]
-- 其中包含了一些常用的函数
-- ----------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIFunctions =
{
	ID = "SIFunctions" ,
	Name = "常用函数"
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 悬浮文字 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIFunctions.FlyingText( text , entity , height )
	entity.surface.create_entity
	{
		name = SIConstants_Core and SIConstants_Core.raw.Entities.FlyingText or "tutorial-flying-text" ,
		text = text ,
		position = { x = entity.position.x , y = entity.position.y - height } ,
		color = { r = 1 , g = 1 , b = 1 , a = 1 }
	}
end

function SIFunctions.FlyingTextPlayer( text , player , height , createAtCursor )
	player.create_local_flying_text
	{
		text = text ,
		position = { x = player.position.x , y = player.position.y - height } ,
		create_at_cursor = createAtCursor or false ,
		color = { r = 1 , g = 1 , b = 1 , a = 1 } ,
		time_to_live = 150 ,
		speed = 0.03
	}
end

function SIFunctions.FlyingTextForce( text , entity , height , force )
	local textEntity = entity.surface.create_entity
	{
		name = SIConstants_Core and SIConstants_Core.raw.Entities.FlyingText or "tutorial-flying-text" ,
		text = text ,
		position = { x = entity.position.x , y = entity.position.y - height } ,
		color = { r = 1 , g = 1 , b = 1 , a = 1 }
	}
	textEntity.render_to_forces = { force }
end

function SIFunctions.FlyingTextForceList( text , entity , height , forceList )
	local textEntity = entity.surface.create_entity
	{
		name = SIConstants_Core and SIConstants_Core.raw.Entities.FlyingText or "tutorial-flying-text" ,
		text = text ,
		position = { x = entity.position.x , y = entity.position.y - height } ,
		color = { r = 1 , g = 1 , b = 1 , a = 1 }
	}
	textEntity.render_to_forces = forceList
end