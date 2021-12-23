return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 16,
  tilewidth = 12,
  tileheight = 12,
  nextlayerid = 4,
  nextobjectid = 25,
  properties = {},
  tilesets = {
    {
      name = "Tileset",
      firstgid = 1,
      tilewidth = 12,
      tileheight = 12,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "../assets/Tileset.png",
      imagewidth = 48,
      imageheight = 48,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 12,
        height = 12
      },
      properties = {},
      wangsets = {},
      tilecount = 16,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 24,
      height = 16,
      id = 1,
      name = "Camada de Tiles 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 0, 0, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1,
        6, 3, 2, 0, 8, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 8, 0, 0, 0, 2, 4, 7,
        6, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 7,
        6, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 7,
        6, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 7,
        6, 9, 10, 9, 9, 9, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 9, 9, 9, 10, 9, 7,
        6, 0, 2, 0, 0, 0, 0, 2, 0, 0, 8, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 7,
        6, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 11, 2, 0, 7,
        6, 1, 5, 5, 5, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 5, 5, 5, 1, 7,
        6, 3, 0, 8, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 4, 7,
        6, 0, 0, 0, 2, 0, 0, 2, 11, 11, 0, 0, 0, 0, 0, 11, 2, 0, 0, 2, 0, 0, 0, 7,
        6, 9, 9, 9, 10, 9, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 9, 10, 9, 9, 9, 7,
        6, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 8, 0, 0, 2, 0, 0, 0, 7,
        6, 11, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 7,
        6, 1, 5, 5, 5, 1, 11, 0, 11, 2, 0, 0, 0, 0, 2, 11, 0, 0, 1, 5, 5, 5, 1, 7,
        1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 0, 0, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Camada de Objetos 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 132,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 12,
          width = 12,
          height = 180,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 168,
          width = 72,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 12,
          y = 180,
          width = 120,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 156,
          y = 180,
          width = 132,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 216,
          y = 168,
          width = 72,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 276,
          y = 0,
          width = 12,
          height = 180,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 156,
          y = 0,
          width = 132,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 60,
          width = 144,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 216,
          y = 96,
          width = 60,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 132,
          width = 144,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 72,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "spawnable",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 12,
          y = 84,
          width = 60,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 48,
          width = 144,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 216,
          y = 84,
          width = 60,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 120,
          width = 144,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 216,
          y = 156,
          width = 60,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 156,
          y = 168,
          width = 60,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 72,
          y = 168,
          width = 60,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 12,
          y = 156,
          width = 60,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnable"] = true
          }
        }
      }
    }
  }
}
