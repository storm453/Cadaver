if(type == parent_type.harvestable)
{
	instance_create_layer(x, y, "World", o_ItemDropped)	
}

o_RenderManager.remove(self)
o_Game.world_remove(self)