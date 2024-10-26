SIColorfulRecipe =
{
	{
		ID = "SI多彩-多彩调色盘" ,
		Name = { "SIColorful.解锁-多彩调色盘" } ,
		Description = { "SIColorful.解锁-多彩调色盘-说明" } ,
		Triggers =
		{
			Build =
			{
				[SIConstants_Colorful.raw.Entities.Pixel_256_256_256] =
				{
					Max = 200
				}
			}
		} ,
		Results =
		{
			{
				Type = SIUnlocker.ResultTypeID.AddRecipe ,
				Recipes =
				{
					SIConstants_Colorful.raw.Recipes.ColorPanel
				}
			} ,
			{
				Type = SIUnlocker.ResultTypeID.MessageForce ,
				Message = SIUnlocker.DefaultMessage_AddRecipe ,
				ShowTimeAndPlayer = true
			}
		}
	}
}