event_inherited()

depth = 0

type = parent_type.interactable
block_data = create_interactable("Bag", gui.CONTAINER)

loot = create_inventory(4, 2)

loot_x = 0
loot_y = 0

add_item(loot, items.sword, 3)
add_item(loot, items.wood, 8)