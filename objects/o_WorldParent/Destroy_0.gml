if(hp <= 0)
{
	if(damagable == true)
	{
		if(type == parent_type.harvestable)
		{
			switch(object_index)
			{
				case(o_Rock1):
					repeat(irandom_range(2, 5))
					{
						create_drop(x, y, items.stone, 1)
					}
				break;
				
				case(o_Tree1):
					repeat(irandom_range(3, 7))
					{
						create_drop(x, y, items.wood, 1)
					}
				break;
			}
		}
	}
}

o_RenderManager.remove(self)
o_Game.world_remove(self)