ds_list_delete(o_RenderManager.terrain, ds_list_find_index(o_RenderManager.terrain, self))

bfDestroy(buffer)

for(var i = 0; i < array_length_1d(objects); i++)
{
    instance_destroy(objects[i])
}