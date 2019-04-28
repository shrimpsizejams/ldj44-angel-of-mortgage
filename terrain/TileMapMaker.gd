extends Node

var tile_size = Vector2(16, 16)
onready var texture = $Sprite.texture

func _ready():
    grab_terrain_tiles()

func grab_terrain_tiles():
    var tex_width = texture.get_width() /  tile_size.x
    var tex_height = texture.get_height() / tile_size.y
    var ts = TileSet.new()
    for x in range(23):
        for y in range(6):
            var region = Rect2(x * tile_size.x, y * tile_size.y,
                               tile_size.x, tile_size.y)
            var id = x * 10 + y
            ts.create_tile(id)
            ts.tile_set_texture(id, texture)
            ts.tile_set_region(id, region)

    for x in range(8, 23):
        for y in [6, 7]:
            var region = Rect2(x * tile_size.x, y * tile_size.y,
                               tile_size.x, tile_size.y)
            var id = x * 10 + y
            ts.create_tile(id)
            ts.tile_set_texture(id, texture)
            ts.tile_set_region(id, region)
    for x in range(8, 16):
        var y = 8
        var region = Rect2(x * tile_size.x, y * tile_size.y,
                           tile_size.x, tile_size.y)
        var id = x * 10 + y
        ts.create_tile(id)
        ts.tile_set_texture(id, texture)
        ts.tile_set_region(id, region)

    ResourceSaver.save("res://terrain/terrain_tiles.tres", ts)