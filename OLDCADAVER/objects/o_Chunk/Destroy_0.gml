ds_list_delete(o_RenderManager.entities, ds_list_find_index(o_RenderManager.entities, self))

for(var i = 0; i < ds_list_size(objects); i++)
{
	instance_destroy(objects[|i])
}