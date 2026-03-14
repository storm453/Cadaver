if(inited) 
{
	o_RenderManager.terrain_remove(self)

	bfDestroy(buffer)

	for(var i = 0; i < array_length_1d(objects); i++)
	{
	    instance_destroy(objects[i])
	}
}