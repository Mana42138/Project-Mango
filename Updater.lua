-- pcall(function()

files.create_folder('nl\\Mango')

local correctCode = {
    [1] = network.get('https://raw.githubusercontent.com/Mana42138/Project-Mango/main/Mango.lua'),
}

files.write('nl\\scripts\\JYAW.lua', correctCode[1])
local Test = require('scripts\\JYAW')

local Main_Mango_Table = Test:dev(files, color, common, cvar, entity, esp, events, globals, json, materials, math, ui, network, panorama, rage, render, utils, vector, {
    gradient = require("neverlose/gradient"),
    drag_system = require("neverlose/drag_system"),
    MTools = require("neverlose/mtools"),
    vmt_hook = require("neverlose/vmt_hook"),
    pui = require("neverlose/pui"),
    ffi = require("ffi"),
    csgo_weapons = require("neverlose/csgo_weapons"),
    clipboard = require("neverlose/clipboard"),
})

events.render:set(function(cmd)
    for i,v in pairs(Main_Mango_Table.Render_Main) do
        v(cmd)
    end
end)

events.createmove:set(function(cmd)
    for i,v in pairs(Main_Mango_Table.Create_Move_Main) do
        v(cmd)
    end
end)

events.aim_ack:set(function(cmd)
    for i,v in pairs(Main_Mango_Table.aim_ack_Main) do
        v(cmd)
    end
end)

Main_Mango_Table:once_callback()

-- end)

