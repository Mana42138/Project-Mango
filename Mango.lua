
files.create_folder('nl\\Mango')

files.create_folder('nl\\Mango')
files.create_folder('nl\\Mango\\modules')
files.create_folder('nl\\Mango\\configs')

local Main_Folder = 'nl\\Mango\\'
local Configs_Path = Main_Folder..'configs'

-- // Files \\ --
files.write('nl\\Mango\\modules\\easing.lua', network.get("https://raw.githubusercontent.com/Mana42138/Project-Mango/main/easing.lua"))
files.write('nl\\Mango\\modules\\base64AD.lua', network.get("https://raw.githubusercontent.com/Mana42138/Project-Mango/main/Base%2064%20Advanced.lua"))
if not files.read('nl\\Mango\\configs.json') then
    files.write('nl\\Mango\\configs.json', json.stringify({}))
end

local weapons = {"Global","SSG-08","Pistols","AutoSnipers","Snipers","Rifles","SMGs","Shotguns","Machineguns","AWP","AK-47","M4A1/M4A4","Desert Eagle","R8 Revolver","AUG/SG 553","Taser"}

local Config_Data = 'nl\\Mango\\configs.json'

local easing = require 'Mango/modules/easing'
local Base64 = require 'Mango/modules/base64AD'


local ffi = require("ffi")

local clipboard = require('neverlose/clipboard')
local csgo_weapons = require('neverlose/csgo_weapons')
local MTools = require("neverlose/mtools")

-- common.add_notify('Mango', "Hello world!")

ffi.cdef[[
    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK);
    int GetAsyncKeyState(int vKey);
]]

local Keys = {LBUTTON = 0x01,RBUTTON = 0x02,CANCEL = 0x03,MBUTTON = 0x04,XBUTTON1 = 0x05,XBUTTON2 = 0x06,BACK = 0x08,TAB = 0x09,CLEAR = 0x0C,RETURN = 0x0D,SHIFT = 0x10,CONTROL = 0x11,MENU = 0x12,PAUSE = 0x13,CAPITAL = 0x14,ESCAPE = 0x1B,SPACE = 0x20,PRIOR = 0x21,NEXT = 0x22,END = 0x23,HOME = 0x24,LEFT = 0x25,UP = 0x26,RIGHT = 0x27,DOWN = 0x28,SELECT = 0x29,PRINT = 0x2A,EXECUTE = 0x2B,SNAPSHOT = 0x2C,INSERT = 0x2D,DELETE = 0x2E,HELP = 0x2F,["0"] = 0x30,["1"] = 0x31,["2"] = 0x32,["3"] = 0x33,["4"] = 0x34,["5"] = 0x35,["6"] = 0x36,["7"] = 0x37,["8"] = 0x38,["9"] = 0x39,A = 0x41,B = 0x42,C = 0x43,D = 0x44,E = 0x45,F = 0x46,G = 0x47,H = 0x48,I = 0x49,J = 0x4A,K = 0x4B,L = 0x4C,M = 0x4D,N = 0x4E,O = 0x4F,P = 0x50,Q = 0x51,R = 0x52,S = 0x53,T = 0x54,U = 0x55,V = 0x56,W = 0x57,X = 0x58,Y = 0x59,Z = 0x5A,LWIN = 0x5B,RWIN = 0x5C,APPS = 0x5D,SLEEP = 0x5F,NUMPAD0 = 0x60,NUMPAD1 = 0x61,NUMPAD2 = 0x62,NUMPAD3 = 0x63,NUMPAD4 = 0x64,NUMPAD5 = 0x65,NUMPAD6 = 0x66,NUMPAD7 = 0x67,NUMPAD8 = 0x68,NUMPAD9 = 0x69,MULTIPLY = 0x6A,ADD = 0x6B,SEPARATOR = 0x6C,SUBTRACT = 0x6D,DECIMAL = 0x6E,DIVIDE = 0x6F,F1 = 0x70,F2 = 0x71,F3 = 0x72,F4 = 0x73,F5 = 0x74,F6 = 0x75,F7 = 0x76,F8 = 0x77,F9 = 0x78,F10 = 0x79,F11 = 0x7A,F12 = 0x7B,F13 = 0x7C,F14 = 0x7D,F15 = 0x7E,F16 = 0x7F,F17 = 0x80,F18 = 0x81,F19 = 0x82,F20 = 0x83,F21 = 0x84,F22 = 0x85,F23 = 0x86,F24 = 0x87,NUMLOCK = 0x90,SCROLL = 0x91,LSHIFT = 0xA0,RSHIFT = 0xA1,LCONTROL = 0xA2,RCONTROL = 0xA3,LMENU = 0xA4,RMENU = 0xA5,BROWSER_BACK = 0xA6,BROWSER_FORWARD = 0xA7,BROWSER_REFRESH = 0xA8,BROWSER_STOP = 0xA9,BROWSER_SEARCH = 0xAA,BROWSER_FAVORITES = 0xAB,BROWSER_HOME = 0xAC,VOLUME_MUTE = 0xAD,VOLUME_DOWN = 0xAE,VOLUME_UP = 0xAF,MEDIA_NEXT_TRACK = 0xB0,MEDIA_PREV_TRACK = 0xB1,MEDIA_STOP = 0xB2,MEDIA_PLAY_PAUSE = 0xB3,LAUNCH_MAIL = 0xB4,LAUNCH_MEDIA_SELECT = 0xB5,LAUNCH_APP1 = 0xB6,LAUNCH_APP2 = 0xB7,OEM_1 = 0xBA,OEM_PLUS = 0xBB,OEM_COMMA = 0xBC,OEM_MINUS = 0xBD,OEM_PERIOD = 0xBE,OEM_2 = 0xBF,OEM_3 = 0xC0,OEM_4 = 0xDB,OEM_5 = 0xDC,OEM_6 = 0xDD,OEM_7 = 0xDE,OEM_8 = 0xDF,OEM_102 = 0xE2,PROCESSKEY = 0xE5,PACKET = 0xE7,ATTN = 0xF6,CRSEL = 0xF7,EXSEL = 0xF8,EREOF = 0xF9,PLAY = 0xFA,ZOOM = 0xFB,NONAME = 0xFC,PA1 = 0xFD,OEM_CLEAR = 0xFE}


local Setup_welcome = ui.create("🏠 Home", "Misc")
local cfgsys = ui.create("🏠 Home", "Config System")

local Main = ui.create("🔰 Anti-Aim", "Main")

local Misc = ui.create("⚙️ Misc", "Misc")

local Main = {
    script_db = {
        username = tostring(common.get_username()),
        lua_name = 'Mango.lua',
        lua_version = 'v1'
    },
    visuals = {},
    Items = {},
    Main_Anti_Defensive = {
        main = {
            fs = ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"),
            hidden = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Hidden"),
            lag_options = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options"),
        }
    },
    Tabs = {
        Builder = ui.create("🔰 Anti-Aim", "Builder"),
        AntiAim = ui.create("🔰 Anti-Aim", "Anti-Aim"),
        Ragebot = ui.create("🔰 Anti-Aim", "💀 Ragebot"),
        Misc = ui.create("⚙️ Misc", "⚙️ Misc"),
        Scope = ui.create("⚙️ Misc", "⊹ Scope"),
        KillSay = ui.create("⚙️ Misc", "Killsay"),
    },
    Access = {},
    helpers = {
        lerp = function(a, b, percentage) return a + (b - a) * percentage end,
        screen_size = render.screen_size()
    }
}


local Flags = {}

local function wait(options)
    local time, flag, Number, callback = options.time, options.flag, options.Number, options.callback
    if Flags[flag] == nil then
        Flags[flag] = {active = false, wait_time = 0}
    end

    if Flags[flag].active then
        Flags[flag].wait_time = Flags[flag].wait_time + Number or 0.01
        if Flags[flag].wait_time >= time then
            callback()

            Flags[flag].active = false
            Flags[flag].wait_time = 0
        end
    else
        Flags[flag].active = true
    end
end


function AAWait(time, callback1, callback2)
    if not Global_Time and not Global_Time_Has_Switched then
        Global_Time = 0
        Global_Time_Has_Switched = false
    end

    Global_Time = Global_Time + 0.1
        if Global_Time >= time then
                if Global_Time_Has_Switched == false then
                    callback1()
                else
                    callback2()
                end
            Global_Time_Has_Switched = not Global_Time_Has_Switched
            Global_Time = 0
        end
end

Main.helpers.isKeyPressed = function(keyName)
    local vKey = Keys[string.upper(keyName)]
    if vKey then
        return ffi.C.GetAsyncKeyState(vKey) ~= 0
    else
        return false
    end
end

Main.helpers.RGBToColorString = function(str, color)
    R = math.max(0, math.min(255, color.r))
    G = math.max(0, math.min(255, color.g))
    B = math.max(0, math.min(255, color.b))
    A = math.max(0, math.min(255, color.a))

    local RHex = string.format("%01X", R)
    local GHex = string.format("%01X", G)
    local BHex = string.format("%01X", B)
    local AHex = string.format("%01X", A)

    local colorCode = "\a" .. RHex .. GHex .. BHex .. AHex .. " ".. str .. " \aFFFFFFFF"

    return colorCode
end 

local weapons_ = {
    -- Rifles
    ["AK-47"] = "Rifles",
    ["AUG"] = "Rifles",
    ["FAMAS"] = "Rifles",
    ["Galil AR"] = "Rifles",
    ["M4A4"] = "Rifles",
    ["M4A1-S"] = "Rifles",
    ["SCAR-20"] = "Rifles",
    ["SG 553"] = "Rifles",
    
    -- SMGs
    ["MAC-10"] = "SMGs",
    ["MP5-SD"] = "SMGs",
    ["MP7"] = "SMGs",
    ["MP9"] = "SMGs",
    ["UMP-45"] = "SMGs",
    ["PP-Bizon"] = "SMGs",
    
    -- Shotguns
    ["Nova"] = "Shotguns",
    ["XM1014"] = "Shotguns",
    ["Sawed-Off"] = "Shotguns",
    ["MAG-7"] = "Shotguns",
    
    -- Sniper Rifles
    ["AWP"] = "AWP",
    ["G3SG1"] = "AutoSnipers",
    ["SCAR-20"] = "AutoSnipers",
    ["SSG 08"] = "SSG-08",

    -- Pistols
    ["Desert Eagle"] = "Desert Eagle" or "Pistols",
    ["Dual Berettas"] = "Pistols",
    ["Five-SeveN"] = "Pistols",
    ["Glock-18"] = "Pistols",
    ["P2000"] = "Pistols",
    ["P250"] = "Pistols",
    ["TEC-9"] = "Pistols",
    ["USP-S"] = "Pistols",
    ["CZ75-Auto"] = "Pistols",
    ["R8 Revolver"] = "R8 Revolver" or "Pistols",
    
    -- Machine Guns
    ["M249"] = "Machineguns",
    ["Negev"] = "Machineguns",
    
    -- Grenades
    ["Flashbang"] = "Grenades",
    ["HE Grenade"] = "Grenades",
    ["Smoke Grenade"] = "Grenades",
    ["Molotov"] = "Grenades",
    ["Incendiary Grenade"] = "Grenades",
    ["Decoy Grenade"] = "Grenades",
    
    -- Others
    ["C4"] = "Others",
    ["Zeus x27"] = "Taser",  -- Taser
    ["Knife"] = "Others",
    
    -- Special Cases (Event/Custom Weapons)
    ["Snowball"] = "Special Cases",
    ["Bump Mine"] = "Special Cases",
    ["Healthshot"] = "Special Cases",
    ["Tactical Awareness Grenade"] = "Special Cases",
    ["Firebomb"] = "Special Cases",
    ["Diversion Device"] = "Special Cases",
    ["Breach Charge"] = "Special Cases",
    ["Tablet"] = "Special Cases",
    ["knife"] = "Special Cases",  -- Fists, Axe, Hammer, Spanner, Knife GG
}

Main.helpers.GetWeapon = function()
    local lp = entity.get_local_player()
    local weapon = lp:get_player_weapon()
    if weapon == nil then return end
    local WeaponName = csgo_weapons(weapon).name

    WeaponName = string.gsub(WeaponName, "^%s*(.-)%s*$", "%1")

    local baseName = string.match(WeaponName, "^[^-]+")
    if baseName == nil then
        baseName = WeaponName
    end

    local category = "Unknown"

    for i, v in pairs(weapons_) do
        local keyName = string.match(i, "^[^-]+") or i
        
        if string.match(string.upper(baseName), string.upper(keyName)) then
            category = v
            break
        end
    end 

    return category
end

Main.helpers.GetAllWeapon = function()
    local weapon = nil
    for i,v in pairs(weapons) do
        weapon = v
    end
    return weapon
end

local function Access_add(name, path, value)
    Main.Items[name.."_"..path] = value
    return value
end

Main.Items.Build_AA = Main.Tabs.Builder:switch("Build Anti-Aim")

local Builder_Table = {[1]='Global', [2]='Standing', [3]='Walking', [4]='Running', [5]='Crouching', [6]='In Air', [7]="In Air + Crouching", [8]='Fake Lag'}

local Chose_Options = Access_add("ChAA", "AA_options", Main.Tabs.Builder:list("", Builder_Table))

local Builder_Section = Main.Tabs.AntiAim

local function TurnTalbe(input)
    return Builder_Table[input]
end

local function Visisbility_AntiAim(state)
    Main.Items.Global_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "Global" and state)
    Main.Items.Standing_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "Standing" and state)
    Main.Items.Walking_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "Walking" and state)
    Main.Items.Running_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "Running" and state)
    Main.Items.Crouching_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "Crouching" and state)
    Main.Items.In_Air_AC_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "In Air + Crouching" and state)
    Main.Items.In_Air_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "In Air" and state)
    Main.Items.Fake_Lag_AA_Enable:visibility(TurnTalbe(Chose_Options:get()) == "Fake Lag" and state)

    for i,v in pairs(Main.Items) do
        if string.find(i, "Global_AA") and i ~= "Global_AA_Enable" then
            v:visibility(Main.Items.Global_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "Global" and state)
        elseif string.find(i, "Standing_AA") and i ~= "Standing_AA_Enable" then
            v:visibility(Main.Items.Standing_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "Standing" and state)
        elseif string.find(i, "Walking_AA") and i ~= "Walking_AA_Enable" then
            v:visibility(Main.Items.Walking_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "Walking" and state)
        elseif string.find(i, "Running_AA") and i ~= "Running_AA_Enable" then
            v:visibility(Main.Items.Running_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "Running" and state)
        elseif string.find(i, "Crouching_AA") and i ~= "Crouching_AA_Enable" then
            v:visibility(Main.Items.Crouching_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "Crouching" and state)
        elseif string.find(i, "AC_AA") and i ~= "In_Air_AC_AA_Enable" then
            v:visibility(Main.Items.In_Air_AC_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "In Air + Crouching" and state)
        elseif string.find(i, "In_Air_AA") and i ~= "In_Air_AA_Enable" then
            v:visibility(Main.Items.In_Air_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "In Air" and state)
        elseif string.find(i, "Fake_Lag_AA_") and i ~= "Fake_Lag_AA_Enable" then
            v:visibility(Main.Items.Fake_Lag_AA_Enable:get() and TurnTalbe(Chose_Options:get()) == "Fake Lag" and state)
        end
    end
end

local function extasy_global(state)
    for i,v in pairs(Main.Items) do
        if string.find(i, "Global_AA_") and i ~= "Global_AA_Enable" then
            v:visibility(Main.Items.Global_AA_Enable:get() and state == "Global" and Main.Items.Build_AA:get())
        elseif string.find(i, "Global_AA_") and state ~= "Global" then
            v:visibility(false)
            
        elseif string.find(i, "Standing_AA_") and i ~= "Standing_AA_Enable" then
            v:visibility(Main.Items.Standing_AA_Enable:get() and state == "Standing" and Main.Items.Build_AA:get())
        elseif string.find(i, "Standing_AA_") and state ~= "Standing" then
            v:visibility(false)

        elseif string.find(i, "Walking_AA_") and i ~= "Walking_AA_Enable" then
            v:visibility(Main.Items.Walking_AA_Enable:get() and state == "Walking" and Main.Items.Build_AA:get())
        elseif string.find(i, "Walking_AA_") and state ~= "Walking" then
            v:visibility(false)

        elseif string.find(i, "Running_AA_") and i ~= "Running_AA_Enable" then
            v:visibility(Main.Items.Running_AA_Enable:get() and state == "Running" and Main.Items.Build_AA:get())
        elseif string.find(i, "Running_AA_") and state ~= "Running" then
            v:visibility(false)
        
        elseif string.find(i, "Crouching_AA_") and i ~= "Crouching_AA_Enable" then
            v:visibility(Main.Items.Crouching_AA_Enable:get() and state == "Crouching" and Main.Items.Build_AA:get())
        elseif string.find(i, "Crouching_AA_") and state ~= "Crouching" then
            v:visibility(false)
        
        elseif string.find(i, "In_Air_AA_") and i ~= "In_Air_AA_Enable" then
            v:visibility(Main.Items.In_Air_AA_Enable:get() and state == "In Air" and Main.Items.Build_AA:get())
        elseif string.find(i, "In_Air_AA_") and state ~= "In Air" then
            v:visibility(false)

    elseif string.find(i, "AC_AA_") and i ~= "In_Air_AC_AA_Enable" then
        v:visibility(Main.Items.In_Air_AC_AA_Enable:get() and state == "In Air + Crouching" and Main.Items.Build_AA:get())
    elseif string.find(i, "AC_AA_") and state ~= "In Air + Crouching" then
        v:visibility(false)
        
        elseif string.find(i, "Fake_Lag_AA_") and i ~= "Fake_Lag_AA_Enable" then
            v:visibility(Main.Items.Fake_Lag_AA_Enable:get() and state == "Fake Lag" and Main.Items.Build_AA:get())
        elseif string.find(i, "Fake_Lag_AA_") and state ~= "Fake Lag" then
            v:visibility(false)
        
        end
    end
end

local Yaw_modifier_List = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):list()

Main.Items.Global_AA_Enable = Builder_Section:switch("Global Enable")

Main.Items.Global_AA_pitch_settings = Builder_Section:combo("G ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items.Global_AA_yaw_settings = Builder_Section:combo("G ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)
Main.Items.Global_AA_SpinSpeed = Main.Items.Global_AA_yaw_settings:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items.Global_AA_Randomize_SpinSpeed = Main.Items.Global_AA_yaw_settings:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items.Global_AA_Yaw_Add_Type = Builder_Section:combo("G ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items.Global_AA_Yaw_Modifier = Builder_Section:combo("G ~ Yaw Modifier", Yaw_modifier_List)

Main.Items.Global_AA_Left_Limit = Builder_Section:slider("G ~ Left Limit", 0, 60, 0, 1)
Main.Items.Global_AA_Right_Limit = Builder_Section:slider("G ~ Right Limit", 0, 60, 0, 1)
Main.Items.Global_AA_Options = Builder_Section:selectable("G ~ Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list())
Main.Items.Global_AA_Extended_Angels = Builder_Section:switch("G ~ Extended Angels", false)

Main.Items.Global_AA_Y_Add_Left = Main.Items.Global_AA_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1)
Main.Items.Global_AA_Y_Add_Right = Main.Items.Global_AA_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1)
Main.Items.Global_AA_Y_Time = Main.Items.Global_AA_Yaw_Add_Type:create():slider("Yaw Snap", 0, 20, 0, 1)

Main.Items.Global_AA_E_Angel_Pitch = Main.Items.Global_AA_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1)
Main.Items.Global_AA_E_Angel_Roll = Main.Items.Global_AA_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1)
Main.Items.Global_AA_E_Angel_Randomizer = Main.Items.Global_AA_Extended_Angels:create():switch("Randomizer")


Main.Items.Global_AA_YM_Modifier = Main.Items.Global_AA_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1)
Main.Items.Global_AA_YM_Modifier_randomize = Main.Items.Global_AA_Yaw_Modifier:create():switch("random"):tooltip("choses a random modifier")


Main.Items.Global_AA_Enable:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)

local function Global_AA_Modifier(allowed)
    if allowed == false then
        if ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"):get() then return end
        if not Main.Items.Global_AA_Enable:get() or not Main.Items.Build_AA:get() then return end

        local exploit_state = rage.exploit:get()

        local localplayer = entity.get_local_player()
        if not localplayer then return end

        local pitch_settings = Main.Items.Global_AA_pitch_settings:get()
        local yaw_settings = Main.Items.Global_AA_yaw_settings:get()
        local Spin_Speed = Main.Items.Global_AA_SpinSpeed:get()


        if Main.Items.Global_AA_Randomize_SpinSpeed:get() then
            Spin_Speed = math.random(Spin_Speed/2, Spin_Speed)
        end

        local prop = localplayer["m_fFlags"]
        local pitch_override = 0
        local yaw_override = 0

        if pitch_settings == "None" then
            pitch_override = nil
        elseif pitch_settings == "Zero" then
            pitch_override = 0
        elseif pitch_settings == "Up" then
            pitch_override = -89
        elseif pitch_settings == "Down" then
            pitch_override = 89
        elseif pitch_settings == "Random" then
            pitch_override = math.random(-89, 89)
        elseif pitch_settings == "Jitter" then
            if (math.floor(globals.curtime * 100000) % 2) == 0 then
                pitch_override = 89
            else
                pitch_override = -89
            end
        elseif pitch_settings == "45 deg" then
            if (math.floor(globals.curtime * 10000) % 2) == 0 then
                pitch_override = 45
            else
                pitch_override = -45
            end
        end

        if yaw_settings == "None" then
            yaw_override = nil
        elseif yaw_settings == "Static" then
            yaw_override = 0
        elseif yaw_settings == "Random" then
            yaw_override = math.random(-179,179)
        elseif yaw_settings == "Side-Way" then
            if (math.floor(globals.curtime * 100000) % 2) == 0 then
                yaw_override = 89
            else
                yaw_override = -90
            end
        elseif yaw_settings == "Spin" then
            yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
        end

        if exploit_state ~= 0 then
            if pitch_override ~= nil and yaw_settings ~= nil then
                -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override(true)
                ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override("Break LC")
                rage.antiaim:override_hidden_pitch(pitch_override)
                rage.antiaim:override_hidden_yaw_offset(yaw_override)
                Main.Main_Anti_Defensive.main.lag_options:override("Always On")
                Main.Main_Anti_Defensive.main.hidden:override(true)
            else
                -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override()
                ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override()
                Main.Main_Anti_Defensive.main.lag_options:override()
                Main.Main_Anti_Defensive.main.hidden:override()
            end
        end

        if Global_Flag == nil and Global_Flag_2 == nil then
            Global_Flag = false
            Global_Flag_2 = false
        end

        if Main.Items.Global_AA_Yaw_Add_Type:get() == 'Jitter' then -- Static
            wait({
                time = Main.Items.Global_AA_Y_Time:get()/10,
                flag = "Global_Jitter",
                Number = 0.1,
                callback = function()
                    if math.random(1, 5) == 5 then
                        Global_Flag_2 = true
                        if math.random(1, 2) == 1 then
                            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(-60)
                        else
                            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(60)
                        end
                    else
                        if Global_Flag then
                            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Global_AA_Y_Add_Right:get())
                        else
                            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Global_AA_Y_Add_Left:get())
                        end
                    end
                    Global_Flag = not Global_Flag
                end
            })

            wait({
                time = 1,
                flag = "Global_Flick",
                Number = 0.9,
                callback = function()
                    if Global_Flag_2 then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(0)
                        Global_Flag_2 = false
                    end
                end
            })
        end

        if Main.Items.Global_AA_Yaw_Add_Type:get() == 'Static' then
            if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Global_AA_Y_Add_Left:get())
            else
                ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Global_AA_Y_Add_Right:get())
            end
        end

        local YawModifier = Main.Items.Global_AA_Yaw_Modifier:get()

        -- if YawModifier ~= "Disabled" then
            if Main.Items.Global_AA_YM_Modifier_randomize:get() then
                YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
            end
            
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):override(Main.Items.Global_AA_YM_Modifier:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override(YawModifier)
        -- end

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Global_AA_Left_Limit:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Global_AA_Right_Limit:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override(Main.Items.Global_AA_Options:get())

        if Main.Items.Global_AA_Extended_Angels:get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(Main.Items.Global_AA_Extended_Angels:get())
            if Main.Items.Global_AA_E_Angel_Randomizer:get() then
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(math.random(-180, 180))
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(math.random(0, 90))
            else
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(Main.Items.Global_AA_E_Angel_Pitch:get())
                ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(Main.Items.Global_AA_E_Angel_Roll:get())
            end
        end
    end
end

Main.Items.Standing_AA_Enable = Builder_Section:switch("Standing Enable")

Main.Items.Standing_AA_pitch_settings = Builder_Section:combo("S ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items.Standing_AA_yaw_settings = Builder_Section:combo("S ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)
Main.Items.Standing_AA_SpinSpeed = Main.Items.Standing_AA_yaw_settings:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items.Standing_AA_Randomize_SpinSpeed = Main.Items.Standing_AA_yaw_settings:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items.Standing_AA_Yaw_Add_Type = Builder_Section:combo("S ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items.Standing_AA_Yaw_Modifier = Builder_Section:combo("S ~ Yaw Modifier", Yaw_modifier_List)

Main.Items.Standing_AA_Left_Limit = Builder_Section:slider("S ~ Left Limit", 0, 60, 0, 1)
Main.Items.Standing_AA_Right_Limit = Builder_Section:slider("S ~ Right Limit", 0, 60, 0, 1)
Main.Items.Standing_AA_Options = Builder_Section:selectable("S ~ Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list())
Main.Items.Standing_AA_Extended_Angels = Builder_Section:switch("S ~ Extended Angels", false)

Main.Items.Standing_AA_Y_Add_Left = Main.Items.Standing_AA_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1)
Main.Items.Standing_AA_Y_Add_Right = Main.Items.Standing_AA_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1)
Main.Items.Standing_AA_Y_Time = Main.Items.Standing_AA_Yaw_Add_Type:create():slider("Yaw Snap", 0, 20, 0, 1)

Main.Items.Standing_AA_E_Angel_Pitch = Main.Items.Standing_AA_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1)
Main.Items.Standing_AA_E_Angel_Roll = Main.Items.Standing_AA_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1)
Main.Items.Standing_AA_E_Angel_Randomizer = Main.Items.Standing_AA_Extended_Angels:create():switch("Randomizer")

Main.Items.Standing_AA_YM_Modifier = Main.Items.Standing_AA_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1)
Main.Items.Standing_AA_YM_Modifier_randomize = Main.Items.Standing_AA_Yaw_Modifier:create():switch("random"):tooltip("choses a random modifier")

Main.Items.Standing_AA_Enable:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)


local function Standing_AA_Modifier()
    if ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"):get() then return end
    if not Main.Items.Standing_AA_Enable:get() or not Main.Items.Build_AA:get() then return end

    local exploit_state = rage.exploit:get()

    local localplayer = entity.get_local_player()
    if not localplayer then return end

    local pitch_settings = Main.Items.Standing_AA_pitch_settings:get()
    local yaw_settings = Main.Items.Standing_AA_yaw_settings:get()
    local Spin_Speed = Main.Items.Standing_AA_SpinSpeed:get()


    if Main.Items.Standing_AA_Randomize_SpinSpeed:get() then
        Spin_Speed = math.random(Spin_Speed/2, Spin_Speed)
    end

    local prop = localplayer["m_fFlags"]
    local pitch_override = 0
    local yaw_override = 0

    if pitch_settings == "None" then
        pitch_override = nil
    elseif pitch_settings == "Zero" then
        pitch_override = 0
    elseif pitch_settings == "Up" then
        pitch_override = -89
    elseif pitch_settings == "Down" then
        pitch_override = 89
    elseif pitch_settings == "Random" then
        pitch_override = math.random(-89, 89)
    elseif pitch_settings == "Jitter" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            pitch_override = 89
        else
            pitch_override = -89
        end
    elseif pitch_settings == "45 deg" then
        if (math.floor(globals.curtime * 10000) % 2) == 0 then
            pitch_override = 45
        else
            pitch_override = -45
        end
    end

    if yaw_settings == "None" then
        yaw_override = nil
    elseif yaw_settings == "Static" then
        yaw_override = 0
    elseif yaw_settings == "Random" then
        yaw_override = math.random(-179,179)
    elseif yaw_settings == "Side-Way" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            yaw_override = 89
        else
            yaw_override = -90
        end
    elseif yaw_settings == "Spin" then
        yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
    end

    if exploit_state ~= 0 then
        if pitch_override ~= nil and yaw_settings ~= nil then
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override(true)
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Main.Main_Anti_Defensive.main.lag_options:override("Always On")
            Main.Main_Anti_Defensive.main.hidden:override(true)
        else
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override()
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override()
            Main.Main_Anti_Defensive.main.lag_options:override()
            Main.Main_Anti_Defensive.main.hidden:override()
        end
    end

    if Standing_Flag == nil and Standing_Flag_2 == nil then
        Standing_Flag = false
        Standing_Flag_2 = false
    end

    if Main.Items.Standing_AA_Yaw_Add_Type:get() == 'Jitter' then -- Static
        wait({
            time = Main.Items.Standing_AA_Y_Time:get()/10,
            flag = "Standing_Jitter",
            Number = 0.1,
            callback = function()
                if math.random(1, 5) == 5 then
                    Standing_Flag_2 = true
                    if math.random(1, 2) == 1 then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(-60)
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(60)
                    end
                else
                    if Standing_Flag then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Standing_AA_Y_Add_Right:get())
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Standing_AA_Y_Add_Left:get())
                    end
                end
                Standing_Flag = not Standing_Flag
            end
        })
        wait({
            time = 1,
            flag = "Standing_Flick",
            Number = 0.9,
            callback = function()
                if Standing_Flag_2 then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(0)
                    Standing_Flag_2 = false
                end
            end
        })
        -- AAWait(Main.Items.Standing_AA_Y_Time:get(), function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Standing_AA_Y_Add_Right:get())
        -- end, function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Standing_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Standing_AA_Yaw_Add_Type:get() == 'Static' then
        if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Standing_AA_Y_Add_Left:get())
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Standing_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Standing_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Standing_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):override(Main.Items.Standing_AA_YM_Modifier:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Standing_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Standing_AA_Right_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override(Main.Items.Standing_AA_Options:get())

    if Main.Items.Standing_AA_Extended_Angels:get() then
        ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(Main.Items.Standing_AA_Extended_Angels:get())
        if Main.Items.Standing_AA_E_Angel_Randomizer:get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(math.random(-180, 180))
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(math.random(0, 90))
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(Main.Items.Standing_AA_E_Angel_Pitch:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(Main.Items.Standing_AA_E_Angel_Roll:get())
        end
    end

end

local Setting = "Walking"

Main.Items[Setting.."_AA_Enable"] = Builder_Section:switch("Walking Enable")

Main.Items[Setting.."_AA_pitch_settings"] = Builder_Section:combo("W ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items[Setting.."_AA_yaw_settings"] = Builder_Section:combo("W ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)
Main.Items[Setting.."_AA_SpinSpeed"] = Main.Items[Setting.."_AA_yaw_settings"]:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items[Setting.."_AA_Randomize_SpinSpeed"] = Main.Items[Setting.."_AA_yaw_settings"]:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items[Setting.."_AA_Yaw_Add_Type"] = Builder_Section:combo("W ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items[Setting.."_AA_Yaw_Modifier"] = Builder_Section:combo("W ~ Yaw Modifier", Yaw_modifier_List)

Main.Items[Setting.."_AA_Left_Limit"] = Builder_Section:slider("W ~ Left Limit", 0, 60, 0, 1)
Main.Items[Setting.."_AA_Right_Limit"] = Builder_Section:slider("W ~ Right Limit", 0, 60, 0, 1)
Main.Items[Setting.."_AA_Options"] = Builder_Section:selectable("W ~ Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list())
Main.Items[Setting.."_AA_Extended_Angels"] = Builder_Section:switch("W ~ Extended Angels", false)

Main.Items[Setting.."_AA_Y_Add_Left"] = Main.Items[Setting.."_AA_Yaw_Add_Type"]:create():slider("Yaw Add - Left", -90, 90, 0, 1)
Main.Items[Setting.."_AA_Y_Add_Right"] = Main.Items[Setting.."_AA_Yaw_Add_Type"]:create():slider("Yaw Add - Right", -90, 90, 0, 1)
Main.Items[Setting.."_AA_Y_Time"] = Main.Items[Setting.."_AA_Yaw_Add_Type"]:create():slider("Yaw Snap", 0, 20, 0, 1)

Main.Items[Setting.."_AA_E_Angel_Pitch"] = Main.Items[Setting.."_AA_Extended_Angels"]:create():slider("Extended Pitch", -180, 180, 0, 1)
Main.Items[Setting.."_AA_E_Angel_Roll"] = Main.Items[Setting.."_AA_Extended_Angels"]:create():slider("Extended Roll", 0, 90, 0, 1)
Main.Items[Setting.."_AA_E_Angel_Randomizer"] = Main.Items[Setting.."_AA_Extended_Angels"]:create():switch("Randomizer")


Main.Items[Setting.."_AA_YM_Modifier"] = Main.Items[Setting.."_AA_Yaw_Modifier"]:create():slider("Offset", -180, 180, 0, 1)
Main.Items[Setting.."_AA_YM_Modifier_randomize"] = Main.Items[Setting.."_AA_Yaw_Modifier"]:create():switch("random"):tooltip("choses a random modifier")


Main.Items[Setting.."_AA_Enable"]:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)


local function Walking_AA_Modifier()
    if ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"):get() then return end
    if not Main.Items[Setting.."_AA_Enable"]:get() or not Main.Items.Build_AA:get() then return end

    local exploit_state = rage.exploit:get()

    local localplayer = entity.get_local_player()
    if not localplayer then return end

    local pitch_settings = Main.Items.Walking_AA_pitch_settings:get()
    local yaw_settings = Main.Items.Walking_AA_yaw_settings:get()
    local Spin_Speed = Main.Items.Walking_AA_SpinSpeed:get()


    if Main.Items.Walking_AA_Randomize_SpinSpeed:get() then
        Spin_Speed = math.random(Spin_Speed/2, Spin_Speed)
    end

    local prop = localplayer["m_fFlags"]
    local pitch_override = 0
    local yaw_override = 0

    if pitch_settings == "None" then
        pitch_override = nil
    elseif pitch_settings == "Zero" then
        pitch_override = 0
    elseif pitch_settings == "Up" then
        pitch_override = -89
    elseif pitch_settings == "Down" then
        pitch_override = 89
    elseif pitch_settings == "Random" then
        pitch_override = math.random(-89, 89)
    elseif pitch_settings == "Jitter" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            pitch_override = 89
        else
            pitch_override = -89
        end
    elseif pitch_settings == "45 deg" then
        if (math.floor(globals.curtime * 10000) % 2) == 0 then
            pitch_override = 45
        else
            pitch_override = -45
        end
    end

    if yaw_settings == "None" then
        yaw_override = nil
    elseif yaw_settings == "Static" then
        yaw_override = 0
    elseif yaw_settings == "Random" then
        yaw_override = math.random(-179,179)
    elseif yaw_settings == "Side-Way" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            yaw_override = 89
        else
            yaw_override = -90
        end
    elseif yaw_settings == "Spin" then
        yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
    end

    if exploit_state ~= 0 then
        if pitch_override ~= nil and yaw_settings ~= nil then
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override(true)
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Main.Main_Anti_Defensive.main.lag_options:override("Always On")
            Main.Main_Anti_Defensive.main.hidden:override(true)
        else
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override()
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override()
            Main.Main_Anti_Defensive.main.lag_options:override()
            Main.Main_Anti_Defensive.main.hidden:override()
        end
    end

    if not Walking_Flag and not Walking_Flag_2 then
        Walking_Flag = false
        Walking_Flag_2 = false
    end

    if Main.Items.Walking_AA_Yaw_Add_Type:get() == 'Jitter' then -- Static
        wait({
            time = Main.Items.Walking_AA_Y_Time:get()/10,
            flag = "Walking_Jitter",
            Number = 0.1,
            callback = function()
                if math.random(1, 5) == 5 then
                    Walking_Flag_2 = true
                    if math.random(1, 2) == 1 then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(-60)
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(60)
                    end
                else
                    if Walking_Flag then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Walking_AA_Y_Add_Right:get())
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Walking_AA_Y_Add_Left:get())
                    end
                end
                Walking_Flag = not Walking_Flag
            end
        })
        wait({
            time = 1,
            flag = "Walking_Flick",
            Number = 0.9,
            callback = function()
                if Walking_Flag_2 then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(0)
                    Walking_Flag_2 = false
                end
            end
        })
        -- AAWait(Main.Items.Walking_AA_Y_Time:get(), function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Walking_AA_Y_Add_Right:get())
        -- end, function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Walking_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Walking_AA_Yaw_Add_Type:get() == 'Static' then
        if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Walking_AA_Y_Add_Left:get())
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Walking_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Walking_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Walking_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):override(Main.Items.Walking_AA_YM_Modifier:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Walking_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Walking_AA_Right_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override(Main.Items.Walking_AA_Options:get())

    if Main.Items.Walking_AA_Extended_Angels:get() then
        ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(Main.Items.Walking_AA_Extended_Angels:get())
        if Main.Items[Setting.."_AA_E_Angel_Randomizer"]:get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(math.random(-180, 180))
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(math.random(0, 90))
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(Main.Items.Walking_AA_E_Angel_Pitch:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(Main.Items.Walking_AA_E_Angel_Roll:get())
        end
    end

end

Main.Items.Running_AA_Enable = Builder_Section:switch("Running Enable")

Main.Items.Running_AA_pitch_settings = Builder_Section:combo("R ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items.Running_AA_yaw_settings = Builder_Section:combo("R ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)

Main.Items.Running_AA_SpinSpeed = Main.Items.Running_AA_yaw_settings:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items.Running_AA_Randomize_SpinSpeed = Main.Items.Running_AA_yaw_settings:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items.Running_AA_Yaw_Add_Type = Builder_Section:combo("R ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items.Running_AA_Yaw_Modifier = Builder_Section:combo("R ~ Yaw Modifier", Yaw_modifier_List)

Main.Items.Running_AA_Left_Limit = Builder_Section:slider("R ~ Left Limit", 0, 60, 0, 1)
Main.Items.Running_AA_Right_Limit = Builder_Section:slider("R ~ Right Limit", 0, 60, 0, 1)
Main.Items.Running_AA_Options = Builder_Section:selectable("R ~ Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list())
Main.Items.Running_AA_Extended_Angels = Builder_Section:switch("R ~ Extended Angels", false)

Main.Items.Running_AA_Y_Add_Left = Main.Items.Running_AA_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1)
Main.Items.Running_AA_Y_Add_Right = Main.Items.Running_AA_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1)
Main.Items.Running_AA_Y_Time = Main.Items.Running_AA_Yaw_Add_Type:create():slider("Yaw Snap", 0, 20, 0, 1)

Main.Items.Running_AA_E_Angel_Pitch = Main.Items.Running_AA_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1)
Main.Items.Running_AA_E_Angel_Roll = Main.Items.Running_AA_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1)
Main.Items.Running_AA_E_Angel_Randomizer = Main.Items.Running_AA_Extended_Angels:create():switch("Randomizer")

Main.Items.Running_AA_YM_Modifier = Main.Items.Running_AA_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1)
Main.Items.Running_AA_YM_Modifier_randomize = Main.Items.Running_AA_Yaw_Modifier:create():switch("random"):tooltip("choses a random modifier")


Main.Items.Running_AA_Enable:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)


local function Running_AA_Modifier()
    if ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"):get() then return end
    if not Main.Items.Running_AA_Enable:get() or not Main.Items.Build_AA:get() then return end

    local exploit_state = rage.exploit:get()

    local localplayer = entity.get_local_player()
    if not localplayer then return end

    local pitch_settings = Main.Items.Running_AA_pitch_settings:get()
    local yaw_settings = Main.Items.Running_AA_yaw_settings:get()
    local Spin_Speed = Main.Items.Running_AA_SpinSpeed:get()


    if Main.Items.Running_AA_Randomize_SpinSpeed:get() then
        Spin_Speed = math.random(Spin_Speed/2, Spin_Speed)
    end

    local prop = localplayer["m_fFlags"]
    local pitch_override = 0
    local yaw_override = 0

    if pitch_settings == "None" then
        pitch_override = nil
    elseif pitch_settings == "Zero" then
        pitch_override = 0
    elseif pitch_settings == "Up" then
        pitch_override = -89
    elseif pitch_settings == "Down" then
        pitch_override = 89
    elseif pitch_settings == "Random" then
        pitch_override = math.random(-89, 89)
    elseif pitch_settings == "Jitter" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            pitch_override = 89
        else
            pitch_override = -89
        end
    elseif pitch_settings == "45 deg" then
        if (math.floor(globals.curtime * 10000) % 2) == 0 then
            pitch_override = 45
        else
            pitch_override = -45
        end
    end

    if yaw_settings == "None" then
        yaw_override = nil
    elseif yaw_settings == "Static" then
        yaw_override = 0
    elseif yaw_settings == "Random" then
        yaw_override = math.random(-179,179)
    elseif yaw_settings == "Side-Way" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            yaw_override = 89
        else
            yaw_override = -90
        end
    elseif yaw_settings == "Spin" then
        yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
    end

    if exploit_state ~= 0 then
        if pitch_override ~= nil and yaw_settings ~= nil then
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override(true)
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Main.Main_Anti_Defensive.main.lag_options:override("Always On")
            Main.Main_Anti_Defensive.main.hidden:override(true)
        else
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override()
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override()
            Main.Main_Anti_Defensive.main.lag_options:override()
            Main.Main_Anti_Defensive.main.hidden:override()
        end
    end

    if not Running_Flag and not Running_Flag_2 then
        Running_Flag = false
        Running_Flag_2 = false
    end

    if Main.Items.Running_AA_Yaw_Add_Type:get() == 'Jitter' then -- Static
        wait({
            time = Main.Items.Running_AA_Y_Time:get()/10,
            flag = "Running_Jitter",
            Number = 0.1,
            callback = function()
                if math.random(1, 5) == 5 then
                    Running_Flag_2 = true
                    if math.random(1, 2) == 1 then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(-60)
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(60)
                    end
                else
                    if Running_Flag then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Running_AA_Y_Add_Right:get())
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Running_AA_Y_Add_Left:get())
                    end
                end
                Running_Flag = not Running_Flag
            end
        })
        wait({
            time = 1,
            flag = "Running_Flick",
            Number = 0.9,
            callback = function()
                if Running_Flag_2 then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(0)
                    Running_Flag_2 = false
                end
            end
        })
        -- AAWait(Main.Items.Running_AA_Y_Time:get(), function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Running_AA_Y_Add_Right:get())
        -- end, function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Running_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Running_AA_Yaw_Add_Type:get() == 'Static' then
        if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Running_AA_Y_Add_Left:get())
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Running_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Running_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Running_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):override(Main.Items.Running_AA_YM_Modifier:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Running_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Running_AA_Right_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override(Main.Items.Running_AA_Options:get())

    if Main.Items.Running_AA_Extended_Angels:get() then
        ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(Main.Items.Running_AA_Extended_Angels:get())
        if Main.Items.Running_AA_E_Angel_Randomizer:get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(math.random(-180, 180))
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(math.random(0, 90))
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(Main.Items.Running_AA_E_Angel_Pitch:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(Main.Items.Running_AA_E_Angel_Roll:get())
        end
    end

end


Main.Items.Crouching_AA_Enable = Builder_Section:switch("Crouching Enable")

Main.Items.Crouching_AA_pitch_settings = Builder_Section:combo("C ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items.Crouching_AA_yaw_settings = Builder_Section:combo("C ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)

Main.Items.Crouching_AA_SpinSpeed = Main.Items.Crouching_AA_yaw_settings:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items.Crouching_AA_Randomize_SpinSpeed = Main.Items.Crouching_AA_yaw_settings:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items.Crouching_AA_Yaw_Add_Type = Builder_Section:combo("C ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items.Crouching_AA_Yaw_Modifier = Builder_Section:combo("C ~ Yaw Modifier", Yaw_modifier_List)

Main.Items.Crouching_AA_Left_Limit = Builder_Section:slider("C ~ Left Limit", 0, 60, 0, 1)
Main.Items.Crouching_AA_Right_Limit = Builder_Section:slider("C ~ Right Limit", 0, 60, 0, 1)
Main.Items.Crouching_AA_Options = Builder_Section:selectable("C ~ Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list())
Main.Items.Crouching_AA_Extended_Angels = Builder_Section:switch("C ~ Extended Angels", false)

Main.Items.Crouching_AA_Y_Add_Left = Main.Items.Crouching_AA_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1)
Main.Items.Crouching_AA_Y_Add_Right = Main.Items.Crouching_AA_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1)
Main.Items.Crouching_AA_Y_Time = Main.Items.Crouching_AA_Yaw_Add_Type:create():slider("Yaw Snap", 0, 20, 0, 1)

Main.Items.Crouching_AA_E_Angel_Pitch = Main.Items.Crouching_AA_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1)
Main.Items.Crouching_AA_E_Angel_Roll = Main.Items.Crouching_AA_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1)
Main.Items.Crouching_AA_E_Angel_Randomizer = Main.Items.Crouching_AA_Extended_Angels:create():switch("Randomizer")


Main.Items.Crouching_AA_YM_Modifier = Main.Items.Crouching_AA_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1)
Main.Items.Crouching_AA_YM_Modifier_randomize = Main.Items.Crouching_AA_Yaw_Modifier:create():switch("random"):tooltip("choses a random modifier")


Main.Items.Crouching_AA_Enable:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)


local function Crouching_AA_Modifier()
    if ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"):get() then return end
    if not Main.Items.Crouching_AA_Enable:get() or not Main.Items.Build_AA:get() then return end

    local exploit_state = rage.exploit:get()

    local localplayer = entity.get_local_player()
    if not localplayer then return end

    local pitch_settings = Main.Items.Crouching_AA_pitch_settings:get()
    local yaw_settings = Main.Items.Crouching_AA_yaw_settings:get()
    local Spin_Speed = Main.Items.Crouching_AA_SpinSpeed:get()


    if Main.Items.Crouching_AA_Randomize_SpinSpeed:get() then
        Spin_Speed = math.random(Spin_Speed/2, Spin_Speed)
    end

    local prop = localplayer["m_fFlags"]
    local pitch_override = 0
    local yaw_override = 0

    if pitch_settings == "None" then
        pitch_override = nil
    elseif pitch_settings == "Zero" then
        pitch_override = 0
    elseif pitch_settings == "Up" then
        pitch_override = -89
    elseif pitch_settings == "Down" then
        pitch_override = 89
    elseif pitch_settings == "Random" then
        pitch_override = math.random(-89, 89)
    elseif pitch_settings == "Jitter" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            pitch_override = 89
        else
            pitch_override = -89
        end
    elseif pitch_settings == "45 deg" then
        if (math.floor(globals.curtime * 10000) % 2) == 0 then
            pitch_override = 45
        else
            pitch_override = -45
        end
    end

    if yaw_settings == "None" then
        yaw_override = nil
    elseif yaw_settings == "Static" then
        yaw_override = 0
    elseif yaw_settings == "Random" then
        yaw_override = math.random(-179,179)
    elseif yaw_settings == "Side-Way" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            yaw_override = 89
        else
            yaw_override = -90
        end
    elseif yaw_settings == "Spin" then
        yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
    end

    if exploit_state ~= 0 then
        if pitch_override ~= nil and yaw_settings ~= nil then
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override(true)
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Main.Main_Anti_Defensive.main.lag_options:override("Always On")
            Main.Main_Anti_Defensive.main.hidden:override(true)
        else
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override()
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override()
            Main.Main_Anti_Defensive.main.lag_options:override()
            Main.Main_Anti_Defensive.main.hidden:override()
        end
    end

    if not Crouching_Flag and not Crouching_Flag2 then
        Crouching_Flag = false
        Crouching_Flag2 = false
    end

    if Main.Items.Crouching_AA_Yaw_Add_Type:get() == 'Jitter' then -- Static
        wait({
            time = Main.Items.Crouching_AA_Y_Time:get()/10,
            flag = "Crouching_Jitter",
            Number = 0.1,
            callback = function()
                if math.random(1, 5) == 5 then
                    Crouching_Flag2 = true
                    if math.random(1, 2) == 1 then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(-60)
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(60)
                    end
                else
                    if Crouching_Flag then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Crouching_AA_Y_Add_Right:get())
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Crouching_AA_Y_Add_Left:get())
                    end
                end

                Crouching_Flag = not Crouching_Flag
            end
        })
        wait({
            time = 1,
            flag = "Crouching_Flick",
            Number = 0.9,
            callback = function()
                if Crouching_Flag2 then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(0)
                    Crouching_Flag2 = false
                end
            end
        })
        -- AAWait(Main.Items.Crouching_AA_Y_Time:get(), function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Crouching_AA_Y_Add_Right:get())
        -- end, function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Crouching_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Crouching_AA_Yaw_Add_Type:get() == 'Static' then
        if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Crouching_AA_Y_Add_Left:get())
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.Crouching_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Crouching_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Crouching_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):override(Main.Items.Crouching_AA_YM_Modifier:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Crouching_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Crouching_AA_Right_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override(Main.Items.Crouching_AA_Options:get())

    if Main.Items.Crouching_AA_Extended_Angels:get() then
        ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(Main.Items.Crouching_AA_Extended_Angels:get())
        if Main.Items.Crouching_AA_E_Angel_Randomizer:get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(math.random(-180, 180))
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(math.random(0, 90))
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(Main.Items.Crouching_AA_E_Angel_Pitch:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(Main.Items.Crouching_AA_E_Angel_Roll:get())
        end
    end

end

Main.Items.In_Air_AA_Enable = Builder_Section:switch("In Air Enable")

Main.Items.In_Air_AA_pitch_settings = Builder_Section:combo("A ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items.In_Air_AA_yaw_settings = Builder_Section:combo("A ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)

Main.Items.In_Air_AA_SpinSpeed = Main.Items.In_Air_AA_yaw_settings:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items.In_Air_AA_Randomize_SpinSpeed = Main.Items.In_Air_AA_yaw_settings:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items.In_Air_AA_Yaw_Add_Type = Builder_Section:combo("A ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items.In_Air_AA_Yaw_Modifier = Builder_Section:combo("A ~ Yaw Modifier", Yaw_modifier_List)

Main.Items.In_Air_AA_Left_Limit = Builder_Section:slider("A ~ Left Limit", 0, 60, 0, 1)
Main.Items.In_Air_AA_Right_Limit = Builder_Section:slider("A ~ Right Limit", 0, 60, 0, 1)
Main.Items.In_Air_AA_Options = Builder_Section:selectable("A ~ Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list())
Main.Items.In_Air_AA_Extended_Angels = Builder_Section:switch("A ~ Extended Angels", false)

Main.Items.In_Air_AA_Y_Add_Left = Main.Items.In_Air_AA_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1)
Main.Items.In_Air_AA_Y_Add_Right = Main.Items.In_Air_AA_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1)
Main.Items.In_Air_AA_Y_Time = Main.Items.In_Air_AA_Yaw_Add_Type:create():slider("Yaw Snap", 0, 20, 0, 1)

Main.Items.In_Air_AA_E_Angel_Pitch = Main.Items.In_Air_AA_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1)
Main.Items.In_Air_AA_E_Angel_Roll = Main.Items.In_Air_AA_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1)
Main.Items.In_Air_AA_E_Angel_Randomizer = Main.Items.In_Air_AA_Extended_Angels:create():switch("Randomizer")


Main.Items.In_Air_AA_YM_Modifier = Main.Items.In_Air_AA_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1)
Main.Items.In_Air_AA_YM_Modifier_randomize = Main.Items.In_Air_AA_Yaw_Modifier:create():switch("random"):tooltip("choses a random modifier")


Main.Items.In_Air_AA_Enable:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)


local function In_Air_AA_Modifier()
    if ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"):get() then return end
    if not Main.Items.In_Air_AA_Enable:get() or not Main.Items.Build_AA:get() then return end

    local exploit_state = rage.exploit:get()

    local localplayer = entity.get_local_player()
    if not localplayer then return end

    local pitch_settings = Main.Items.In_Air_AA_pitch_settings:get()
    local yaw_settings = Main.Items.In_Air_AA_yaw_settings:get()
    local Spin_Speed = Main.Items.In_Air_AA_SpinSpeed:get()


    if Main.Items.In_Air_AA_Randomize_SpinSpeed:get() then
        Spin_Speed = math.random(Spin_Speed/2, Spin_Speed)
    end

    local prop = localplayer["m_fFlags"]
    local pitch_override = 0
    local yaw_override = 0

    if pitch_settings == "None" then
        pitch_override = nil
    elseif pitch_settings == "Zero" then
        pitch_override = 0
    elseif pitch_settings == "Up" then
        pitch_override = -89
    elseif pitch_settings == "Down" then
        pitch_override = 89
    elseif pitch_settings == "Random" then
        pitch_override = math.random(-89, 89)
    elseif pitch_settings == "Jitter" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            pitch_override = 89
        else
            pitch_override = -89
        end
    elseif pitch_settings == "45 deg" then
        if (math.floor(globals.curtime * 10000) % 2) == 0 then
            pitch_override = 45
        else
            pitch_override = -45
        end
    end

    if yaw_settings == "None" then
        yaw_override = nil
    elseif yaw_settings == "Static" then
        yaw_override = 0
    elseif yaw_settings == "Random" then
        yaw_override = math.random(-179,179)
    elseif yaw_settings == "Side-Way" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            yaw_override = 89
        else
            yaw_override = -90
        end
    elseif yaw_settings == "Spin" then
        yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
    end

    if exploit_state ~= 0 then
        if pitch_override ~= nil and yaw_settings ~= nil then
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override(true)
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Main.Main_Anti_Defensive.main.lag_options:override("Always On")
            Main.Main_Anti_Defensive.main.hidden:override(true)
        else
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override()
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override()
            Main.Main_Anti_Defensive.main.lag_options:override()
            Main.Main_Anti_Defensive.main.hidden:override()
        end
    end

    if not In_Air_Flag and not In_Air_Flag2 then
        In_Air_Flag = false
        In_Air_Flag2 = false
    end

    if Main.Items.In_Air_AA_Yaw_Add_Type:get() == 'Jitter' then -- Static
        wait({
            time = Main.Items.In_Air_AA_Y_Time:get()/10,
            flag = "In_Air_Jitter",
            Number = 0.1,
            callback = function()
                if math.random(1, 5) == 5 then
                    In_Air_Flag2 = true
                    if math.random(1, 2) == 1 then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(-60)
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(60)
                    end
                else
                    if In_Air_Flag then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AA_Y_Add_Right:get())
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AA_Y_Add_Left:get())
                    end
                end
                In_Air_Flag = not In_Air_Flag
            end
        })
        wait({
            time = 1,
            flag = "In_Air_Flick",
            Number = 0.9,
            callback = function()
                if In_Air_Flag2 then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(0)
                    In_Air_Flag2 = false
                end
            end
        })
        -- AAWait(Main.Items.In_Air_AA_Y_Time:get(), function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AA_Y_Add_Right:get())
        -- end, function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.In_Air_AA_Yaw_Add_Type:get() == 'Static' then
        if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AA_Y_Add_Left:get())
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.In_Air_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.In_Air_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):override(Main.Items.In_Air_AA_YM_Modifier:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.In_Air_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.In_Air_AA_Right_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override(Main.Items.In_Air_AA_Options:get())

    if Main.Items.In_Air_AA_Extended_Angels:get() then
        ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(Main.Items.In_Air_AA_Extended_Angels:get())
        if Main.Items.In_Air_AA_E_Angel_Randomizer:get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(math.random(-180, 180))
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(math.random(0, 90))
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(Main.Items.In_Air_AA_E_Angel_Pitch:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(Main.Items.In_Air_AA_E_Angel_Roll:get())
        end
    end

end

Main.Items.In_Air_AC_AA_Enable = Builder_Section:switch("In Air Crouch Enable")

Main.Items.In_Air_AC_AA_pitch_settings = Builder_Section:combo("AC ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items.In_Air_AC_AA_yaw_settings = Builder_Section:combo("AC ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)

Main.Items.In_Air_AC_AA_SpinSpeed = Main.Items.In_Air_AC_AA_yaw_settings:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items.In_Air_AC_AA_Randomize_SpinSpeed = Main.Items.In_Air_AC_AA_yaw_settings:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items.In_Air_AC_AA_Yaw_Add_Type = Builder_Section:combo("AC ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items.In_Air_AC_AA_Yaw_Modifier = Builder_Section:combo("AC ~ Yaw Modifier", Yaw_modifier_List)

Main.Items.In_Air_AC_AA_Left_Limit = Builder_Section:slider("AC ~ Left Limit", 0, 60, 0, 1)
Main.Items.In_Air_AC_AA_Right_Limit = Builder_Section:slider("AC ~ Right Limit", 0, 60, 0, 1)
Main.Items.In_Air_AC_AA_Options = Builder_Section:selectable("AC ~ Options", ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):list())
Main.Items.In_Air_AC_AA_Extended_Angels = Builder_Section:switch("AC ~ Extended Angels", false)

Main.Items.In_Air_AC_AA_Y_Add_Left = Main.Items.In_Air_AC_AA_Yaw_Add_Type:create():slider("Yaw Add - Left", -90, 90, 0, 1)
Main.Items.In_Air_AC_AA_Y_Add_Right = Main.Items.In_Air_AC_AA_Yaw_Add_Type:create():slider("Yaw Add - Right", -90, 90, 0, 1)
Main.Items.In_Air_AC_AA_Y_Time = Main.Items.In_Air_AC_AA_Yaw_Add_Type:create():slider("Yaw Snap", 0, 20, 0, 1)

Main.Items.In_Air_AC_AA_E_Angel_Pitch = Main.Items.In_Air_AC_AA_Extended_Angels:create():slider("Extended Pitch", -180, 180, 0, 1)
Main.Items.In_Air_AC_AA_E_Angel_Roll = Main.Items.In_Air_AC_AA_Extended_Angels:create():slider("Extended Roll", 0, 90, 0, 1)
Main.Items.In_Air_AC_AA_E_Angel_Randomizer = Main.Items.In_Air_AA_Extended_Angels:create():switch("Randomizer")


Main.Items.In_Air_AC_AA_YM_Modifier = Main.Items.In_Air_AC_AA_Yaw_Modifier:create():slider("Offset", -180, 180, 0, 1)
Main.Items.In_Air_AC_AA_YM_Modifier_randomize = Main.Items.In_Air_AC_AA_Yaw_Modifier:create():switch("random"):tooltip("choses a random modifier")


Main.Items.In_Air_AC_AA_Enable:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)


local function In_Air_AC_AA_Modifier()
    if ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"):get() then return end
    if not Main.Items.In_Air_AC_AA_Enable:get() or not Main.Items.Build_AA:get() then return end

    local exploit_state = rage.exploit:get()

    local localplayer = entity.get_local_player()
    if not localplayer then return end

    local pitch_settings = Main.Items.In_Air_AC_AA_pitch_settings:get()
    local yaw_settings = Main.Items.In_Air_AC_AA_yaw_settings:get()
    local Spin_Speed = Main.Items.In_Air_AC_AA_SpinSpeed:get()


    if Main.Items.In_Air_AC_AA_Randomize_SpinSpeed:get() then
        Spin_Speed = math.random(Spin_Speed/2, Spin_Speed)
    end

    local prop = localplayer["m_fFlags"]
    local pitch_override = 0
    local yaw_override = 0

    if pitch_settings == "None" then
        pitch_override = nil
    elseif pitch_settings == "Zero" then
        pitch_override = 0
    elseif pitch_settings == "Up" then
        pitch_override = -89
    elseif pitch_settings == "Down" then
        pitch_override = 89
    elseif pitch_settings == "Random" then
        pitch_override = math.random(-89, 89)
    elseif pitch_settings == "Jitter" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            pitch_override = 89
        else
            pitch_override = -89
        end
    elseif pitch_settings == "45 deg" then
        if (math.floor(globals.curtime * 10000) % 2) == 0 then
            pitch_override = 45
        else
            pitch_override = -45
        end
    end

    if yaw_settings == "None" then
        yaw_override = nil
    elseif yaw_settings == "Static" then
        yaw_override = 0
    elseif yaw_settings == "Random" then
        yaw_override = math.random(-179,179)
    elseif yaw_settings == "Side-Way" then
        if (math.floor(globals.curtime * 100000) % 2) == 0 then
            yaw_override = 89
        else
            yaw_override = -90
        end
    elseif yaw_settings == "Spin" then
        yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
    end

    if exploit_state ~= 0 then
        if pitch_override ~= nil and yaw_settings ~= nil then
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override(true)
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Main.Main_Anti_Defensive.main.lag_options:override("Always On")
            Main.Main_Anti_Defensive.main.hidden:override(true)
        else
            -- ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):override()
            ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"):override()
            Main.Main_Anti_Defensive.main.lag_options:override()
            Main.Main_Anti_Defensive.main.hidden:override()
        end
    end

    if not In_Air_AC_Flag and not In_Air_AC_Flag2 then
        In_Air_AC_Flag = false
        In_Air_AC_Flag2 = false
    end

    if Main.Items.In_Air_AC_AA_Yaw_Add_Type:get() == 'Jitter' then -- Static
        wait({
            time = Main.Items.In_Air_AC_AA_Y_Time:get()/10,
            flag = "In_Air_AC_Jitter",
            Number = 0.1,
            callback = function()
                if math.random(1, 5) == 5 then
                    In_Air_AC_Flag2 = true
                    if math.random(1, 2) == 1 then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(-60)
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(60)
                    end
                else
                    if In_Air_AC_Flag then
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AC_AA_Y_Add_Right:get())
                    else
                        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AC_AA_Y_Add_Left:get())
                    end
                end
                In_Air_AC_Flag = not In_Air_AC_Flag
            end
        })
        wait({
            time = 1,
            flag = "In_Air_AC_Flick",
            Number = 0.9,
            callback = function()
                if In_Air_AC_Flag2 then
                    ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(0)
                    In_Air_AC_Flag2 = false
                end
            end
        })
        -- AAWait(Main.Items.In_Air_AC_AA_Y_Time:get(), function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AC_AA_Y_Add_Right:get())
        -- end, function()
        --     ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AC_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.In_Air_AC_AA_Yaw_Add_Type:get() == 'Static' then
        if ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"):get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AC_AA_Y_Add_Left:get())
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"):override(Main.Items.In_Air_AC_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.In_Air_AC_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.In_Air_AC_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"):override(Main.Items.In_Air_AC_AA_YM_Modifier:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.In_Air_AC_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.In_Air_AC_AA_Right_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override(Main.Items.In_Air_AC_AA_Options:get())

    if Main.Items.In_Air_AC_AA_Extended_Angels:get() then
        ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(Main.Items.In_Air_AC_AA_Extended_Angels:get())
        if Main.Items.In_Air_AC_AA_E_Angel_Randomizer:get() then
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(math.random(-180, 180))
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(math.random(0, 90))
        else
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Pitch"):override(Main.Items.In_Air_AC_AA_E_Angel_Pitch:get())
            ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles", "Extended Roll"):override(Main.Items.In_Air_AC_AA_E_Angel_Roll:get())
        end
    end

end


Main.Items.Fake_Lag_AA_Enable = Builder_Section:switch("Fake Lag Enable")

Main.Items.Fake_Lag_AA_Randomizer = Builder_Section:switch("FL ~ Randomize")
Main.Items.Fake_Lag_AA_Max_Limit = Builder_Section:slider("FL ~ Max Limit", 0, 14, 0, 1)
Main.Items.Fake_Lag_AA_Min_Limit = Builder_Section:slider("FL ~ Min Limit", 0, 14, 0, 1)
Main.Items.Fake_Lag_AA_Next_Phase_Time = Builder_Section:slider("FL ~ Next Phase Time", 0, 20, 0, 1)

Main.Items.Fake_Lag_AA_Variability = Builder_Section:slider("FL ~ Variability", 0, 100, 0, 1)

Main.Items.Fake_Lag_AA_Variability_choker = Main.Items.Fake_Lag_AA_Variability:create():switch("FL ~ Variability choker")


Main.Items.Fake_Lag_AA_Enable:set_callback(function()
    extasy_global(TurnTalbe(Chose_Options:get()))
end)


local function Fake_Lag_AA_Modifier()
    if not Main.Items.Fake_Lag_AA_Enable:get() or not Main.Items.Build_AA:get() then return end

    local localplayer = entity.get_local_player()
    if not localplayer then return end

    if Main.Items.Fake_Lag_AA_Variability_choker:get() then
        wait({
            time = math.random(),
            flag = "Fake_Lag_Variability",
            Number = 0.01,
            callback = function()
                ui.find("Aimbot", "Anti Aim", "Fake Lag", "Variability"):override(math.random(0, 100))
            end
        })
    else
        ui.find("Aimbot", "Anti Aim", "Fake Lag", "Variability"):override(Main.Items.Fake_Lag_AA_Variability:get())
    end

    

    if Main.Items.Fake_Lag_AA_Min_Limit:get() > Main.Items.Fake_Lag_AA_Max_Limit:get() then
        Main.Items.Fake_Lag_AA_Max_Limit:set(Main.Items.Fake_Lag_AA_Min_Limit:get())
    end


    if Main.Items.Fake_Lag_AA_Randomizer:get() then
        wait({
            time = Main.Items.Fake_Lag_AA_Next_Phase_Time:get()/10,
            flag = "Fake_Lag_Limit",
            Number = 0.01,
            callback = function()
                ui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit"):override(math.random(Main.Items.Fake_Lag_AA_Min_Limit:get(), Main.Items.Fake_Lag_AA_Max_Limit:get()))
            end
        })
    else
        ui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit"):override(Main.Items.Fake_Lag_AA_Max_Limit:get())
    end

end


local function GetState()
    local Player = entity.get_local_player()
    if Player == nil then return '' end
    local vec = Player.m_vecVelocity
    local velocity = math.sqrt((vec.x * vec.x) + (vec.y * vec.y))

    local walkingSpeedThreshold = 25  -- Approximate walking speed
    local runningSpeedThreshold = 100  -- Approximate running speed
    
    if Player.m_fFlags == 256 and Player.m_flDuckAmount < 0.8 then
        return "In Air"
    elseif Player.m_flDuckAmount > 0.8 and Player.m_fFlags ~= 256 then
        return "Crouching"
    elseif Player.m_flDuckAmount > 0.8 and Player.m_fFlags == 256 then
        return "In Air + Crouching"
    elseif velocity <= 2 then
        return "Standing"
    elseif velocity > walkingSpeedThreshold and velocity <= runningSpeedThreshold then
        return "Walking"
    elseif velocity > runningSpeedThreshold then
        return "Running"
    end
    
    return ''
end


local function AntiAim_createmove(cmd)
    if GetState() == "Standing" and Main.Items.Standing_AA_Enable:get() then
        Standing_AA_Modifier()
    elseif GetState() == "Walking" and Main.Items.Walking_AA_Enable:get() then
        Walking_AA_Modifier()
    elseif GetState() == "Running" and Main.Items.Running_AA_Enable:get() then
        Running_AA_Modifier()
    elseif GetState() == "Crouching" and Main.Items.Crouching_AA_Enable:get() then
        Crouching_AA_Modifier()
    elseif GetState() == "In Air" and Main.Items.In_Air_AA_Enable:get() then
        In_Air_AA_Modifier()
    elseif GetState() == "In Air + Crouching" and Main.Items.In_Air_AC_AA_Enable:get() then
        In_Air_AC_AA_Modifier()
    end

    Global_AA_Modifier(
        (GetState() == "Running" and Main.Items.Running_AA_Enable:get())or
        (GetState() == "Standing" and Main.Items.Standing_AA_Enable:get())or
        (GetState() == "Crouching" and Main.Items.Crouching_AA_Enable:get())or
        (GetState() == "In Air" and Main.Items.In_Air_AA_Enable:get())or
        (GetState() == "Walking" and Main.Items.Walking_AA_Enable:get()) or
        (GetState() == "In Air + Crouching" and Main.Items.In_Air_AC_AA_Enable:get())
    )
    
    Fake_Lag_AA_Modifier()
end

for i,v in pairs(Main.Items) do
    if string.find(i, "_AA_") and not string.find(i, "AA_Enable") then
        v:visibility(false)
    end
end

Main.Items.Build_AA:set_callback(function()
    Visisbility_AntiAim(Main.Items.Build_AA:get())
end)

Chose_Options:set_callback(function()
    -- Visisbility_AntiAim(Main.Items.Build_AA:get())
    -- local Visible = false

    Main.Items.Global_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="Global")
    Main.Items.Standing_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="Standing")
    Main.Items.Walking_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="Walking")
    Main.Items.Running_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="Running")
    Main.Items.Crouching_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="Crouching")
    Main.Items.In_Air_AC_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="In Air + Crouching")
    Main.Items.In_Air_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="In Air")
    Main.Items.Fake_Lag_AA_Enable:visibility(Main.Items.Build_AA:get() and TurnTalbe(Chose_Options:get())=="Fake Lag")

    extasy_global(TurnTalbe(Chose_Options:get()))

    -- for i,v in pairs(Main.Items) do
    --     if string.find(i, "Walking_AA_Enabled") then
    --         v:visibility(TurnTalbe(Chose_Options:get()) == "Walking" and Main.Items.Build_AA:get())
    --     end
    -- end
end)

-- Main.Items.Defensive = Main.Tabs.AntiAim:switch("Defensive Anti-Aim")

-- local pitch_settings = Access_add("pitch_settings", "DefAA", Main.Tabs.AntiAim:combo("pitch settings", {"Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false))
-- local yaw_settings = Access_add("yaw_settings", "DefAA", Main.Tabs.AntiAim:combo("yaw settings", {"Static", 'Random', "Side-Way", "Spin"}):visibility(false))
-- local SpinSpeed = Access_add("SpinSpeed", "DefAA", Main.Tabs.AntiAim:slider("Spin Speed", 0, 1000, 0, 1):visibility(false))

Main.Items.randomize = Main.Tabs.Ragebot:switch("Randomize DT"):tooltip("The More you turn up max the more it gets randomized")
Main.Items.Max = Main.Items.randomize:create():slider("Max", 0, 10, 0, 1)
Main.Items.Min = Main.Items.randomize:create():slider("Min", 0, 10, 0, 1)

Main.Items.Watermark = Main.Tabs.Misc:switch("Watermark"):tooltip("Turns on the custom watermark")

Main.Items.WatermarkColor = Main.Items.Watermark:create():color_picker("Watermark Color", {
	["Normal"] = {
		color(255, 255, 255, 0)
	}
})

Main.Items.CE = Main.Tabs.Misc:switch("Croshiar Events")

Main.Items.CScope = Main.Tabs.Scope:switch("Custom Scope")

local AlwaysOn = Access_add("AlwaysOn", "CustScope", Main.Tabs.Scope:switch("Always On"):visibility(false))
local line_length = Access_add("line_length", "CustScope", Main.Tabs.Scope:slider("Line Length", -1000, 1000, 50, 0.5):visibility(false))
local gap_size = Access_add("gap_size", "CustScope", Main.Tabs.Scope:slider("Gap Size", -200, 200, 60, 1):visibility(false))
local fade_steps = Access_add("fade_steps", "CustScope", Main.Tabs.Scope:slider("Fade Alpha", 0, 255, 10, 1):visibility(false))
local CScopeColor = Access_add("CScopeColor", "CustScope", Main.Tabs.Scope:color_picker("Scope Color", {["Normal"] = {color(255, 255, 255, 255)}}):visibility(false))
local Top_Bottom_lines = Access_add("Top_Bottom_lines", "CustScope", Main.Tabs.Scope:switch("Top/Bottom Lines"):visibility(false))
local Right_Left_lines = Access_add("Right_Left_lines", "CustScope", Main.Tabs.Scope:switch("Right/Lift Lines"):visibility(false))
local Rounding = Access_add("Rounding", "CustScope", Main.Tabs.Scope:slider("Rounding", 0, 20, 2, 1):visibility(false))

Main.Items.no_fall_damage = Main.Tabs.Misc:switch('No Fall Damage')
Main.Items.fix_nade = Main.Tabs.Misc:switch('fix nade')
Main.Items.fastladder = Main.Tabs.Misc:switch('fast ladder')
Main.Items.Clantag = Main.Tabs.Misc:switch('Clan Tag')
Main.Items.Clantag_Tag = Main.Tabs.Misc:combo('Tag', {
    "Mango",
    "gamesense"
})

Main.Items.Aspect_Ratio = Main.Tabs.Misc:slider("Aspect Ratio", 0, 60, 0, 1)

local function fix_nade()
    if not Main.Items.fix_nade:get() then return end
    local lp = entity.get_local_player()
    if not (lp or lp:is_alive()) then return end
    rage.exploit:allow_defensive(true)
    local selected = lp:get_player_weapon()
    if selected == nil then return end
    local wpn = selected:get_classname()
    if string.match(wpn, "Grenade") then
        rage.exploit:allow_defensive(false)
    end
end

local function fix_fakeduck()
    if not ui.find("Aimbot", "Anti Aim", "Misc", "Fake Duck"):get() then return end
    ui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit"):override(14)
end

local function no_fall_damage(cmd)
    if not Main.Items.no_fall_damage:get() then return end
    local lp = entity.get_local_player()
    if lp == nil then return end
    local origin = lp:get_origin()
    if lp.m_vecVelocity.z <= -500 then
        if utils.trace_line(vector(origin.x,origin.y,origin.z),vector(origin.x,origin.y,origin.z - 15)).fraction ~= 1 then
            cmd.in_duck = 0
        elseif utils.trace_line(vector(origin.x,origin.y,origin.z),vector(origin.x,origin.y,origin.z - 50)).fraction ~= 1 then
            cmd.in_duck = 1
        end
    end
end

local function fastladder(cmd)
    if not Main.Items.fastladder:get() then return end
    local lp = entity.get_local_player()
    if not lp then return end
    if lp["m_MoveType"] == 9 then
        if cmd.sidemove == 0 then
            cmd.view_angles.y = cmd.view_angles.y + 45
        end
        if cmd.sidemove < 0 and cmd.in_forward then
            cmd.view_angles.y = cmd.view_angles.y + 90
        end
        if cmd.sidemove > 0 and cmd.in_back then
            cmd.view_angles.y = cmd.view_angles.y + 90
        end
        cmd.in_moveleft = cmd.in_back
        cmd.in_moveright = cmd.in_forward
        if cmd.view_angles.x < 0 then
            cmd.view_angles.x = -45
        end
    end
end

local Gamesense_tag = {
    [1] = function() return "gamesense" end,
    [2] = function() return "amesense " end,
    [3] = function() return "mesense  " end,
	[4] = function() return "esense   " end,
	[5] = function() return "sense    " end,
	[6] = function() return "ense     " end,
	[7] = function() return "nse      " end,
	[8] = function() return "se       " end,
	[9] = function() return "e        " end,
	[10] = function() return "         " end,
	[11] = function() return "        g" end,
	[12] = function() return "       ga" end,
	[13] = function() return "      gam" end,
	[14] = function() return "     game" end,
	[15] = function() return "    games" end,
	[16] = function() return "   gamese" end,
	[17] = function() return "  gamesen" end,
	[18] = function() return " gamesens" end,
	[19] = function() return "gamesense" end,
	[20] = function() return "gamesense" end,
	[21] = function() return "gamesense" end,
	[22] = function() return "gamesense" end,
	[23] = function() return "gamesense" end,
	[24] = function() return "gamesense" end,
	[25] = function() return "gamesense" end,
	[26] = function() return "gamesense" end,
	[27] = function() return "gamesense" end,
	[28] = function() return "gamesense" end
}

local Mango_tag = {
    [1] = function() return "Mango" end,
    [2] = function() return "ango " end,
    [3] = function() return "ngo  " end,
	[4] = function() return "go   " end,
	[5] = function() return "o    " end,
	[6] = function() return "         " end,
	[10] = function() return "    M" end,
	[11] = function() return "   Ma" end,
	[12] = function() return "  Man" end,
	[13] = function() return " Mang" end,
	[14] = function() return "Mango" end,
}

local timing_switch = 20

local frametime = 0
local fps = 0
local cur_mode = 0
local timing = timing_switch

local function hk_create_move(cmd)
    timing = timing + 1
end

local function Clan_tag(cmd)
    if entity.get_local_player() == nil then return end
    if not Main.Items.Clantag:get() then return end

    frametime = 0.9 * frametime + (1.0 - 0.9) * frametime
    fps = math.floor((1.0 / frametime) + 0.5)
    
    if timing >= timing_switch then
        cur_mode = cur_mode + 1
        if Main.Items.Clantag_Tag:get() == "gamesense" then
            if cur_mode > #Gamesense_tag then
                cur_mode = 1
            end
            
            common.set_clan_tag(Gamesense_tag[cur_mode]())
            timing = 0
        elseif Main.Items.Clantag_Tag:get() == "Mango" then
            if cur_mode > #Mango_tag then
                cur_mode = 1
            end
            
            common.set_clan_tag(Mango_tag[cur_mode]())
            timing = 0
        end
    end
    
end

Main.Items.Clantag:set_callback(function()
    common.set_clan_tag("")
end)

Main.Items.Support_Me = Main.Tabs.KillSay:switch('Support Me')
Main.Items.n1_one = Main.Tabs.KillSay:switch('1') -- Custom on kill
Main.Items.Custom_Kill = Main.Tabs.KillSay:switch('Custom on kill')

local Inp1 = Access_add("Inp1", "CustKillsay", Main.Tabs.KillSay:input("Inp 1", "neverlose.cc/market/item?id=LMaW6X"):visibility(false))
local Inp2 = Access_add("Inp2", "CustKillsay", Main.Tabs.KillSay:input("Inp 2", "Get"..Main.script_db.lua_name.."neverlose.cc/market/item?id=LMaW6X"):visibility(false))
local Inp3 = Access_add("Inp3", "CustKillsay", Main.Tabs.KillSay:input("Inp 3", "L Bozo"):visibility(false))

local Support_Table = {
    "Howdy %s get good get neverlose.cc/market/item?id=LMaW6X",
    "dang should have gotten "..Main.script_db.lua_name.."!",
    "Cum in my baby making chamber and fill me up!"
}

local n1_table = {
    "1"
}


local function Visibility_easy()
    for i,v in pairs(Main.Items) do
        if string.find(i, "DefAA") then
            v:visibility(Main.Items.Defensive:get())
        elseif string.find(i, "CustScope") then
            v:visibility(Main.Items.CScope:get())
        elseif string.find(i, "CustKillsay") then
            v:visibility(Main.Items.Custom_Kill:get())
        elseif string.find(i, "AA_options") then
            v:visibility(Main.Items.Build_AA:get())
        end
    end
end


Main.visuals.base_render = {
    box = function(x,y,w,h,color,rounding)
        render.rect_outline(vector(x,y), vector(x+w,y+h), color, 1, rounding == nil and 0 or rounding, false)
    end,
    box_filled = function(x,y,w,h,color,rounding)
        render.rect(vector(x,y), vector(x+w,y+h), color, rounding == nil and 0 or rounding, false)
    end,
    gradient_box_filled = function(x,y,w,h,horizontal,color,color2)
        render.gradient(vector(x,y), vector(x+w,y+h), color, color, horizontal and color2 or color, horizontal and color or color2, 0)
    end,
    string = function(x,y,cen,string,color,TYPE,font,fontsize)
        if TYPE == 0 then
            render.text(font, vector(x,y), color, cen and 'c' or '', string)
        elseif TYPE == 1 then
            render.text(font, vector(x,y), color, cen and 'c' or '', string)
        elseif TYPE == 2 then
            render.text(font, vector(x,y), color, cen and 'c' or '', string)
        end
    end,
    circle = function(x,y,rad,start,endd,color,seg,th)
        render.circle_outline(vector(x,y), color, rad, start, endd, th)
    end,
    text_size = function(string,font,fontsize)
        return render.measure_text(font, '', string)
    end
}

Main.visuals.global_render = {
    box = function(x, y, w, colorref, rounding)
        Main.visuals.base_render.box_filled(x,y+2,w,20,color(17,17,17,120*(180)/255),rounding)
        Main.visuals.base_render.box_filled(x+3,y+1,w-6,1,color(colorref.r,colorref.g,colorref.b,colorref.a))
        Main.visuals.base_render.circle(x+3,y+4,3,180,0.25,color(colorref.r,colorref.g,colorref.b,colorref.a),75,1)
        Main.visuals.base_render.circle(x+w-3,y+4,3,-90,0.25,color(colorref.r,colorref.g,colorref.b,colorref.a),75,1)
        Main.visuals.base_render.gradient_box_filled(x,y+4,1,12,false,color(colorref.r,colorref.g,colorref.b,colorref.a),color(colorref.r,colorref.g,colorref.b,0))
        Main.visuals.base_render.gradient_box_filled(x+w-1,y+4,1,12,false,color(colorref.r,colorref.g,colorref.b,colorref.a),color(colorref.r,colorref.g,colorref.b,0))
    end
}

local canShowText = false

local function Watermark(cmd)
    -- Determine whether the watermark should be visible
    local isVisible = Main.Items.Watermark:get()

    -- Initialize animation state if it doesn't exist
    if not Main.animation_state then
        Main.animation_state = {
            startTime = globals.curtime,
            duration = 0.5,       -- Duration of the animation in seconds
            isAnimating = false,
            isVisible = false,  -- Current visibility status of the watermark
            currentWidth = 0,
            Alpha = 0,
            StartAlpha = 20
        }
    end

    local color_ref = Main.Items.WatermarkColor:get()

    -- Trigger animation when visibility changes
    if isVisible ~= Main.animation_state.isVisible then
        Main.animation_state.isAnimating = true
        Main.animation_state.startTime = globals.curtime
        Main.animation_state.isVisible = isVisible
    end

    if not isVisible and Main.animation_state.isAnimating == false then
        return
    end

    -- Build the watermark text
    local text = ''
    local username = Main.script_db.username
    text = text .. Main.helpers.RGBToColorString(Main.script_db.lua_name, color(130, 95, 208, 255)) .. ' [ ' .. Main.helpers.RGBToColorString(Main.script_db.lua_version, color(246, 42, 239, 255)) .. ' ] | ' .. Main.helpers.RGBToColorString(username, color(42, 189, 246, 255)) .. ' | '

    local local_time = common.get_system_time()
    local time = string.format("%02d:%02d:%02d", local_time.hours, local_time.minutes, local_time.seconds)
    local ping = globals.is_in_game and math.floor(utils.net_channel().avg_latency[1] * 1000) or 0
    text = text .. 'delay: ' .. ping .. 'ms | ' .. time

    -- Measure the text size
    local text_size = render.measure_text(1, '', text)
    
    -- Set the desired length of the watermark in pixels (assume 5cm is about 200 pixels, depending on your screen resolution)
    local desiredWidth = math.max(text_size.x + 10, 200)

    -- If animating, update the current width
    if Main.animation_state.isAnimating then
        canShowText = false
        local elapsedTime = globals.curtime - Main.animation_state.startTime

        -- Calculate the target width based on visibility
        local startWidth = Main.animation_state.isVisible and 0 or Main.animation_state.currentWidth
        local endWidth = Main.animation_state.isVisible and desiredWidth or 0

        -- Animate the width using outQuad
        Main.animation_state.currentWidth = easing:outQuad(elapsedTime, startWidth, endWidth - startWidth, Main.animation_state.duration)
        -- wait(30, function()
            Alpha = easing:outQuad(elapsedTime, Main.animation_state.StartAlpha, color_ref.a - Main.animation_state.StartAlpha, Main.animation_state.duration)
        -- end)
        -- Clamp the width and stop animating when the animation is complete
        if elapsedTime >= Main.animation_state.duration then
            Main.animation_state.currentWidth = endWidth
            Main.animation_state.isAnimating = false
        end
    end

    -- If the watermark is not supposed to be visible and the animation is complete, return
    if not Main.animation_state.isVisible and not Main.animation_state.isAnimating then
        return
    end

    wait({
        time = 30,
        flag = "canShowText",
        Number = 0.1,
        callback = function()
            canShowText = true
        end
    })

    -- Continue with rendering
    local pos = { x = render.screen_size().x - Main.animation_state.currentWidth - 10, y = 10, w = Main.animation_state.currentWidth, h = 16 }

    Main.visuals.global_render.box(pos.x, pos.y, pos.w, { r = color_ref.r, g = color_ref.g, b = color_ref.b, a = color_ref.a }, 2)
    if canShowText then
        Main.visuals.base_render.string(pos.x + 6, pos.y + pos.h / 2 - 0.1, false, text, color(color_ref.r, color_ref.g, color_ref.b, Alpha), 0, 1, 1)
    end
end

local Exploit = 0

local function Visuals_Createmove()
    Exploit = rage.exploit:get()
end

local function Visuals_Indicator()
    if not Main.Items.CE:get() then return end
    local localplayer = entity.get_local_player()
    local screen_size = Main.helpers.screen_size
    local DoubleTap = ui.find("Aimbot", "Ragebot", "Main", "Double Tap"):get()
    local HS = ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"):get()
    local FD = ui.find("Aimbot", "Anti Aim", "Misc", "Fake Duck"):get()

    local text_size = render.measure_text(1, '', text)

    local Text = {
        DT = "DT: ",
        OnShot = "On Shot"
    }

    local pos = {
        x = (screen_size.x / 2) - (text_size.x / 2),
        y = (screen_size.y / 2) - (text_size.y / 2),
        w = text_size.x,
        h = text_size.y
    }

    local offset = {
        x = -20,  -- Horizontal offset (positive moves right, negative moves left)
        y = 20   -- Vertical offset (positive moves down, negative moves up)
    }
    
    pos.x = pos.x + offset.x
    pos.y = pos.y + offset.y

    local DTX, DTY = 10, 22

    Main.visuals.base_render.string(pos.x, pos.y - 3, false, GetState(), color(67,95,216,255), 1, 1)
    
    if DoubleTap then
        if Exploit == 1 then
            Main.visuals.base_render.string(pos.x, pos.y+DTX, false, Text.DT.."Ready", color(0,255,0,170), 1, 1)
        else
            Main.visuals.base_render.string(pos.x, pos.y+DTX, false, Text.DT.."Not Ready", color(255,0,0,170), 1, 1)
        end
    end

    if HS then
        if DoubleTap then
            Main.visuals.base_render.string(pos.x, pos.y + DTY, false, Text.OnShot, color(14,155,195,255), 1, 1)
        else
            Main.visuals.base_render.string(pos.x, pos.y, false, Text.OnShot, color(14,155,195,255), 1, 1)
        end
    end
-- GetState()
    if FD then
        Main.visuals.base_render.string(pos.x - 5, pos.y - 40, false, "FD", color(222,129,24,255), 1, 1)
    end


    pcall(function()
        local wpn = Main.helpers.GetWeapon()

        if wpn ~= nil then
            local damage = ui.find("Aimbot", "Ragebot", "Selection", wpn, "Min. Damage"):get()
            if damage == 0 then
                damage = "auto"
            end
        
            Main.visuals.base_render.string(pos.x + 40, pos.y - 40, false, tostring(damage), color(14,155,195,255), 1, 1)
        end
    end)

end
 
local function Randomize_DT_Ticks(cmd)
    if not Main.Items.randomize:get() then return end
    if Main.Items.Min:get() > Main.Items.Max:get() then
        Main.Items.Max:set(Main.Items.Min:get())
    end
    ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Fake Lag Limit"):override(math.random(Main.Items.Min:get(), Main.Items.Max:get()))
end

-- local function defensive_aa(cmd)
--     -- if ui.find("Scripts", "Flux Yaw", "🔰 Anti-Aim", "Main", "Freestanding"):get() then return end
--     local exploit_state = rage.exploit:get() -- Defensive need always lag
    
--     local localplayer = entity.get_local_player()
--     if not localplayer then return end

--     local pitch_settings = pitch_settings:get()
--     local yaw_settings = yaw_settings:get()
--     local Spin_Speed = SpinSpeed:get()
    
--     if (Main.Items.Defensive:get()) then
--         -- ui.find("Aimbot", "Anti Aim", "Angles", "Pitch"):override("Disabled")
--         local prop = localplayer["m_fFlags"]
--         local pitch_override = 0
--         local yaw_override = 0
        
--         if pitch_settings == "Zero" then
--             pitch_override = 0
--         elseif pitch_settings == "Up" then
--             pitch_override = -89
--         elseif pitch_settings == "Down" then
--             pitch_override = 89
--         elseif pitch_settings == "Random" then
--             pitch_override = math.random(-89,89)
--         elseif pitch_settings == "Jitter" then
--             if (math.floor(globals.curtime * 100000) % 2) == 0 then
--                 pitch_override = 89
--             else
--                 pitch_override = -89
--             end
--         elseif pitch_settings == "45 Deg" then
--             if (math.floor(globals.curtime * 10000) % 2) == 0 then
--                 pitch_override = 45
--             else
--                 pitch_override = -45
--             end
--         end
--         if yaw_settings == "Static" then
--             yaw_override = 0
--         elseif yaw_settings == "Random" then
--             yaw_override = math.random(-179,179)
--         elseif yaw_settings == "Side-Way" then
--             if (math.floor(globals.curtime * 100000) % 2) == 0 then
--                 yaw_override = 89
--             else
--                 yaw_override = -90
--             end
--         elseif yaw_settings == "Spin" then
--             yaw_override = (globals.curtime * Spin_Speed) % 360 - 180
--         end
        
--         if exploit_state ~= 0 then -- GetSelectedWeapons(csgo_weapons(localplayer:get_player_weapon()).name, menu.Standing_Weapons)
--             rage.antiaim:override_hidden_pitch(pitch_override)
--             rage.antiaim:override_hidden_yaw_offset(yaw_override)
--             Main.Main_Anti_Defensive.main.lag_options:override("Always On")
--             rage.exploit:allow_defensive(true)
--         end
--     else
--         -- ui.find("Aimbot", "Anti Aim", "Angles", "Pitch"):override()
--         Main.Main_Anti_Defensive.main.hidden:override()
--         Main.Main_Anti_Defensive.main.fs:override()
--         Main.Main_Anti_Defensive.main.lag_options:override()
--         rage.exploit:allow_defensive(false)
--     end
-- end



local width, height = render.screen_size().x, render.screen_size().y

local function PlayerZoomed()
    local plr = entity.get_local_player()

    if plr == nil then return false end

    local weapon = plr:get_player_weapon()

    if plr.m_iHealth > 0 then
        if weapon ~= nil then
            local weapon_info = weapon:get_weapon_info()

            if weapon_info ~= nil then
                local scoped = plr.m_bIsScoped
                if scoped then
                    return true
                end
            end
        end
    end
    
    return false
end

local function clamp(v, min, max) local num = v; num = num < min and min or num; num = num > max and max or num; return num end
local function linear(t, b, c, d) return c * t / d + b end
local m_alpha = 0

local function draw_scope_lines()

    if not Main.Items.CScope:get() then return end

    local is_zoomed = PlayerZoomed()

    if not AlwaysOn:get() then
        if not is_zoomed then
            return
        end
    end

    ui.find("Visuals", "World", "Main", "Override Zoom", "Scope Overlay"):override("Remove All")

    local x_center = width / 2
    local y_center = height / 2

    local offset = line_length:get() 
    local gap_size = gap_size:get() 
    local fade_steps = fade_steps:get() 

    local max_alpha = 255

    local base_color = CScopeColor:get()

    if Right_Left_lines:get() then
        render.gradient(
            vector(width / 2 - gap_size - offset, height / 2 - 1, 0),
            vector(width / 2 - gap_size + offset, height / 2 + 1, 0),
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),   -- top-left
            color(base_color.r, base_color.g, base_color.b, 0),                 -- top-right
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),   -- bottom-left
            color(base_color.r, base_color.g, base_color.b, 0),                  -- bottom-right
            Rounding:get()
        )
        
        -- Right gradient rectangle
        render.gradient(
            vector(width / 2 + gap_size - offset, height / 2 - 1, 0),
            vector(width / 2 + gap_size + offset, height / 2 + 1, 0),
            color(base_color.r, base_color.g, base_color.b, 0),                 -- top-left
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),   -- top-right
            color(base_color.r, base_color.g, base_color.b, 0),                 -- bottom-left
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),    -- bottom-right
            Rounding:get()
        )
    end


    if Top_Bottom_lines:get() then
        -- Top gradient rectangle
        render.gradient(
            vector(width / 2 - 1, height / 2 - gap_size - offset, 0),
            vector(width / 2 + 1, height / 2 - gap_size + offset, 0),
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),   -- top-left
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),   -- top-right
            color(base_color.r, base_color.g, base_color.b, 0),                 -- bottom-left
            color(base_color.r, base_color.g, base_color.b, 0),                  -- bottom-right
            Rounding:get()
        )
        
        -- Bottom gradient rectangle
        render.gradient(
            vector(width / 2 - 1, height / 2 + gap_size - offset, 0),
            vector(width / 2 + 1, height / 2 + gap_size + offset, 0),
            color(base_color.r, base_color.g, base_color.b, 0),                 -- top-left
            color(base_color.r, base_color.g, base_color.b, 0),                 -- top-right
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),   -- bottom-left
            color(base_color.r, base_color.g, base_color.b, max_alpha - fade_steps),    -- bottom-right
            Rounding:get()
        )
    end

end


if not _G.Sesion_Time then
    _G.Sesion_Time = 0
end

Setup_welcome:label("Welcome, "..Main.helpers.RGBToColorString(Main.script_db.username, color(130, 95, 208, 255)).. "!") --\aA9ACFFFF
Setup_welcome:label(Main.script_db.lua_name.." "..Main.helpers.RGBToColorString(Main.script_db.lua_version, color(130, 95, 208, 255)).. " Live Build")
local SesionTime = Setup_welcome:label("Session Time: ".._G.Sesion_Time.. " ")

local function Update_SesionTime()
    wait({
        time=1,
        flag="SesionTime",
        Number=0.008,
        callback = function()
            _G.Sesion_Time = _G.Sesion_Time + 1
            SesionTime:name("Sesion Time: ".._G.Sesion_Time.. " ")
        end
    })

end

-- local DDS = Setup_welcome:button("       Discord       ")

-- DDS:set_callback(function()
--     clipboard.set("https://discord.gg/qq6WgyMwkw")
-- end, false)


local Reloade_Script = Setup_welcome:button("                 Force Full Update                 ")
Reloade_Script:set_callback(function()
    common.reload_script()
    common.force_full_update()
end, false)


local Configs = cfgsys:list("Configs", {})
Configs:set_callback(function()
    Configs:update(json.parse(files.read(Config_Data)))
end, true)

local CFG_Name = cfgsys:input(ui.get_icon('input-text').."  Config Name", "")
local CFG_create = cfgsys:button(ui.get_icon('layer-plus').."     Create Config     ")
local confirm_cfg_creation = cfgsys:button(" Confirm CFG "):visibility(false)

local CFG_Data_Switch = cfgsys:switch("Load Clean"):visibility(false)

local CFG_load = cfgsys:button(ui.get_icon('check').."     Load Config     ")
local CFG_save = cfgsys:button(ui.get_icon('floppy-disk').."      Save Config      ")
local export_cfg = cfgsys:button(ui.get_icon('upload').."   Export Config    ")
local import_cfg = cfgsys:button(ui.get_icon('download').."  Import Config   ")

local CFG_delete = cfgsys:button(ui.get_icon('trash'))
local CFG_ConfirmDeletion_Yes = cfgsys:button(ui.get_icon('check')):visibility(false)
local CFG_ConfirmDeletion_No = cfgsys:button(" X "):visibility(false)


local function decode(data)
    return Base64:decode(data)
end

local function encode(data)
    return Base64:encode(data)
end


local Base64_Decode = cfgsys:button(ui.get_icon('code')):tooltip('Decode')
local Base64_Encode = cfgsys:button(ui.get_icon('upload')):tooltip('Encode')

Base64_Decode:set_callback(function()
clipboard.set(decode(clipboard.get()))
common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), "Successfully Decoded!")
end, false)

Base64_Encode:set_callback(function()
clipboard.set(encode(clipboard.get()))
common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), "Successfully encoded!")
end, false)

CFG_delete:set_callback(function()
CFG_ConfirmDeletion_Yes:visibility(true)
CFG_ConfirmDeletion_No:visibility(true)
end)

function GetCFGS(id)
    local RTAble = nil
    for i,v in pairs(json.parse(files.read(Config_Data))) do
        if i == id then
            return tostring(v)
        end
    end
    return tostring(RTAble)
end

local function GetCFG()
    clipboard.set(files.read(Configs_Path.."\\"..GetCFGS(Configs:get())..".lua"))
end

function config_load(text, is_import, CFN)
    local CFN = CFN or ''
    local is_import = is_import or false
    local config_load_func = {}
    local startsWithFlux = string.match(text, "^Flux_") ~= nil
    if startsWithFlux then
        config_load_func.state = true
    else
        config_load_func.state = false
        common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), "Something went wrong!")
    end

    if config_load_func.state then
            if is_import == true then
                common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), " New Config Has been imported to "..Main.helpers.RGBToColorString(GetCFGS(Configs:get()), color(122,122,255,255)))
            elseif is_import == 'NONE' then
                common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), Main.helpers.RGBToColorString(CFN, color(122,122,255,255)).." New Config!")
            elseif is_import == false then
                common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), Main.helpers.RGBToColorString(GetCFGS(Configs:get()), color(122,122,255,255)).." has been Loaded!")
            end
        local text = decode(text:gsub("Flux_", ""))
        local cfg_data = json.parse(text)
        if cfg_data ~= nil then
            for key, value in pairs(cfg_data) do
                local item = Main.Items[key]
                if item ~= nil then
                    local invalue = value
                    item:set(invalue)
                end
            end
        end
    end
    return config_load_func
end

local Clean_Cfg = [[Flux_-- Obfuscated by Mana64 

return function() eyIxIjpmYWxzZSwiQWNjZW50IjoiOEVBNUU1RkYiLCJBbnRpX0JydXRlZm9yY2UiOmZhbHNlLCJBc3BlY3QgUmF0aW8iOmZhbHNlLCJCZXR0ZXIgRFQiOltdLCJCb2R5RnJlZXN0YW5kaW5nIjpmYWxzZSwiQ2xhbiBUYWciOmZhbHNlLCJDbGFuIFRhZyBTcGVlZCI6MC4wLCJDb25kaXRpb24gQUEiOiJHbG9iYWwiLCJDcm91Y2hpbmcgRXh0ZW5kZWQgQW5nZWxzIjpmYWxzZSwiQ3JvdWNoaW5nIEV4dGVuZGVkIFBpdGNoIjowLjAsIkNyb3VjaGluZyBFeHRlbmRlZCBSb2xsIjowLjAsIkNyb3VjaGluZyBMZWZ0IExpbWl0IjowLjAsIkNyb3VjaGluZyBPZmZzZXQiOjAuMCwiQ3JvdWNoaW5nIE9wdGlvbnMiOltdLCJDcm91Y2hpbmcgUmlnaHQgTGltaXQiOjAuMCwiQ3JvdWNoaW5nIFRpbWUgU3dpdGNoIjowLjAsIkNyb3VjaGluZyBZYXcgQWRkIC0gTGVmdCI6MC4wLCJDcm91Y2hpbmcgWWF3IEFkZCAtIFJpZ2h0IjowLjAsIkNyb3VjaGluZyBZYXcgQWRkIFR5cGUiOiJTdGF0aWMiLCJDcm91Y2hpbmcgWWF3IE1vZGlmaWVyIjoiRGlzYWJsZWQiLCJDcm91Y2hpbmdfRGVmZW5zaXZlIEFudGkgQWltIjpmYWxzZSwiQ3JvdWNoaW5nX1dlYXBvbnMiOltdLCJDcm91Y2hpbmdfcGl0Y2giOiJaZXJvIiwiQ3JvdWNoaW5nX3NwaW4iOjEyMC4wLCJDcm91Y2hpbmdfeWF3IjoiU3RhdGljIiwiQ3VzdG9tIENsYW4gVGFnIjpmYWxzZSwiQ3VzdG9tIENsYW4gVGV4dCI6IiIsIkN1c3RvbSBTbG93IFdhbGsiOmZhbHNlLCJDdXN0b20gVmlld21vZGVsIjpmYWxzZSwiQ3VzdG9tIG9uIGtpbGwiOmZhbHNlLCJETUMgSGl0Y2hhbmNlIjpmYWxzZSwiRGlzYWJsZVlhd01vZGlmaWVycyI6ZmFsc2UsIkR5bmFtaWMgSGl0Y2hhbmNlIFR5cGUiOiJkZWZlbnNpdmUiLCJFbmFibGUgQW50aSBBaW0iOmZhbHNlLCJFbmFibGUgQ3JvdWNoaW5nIjpmYWxzZSwiRW5hYmxlIEluIEFpciI6ZmFsc2UsIkVuYWJsZSBSdW5uaW5nIjpmYWxzZSwiRW5hYmxlIFN0YW5kaW5nIjpmYWxzZSwiRW5hYmxlIFdhbGtpbmciOmZhbHNlLCJGb3YiOjkwLjAsIkZyZWVzdGFuZGluZyI6ZmFsc2UsIkZyZWVzdGFuZGluZyBTdGF0aWMiOmZhbHNlLCJHbG9iYWwgRXh0ZW5kZWQgQW5nZWxzIjpmYWxzZSwiR2xvYmFsIEV4dGVuZGVkIFBpdGNoIjowLjAsIkdsb2JhbCBFeHRlbmRlZCBSb2xsIjowLjAsIkdsb2JhbCBMZWZ0IExpbWl0IjowLjAsIkdsb2JhbCBPZmZzZXQiOjAuMCwiR2xvYmFsIE9wdGlvbnMiOltdLCJHbG9iYWwgUmlnaHQgTGltaXQiOjAuMCwiR2xvYmFsIFRpbWUgU3dpdGNoIjo0LjAsIkdsb2JhbCBZYXcgQWRkIC0gTGVmdCI6MC4wLCJHbG9iYWwgWWF3IEFkZCAtIFJpZ2h0IjowLjAsIkdsb2JhbCBZYXcgQWRkIFR5cGUiOiJTdGF0aWMiLCJHbG9iYWwgWWF3IE1vZGlmaWVyIjoiRGlzYWJsZWQiLCJIaXRsb2dzIjpmYWxzZSwiSW5fQWlyIEV4dGVuZGVkIEFuZ2VscyI6ZmFsc2UsIkluX0FpciBFeHRlbmRlZCBQaXRjaCI6MC4wLCJJbl9BaXIgRXh0ZW5kZWQgUm9sbCI6MC4wLCJJbl9BaXIgTGVmdCBMaW1pdCI6MC4wLCJJbl9BaXIgT2Zmc2V0IjowLjAsIkluX0FpciBPcHRpb25zIjpbXSwiSW5fQWlyIFJpZ2h0IExpbWl0IjowLjAsIkluX0FpciBUaW1lIFN3aXRjaCI6MC4wLCJJbl9BaXIgWWF3IEFkZCAtIExlZnQiOjAuMCwiSW5fQWlyIFlhdyBBZGQgLSBSaWdodCI6MC4wLCJJbl9BaXIgWWF3IEFkZCBUeXBlIjoiU3RhdGljIiwiSW5fQWlyIFlhdyBNb2RpZmllciI6IkRpc2FibGVkIiwiSW5fQWlyX0RlZmVuc2l2ZSBBbnRpIEFpbSI6ZmFsc2UsIkluX0Fpcl9XZWFwb25zIjpbXSwiSW5fQWlyX3BpdGNoIjoiWmVybyIsIkluX0Fpcl9zcGluIjoxMjAuMCwiSW5fQWlyX3lhdyI6IlN0YXRpYyIsIklucCAxIjoibmV2ZXJsb3NlLmNjL21hcmtldC9pdGVtP2lkPUxNYVc2WCIsIklucCAyIjoiR2V0IEZsdXgtWWF3ISBuZXZlcmxvc2UuY2MvbWFya2V0L2l0ZW0/aWQ9TE1hVzZYIiwiSW5wIDMiOiJIb3dkeSBnZXQgMSBpbiB5b3UgYnV0IiwiSnVtcCBTY291dCBGaXgiOmZhbHNlLCJLZXlCaW5kcyI6W10sIkxpbmsgRFQgSGl0Y2hhbmNlIjp0cnVlLCJNYWluIFBpdGNoIjoiRG93biIsIk1heF9CcnV0ZWZvcmNlIjowLjAsIk1pbl9CcnV0ZWZvcmNlIjowLjAsIk5vIEZhbGwgRGFtYWdlIjpmYWxzZSwiUmFuZG8gRmxpY2siOmZhbHNlLCJSYW5kbyBGbGljayBUaW1lIjowLjAsIlJhbmRvbSBGYWtlIExhZyIUmVsYXkgc2hhdCMxNzYgKDEyMS40Ni4yMjUuMTQ6MjcwMjgpIGlzIGdvaW5nIG9mZmxpbmUgaW4gNDgxIHNlY29uZHMNClRlbGxpbmcgU3RlYW0gaXQgaXMgc2FmZSB0byB1cGRhdGUgdGhlIGFwcA0KLS0tIE1pc3NpbmcgVmd1aSBtYXRlcmlhbCB2Z3VpLy4uXHZndWlcbWFwc1xtZW51X3RodW1iX2RlZmF1bHQNCi0tLSBNaXNzaW5nIFZndWkgbWF0ZXJpYWwgdmd1aS8uLlx2Z3VpXG1hcHNcbWVudV90aHVtYl9kZWZhdWx0X2Rvd25sb2FkDQpIb3N0X1dyaXRlQ29uZmlndXJhdGlvbjogV3JvdGUgY2ZnL2NvbmZpZy5jZmcNCi0tLSBNaXNzaW5nIFZndWkgbstring.lowerWF0ZXJpYWwgdmd1aS8uLi92Z3VpL2ljb25fY29uX21lZGl1bS52bXQNClBpbmcgbWVhc3Vio.writeyZW1lbnQgY29tcGxldGVkDQpQaW5nIGxvY2F0aW9uOiBhbXM9MTMrMSxzdG89MTMrMSxzdG8yPTEzKzEsbXN0MT0xNCsxLGZyYT0yMSsyLzE3KzEsbWx4MT0xOstring.upperdebug.getinfoCsxLGxocj0zNCszLzE4KzEsd2F3PTIxKzIscGFyPTM1KzMvMjMrMSxpYWQ9MTAxKzEwLzEwMSsxLHNncD0xOTArMTkvMTkyKzE1LGdydT0yMDUrMjANClNEUiBSZWxheU5ldHdvcmtTdGF0dXM6io.openICBhdmFpbD1PSyAgY29uZmlnPU9LICBhbnlyZWxheT1PSyAgIChPSykNCkNoYW5nZUdhbWVVSVN0Ystring.reverseXRlOiBDU0dPX0dBTUVfVUlfU1RBVEVfSU5Umath.minUk9NT1ZJRSAtPiBDU0dPX0dBTUVfVUlfU1RBVEVfTUFJTk1FTlUNCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiQ1NHT0xvYWRpbmdTY3JlZW4iISBQYW5lbCBpcyBwb3NzaWJseSBjcmVhdGVkIGR5bmFtaWNhbGx5Lg0KQ0NTR09fQmx1clRhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJlb20td2lubmVyIiEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPos.timeX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiaWQtbWFpbm1lbnUtbWlzc2lvbi1jYXJkLWJnIistring.table.unpackrepEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBmath.abswYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiaWQtb3AtbWFpbm1lbnUtdG9wIiEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFstring.gmatchibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiaWQtdG91cm5hbWVudC1wYXNzLXN0YXR1cyIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDQ1NHT19CbHVyVGFyZ2V0IC0gVW5hYmxlIHRvIGZpbmQgcGFuZWwgd2l0aCB0aGUgZ2l2ZW4gaWQgImlkLW9wLW1haW5tZW51LXJld2FyZHMiISBQYW5lbCBpcyBwb3NzaWJseSBjcmVhdGVkIGR5bmFtaWNhbGx5Lg0KQ0NTR09fQmx1clRstring.charhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJpZC1vcC1tYWlubWVudS1taXNzaW9ucyIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDQ1NHT19Cmath.sinbHVyVGFyZ2V0IC0gVW5hYmxlIHRvIGZpbmQgcGFuZWwgd2l0aCB0aGUgZ2l2ZW4gaWQgtable.removeImlkLWFjdGstring.lenl2ZW1pc3Npb24tdG9vbHRpcCIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDQ1NHT19Cbstring.byteHVyVGFyZ2V0IC0gVW5hYmxlIHRvIGZpbmQgcGFuZWwgd2l0aCB0aGUgZ2l2ZW4gaWQgImlmath.sqrtkLWFjdGl2ZS1taXNzaW9uIiEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiQ1NHT0xvYWRpbmdTY3JlZW4iISBQYW5lbCBpcyBwb3NzaWJseSBjcmVhdGVos.datekIGR5bmFtaWNhbGx5Lg0KQ0NTR09fQmx1clRhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJDU0dPTG9hZGluZ1NjcmVlbiIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDZXJ0aWZpY2F0ZSBmath.ceilleHBpcmVzIGluIDIyaDIwbSBhdstring.subCAxNjk1MjkxOTMzICstring.findhjdXJyZW50math.cosIHRpbWUgMTY5NTIxMTmath.floorQ4MyksIHdpbGwgcmVuZXcgaW4gMjBoMjBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIyaDEwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMjA4math.maxMyksIHdpbGwgcmVuZXcgaW4gMjBoMTBtDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzYwOiBhdHRlbXB0IHRvIGluZGV4IGdsb2JhbCAnc2NyaXB0X2RiJyAoYSBuaWwgdmFsdWUpDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzA5OiBhdHRlbXB0IHRvIGluZGV4IGxvY2FsICd3b3JkJyAoYSBudW1iZXIgdmFsdWUpDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIytable.concataDAwbSBhdCAxNjk1MjkxOTMzIChtable.insertjdXJyZW50IHRpbWUgMTY5NTIxMtable.packjY4MyksIHdpbGwgcmVuZXcgaW4gMjBcoroutine.createoMDBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDUwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMzI4MyksIHdpbGwgcmVuZXcgaW4gMTloNTBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDQwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMzg4MyksIHdpbGwgcmVuZXcgaW4gMTloNDBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGstring.formatluIDIxcoroutine.resumeaDMwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxNDQ4MyksIHdpbGwgcmVuZXcgaW4gMTloMzBtDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MjgwOiBiYWQgYXJndW1lbnQgIzIgdG8gJ2Zvcm1hdCcgKG51bWJlciBleHBlY3RlZCwgZ290IHN0cmluZykNCkNlcnRpZmljYXRlIGV4cGlyZXMgaW4gMjFoMjBtIGF0io.readIDE2OTUyOTE5MzMgKGN1cnJlbnQgdGltZSAxNjk1MjE1MDgzKSwgd2lsbCByZW5ldyBpbiAxOWgyMG0NCm5sILcgWyJGbHV4IFlhdyBEZXYiXTozNDQ6IGF0dGVtcHQgdG8gaW5kZXggZ2xvYmFsICdwb3NpdGlvbnMnIChhIG5pbCB2YWx1ZSkNCm5sILcgWyJGbHV4IFlhdyBEZXYiXTozNDc6IGF0dGVtcHQgdG8gcGVyZm9ybSBhcml0aG1ldGljIG9uIGdsb2JhbCAnb2Zmc2V0JyAoYSBuaWwgdmFsdWUpDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzQ4OiBhdHRlbXB0Icoroutine.yieldHRvIHBlcmZvcm0gYXJpdGhtZXRpYyBvbiBsb2NhbCAnb2Zmc2V0JyAoYSBuaWwgdmFsdWUpDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDEwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxNTY4MyksIHdpbGwgcmVuZXcgaW4gMTloMTBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDAwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxNjI4MyksIHdpbGwgcmVuZXcgaW4gmath.tanMTloMDBttable.sort6ZmFsc2UsIlJ1bm5pbmcgRXh0ZW5kZWQgQW5nZWxzIjpmYWxzZSwiUnVubmluZyBFeHRlbmRlZCBQaXRjaCI6MC4wLCJSdW5uaW5nIEV4dGVuZGVkIFJvbGwiOjAuMCwiUnVubmluZyBMZWZ0IExpbWl0IjowLjAsIlJ1bm5pbmcgT2Zmc2V0IjowLjAsIlJ1bm5pbmcgT3B0aW9ucyI6W10sIlJ1bm5pbmcgUmlnaHQgTGltaXQiOjAuMCwiUnVubmluZyBUaW1lIFN3aXRjaCI6MC4wLCJSdW5uaW5nIFlhdyBBZGQgLSBMZWZ0IjowLjAsIlJ1bm5pbmcgWWF3IEFkZCAtIFJpZ2h0IjowLjAsIlJ1bm5pbmcgWWF3IEFkZCBUeXBlIjoiU3RhdGljIiwiUnVubmluZyBZYXcgTW9kaWZpZXIiOiJEaXNhYmxlZCIsIlJ1bm5pbmdfRGVmZW5zaXZlIEFudGkgQWltIjp0cnVlLCJSdW5uaW5nX1dlYXBvbnMiOltdLCJSdW5uaW5nX3BpdGNoIjoiWmVybyIsIlJ1bm5pbmdfc3BpbiI6MTIwLjAsIlJ1bm5pbmdfeWF3IjoiU3RhdGljIiwiU0VMIEJpbmRzX0xvZ3MiOiJGbHV4LVlhdyIsIlN0YW5kaW5nIEV4dGVuZGVkIEFuZ2VscyI6ZmFsc2UsIlN0YW5kaW5nIEV4dGVuZGVkIFBpdGNoIjowLjAsIlN0YW5kaW5nIEV4dGVuZGVkIFJvbGwiOjAuMCwiU3RhbmRpbmcgTGVmdCBMaW1pdCI6MC4wLCJTdGFuZGluZyBPZmZzZXQiOjAuMCwiU3RhbmRpbmcgT3B0aW9ucyI6W10sIlN0YW5kaW5nIFJpZ2h0IExpbWl0IjowLjAsIlN0YW5kaW5nIFRpbWUgU3dpdGNoIjowLjAsIlN0YW5kaW5nIFlhdyBBZGQgLSBMZWZ0IjowLjAsIlN0YW5kaW5nIFlhdyBBZGQgLSBSaWdodCI6MC4wLCJTdGFuZGluZyBZYXcgQWRkIFR5cGUiOiJTdGF0aWMiLCJTdGFuZGluZyBZYXcgTW9kaWZpZXIiOiJEaXNhYmxlZCIsIlN0YW5kaW5nX0RlZmVuc2l2ZSBBbnRpIEFpbSI6dHJ1ZSwiU3RhbmRpbmdfV2VhcG9ucyI6W10sIlN0YW5kaW5nX3BpdGNoIjoiWmVybyIsIlN0YW5kaW5nX3NwaW4gc3BlZWQiOjEyMC4wLCJTdGFuZGluZ195YXciOiJTdGF0aWMiLCJTdGF0ZSI6W10sIlN1cHBvcnQgTWUiOmZhbHNlLCJTd2l0Y2hpbmcgRmFrZWxhZyI6ZmFsc2UsIlRpbWUgUmFuZCI6MC4wLCJUaW1lIFN3aXRjaCI6MC4wLCJWYWx1ZSI6MC4wLCJWYWx1ZTEiOjAuMCwiVmFsdWUyIjowLjAsIldhbGsgU3BlZWQiOjAuMCwiV2Fsa2luZyBFeHRlbmRlZCBBbmdlbHMiOmZhbHNlLCJXYWxraW5nIEV4dGVuZGVkIFBpdGNoIjowLjAsIldhbGtpbmcgRXh0ZW5kZWQgUm9sbCI6MC4wLCJXYWxraW5nIExlZnQgTGltaXQiOjAuMCwiV2Fsa2luZyBPZmZzZXQiOjAuMCwiV2Fsa2luZyBPcHRpb25zIjpbXSwiV2Fsa2luZyBSaWdodCBMaW1pdCI6MC4wLCJXYWxraW5nIFRpbWUgU3dpdGNoIjowLjAsIldhbGtpbmcgWWF3IEFkZCAtIExlZnQiOjAuMCwiV2Fsa2luZyBZYXcgQWRkIC0gUmlnaHQiOjAuMCwiV2Fsa2luZyBZYXcgQWRkIFR5cGUiOiJTdGF0aWMiLCJXYWxraW5nIFlhdyBNb2RpZmllciI6IkRpc2FibGVkIiwiV2Fsa2luZ19EZWZlbnNpdmUgQW50aSBBaW0iOmZhbHNlLCJXYWxraW5nX1dlYXBvbnMiOltdLCJXYWxraW5nX3BpdGNoIjoiWmVybyIsIldhbGtpbmdfc3BpbiI6MTIwLjAsIldhbGtpbmdfeWF3IjoiU3RhdGljIiwiV2F0ZXJtYXJrIjpmYWxzZSwiWCI6MC4wLCJZIjoyLjAsIllhdyBCYXNlIjoiQmFja3dhcmQiLCJaIjowLjAsImZpeCBuYWRlIjpmYWxzZSwibWluIHZhbHVlIjowLjB9 end) 


]]

local function Create_CFG(state)
    local new_data = {}
    local Config_Data_Open = json.parse(files.read(Config_Data))
    for i,v in pairs(Config_Data_Open) do table.insert(new_data, v)end
    table.insert(new_data, CFG_Name:get())
    files.write('nl\\Mango\\configs.json', json.stringify(new_data))

        local cfg_data = {}
        for i, v in pairs(Main.Items) do
            local ui_value = v:get()
            if type(ui_value) == "userdata" then
                cfg_data[i] = ui_value:to_hex()
            else
                cfg_data[i] = ui_value
            end
        end
        
    if state == false then
        local json_config = json.stringify(cfg_data)
        local encoded_config = encode(json_config)
        files.write(Configs_Path.."\\"..CFG_Name:get()..".lua", "Flux_"..encoded_config)
    else
        -- local json_config = json.stringify(cfg_data)
        -- local encoded_config = encode(json_config)
        files.write(Configs_Path.."\\"..CFG_Name:get()..".lua", Clean_Cfg)
        config_load(files.read(Configs_Path.."\\"..CFG_Name:get()..".lua"), 'NONE', CFG_Name:get())
    end
    Configs:update(json.parse(files.read(Config_Data)))
    CFG_Name:set("")
end

CFG_create:set_callback(function()
    confirm_cfg_creation:visibility(true)
    CFG_Data_Switch:visibility(true)
end, false)

confirm_cfg_creation:set_callback(function()
    confirm_cfg_creation:visibility(false)
    CFG_Data_Switch:visibility(false)
    Create_CFG(CFG_Data_Switch:get())
end, false)

local function config_save()
    local cfg_data = {}
    for i, v in pairs(Main.Items) do
        local ui_value = v:get()
        if type(ui_value) == "userdata" then
            cfg_data[i] = ui_value:to_hex()
        else
            cfg_data[i] = ui_value
        end
    end

    local json_config = json.stringify(cfg_data)
    local encoded_config = encode(json_config)
    files.write(Configs_Path.."\\"..GetCFGS(Configs:get())..".lua", "Flux_"..encoded_config)
    Configs:update(json.parse(files.read(Config_Data)))
    common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), "Saved Config to "..Main.helpers.RGBToColorString(GetCFGS(Configs:get()), color(122,122,255,255)))
end

CFG_load:set_callback(function()
    config_load(files.read(Configs_Path.."\\"..GetCFGS(Configs:get())..".lua"))
end)

CFG_save:set_callback(function()
    config_save()
end)

import_cfg:set_callback(function()
    config_load(clipboard.get(), true)
end)

export_cfg:set_callback(function()
    GetCFG()
    common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), Main.helpers.RGBToColorString(GetCFGS(Configs:get()), color(122,122,255,255)).." has been Copied to clipboard!")
end)

CFG_ConfirmDeletion_Yes:set_callback(function()
    CFG_ConfirmDeletion_Yes:visibility(false)
    CFG_ConfirmDeletion_No:visibility(false)

    local Config_Data_Open = json.parse(files.read(Config_Data))

    local dataToRemove = GetCFGS(Configs:get())

    local function remove(jsonArray, itemToRemove)
        for i, item in ipairs(jsonArray) do
            if item == itemToRemove then
                table.remove(jsonArray, i)
                return true
            end
        end
        return false
    end
    if remove(Config_Data_Open, dataToRemove) then
        local updatedData = json.stringify(Config_Data_Open)
        files.write(Config_Data, updatedData)
        common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), "Deleted "..GetCFGS(Configs:get()))
    else
        common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), "There is no such config!")
    end
    Configs:update(json.parse(files.read(Config_Data)))
end)

CFG_ConfirmDeletion_No:set_callback(function()
    CFG_ConfirmDeletion_Yes:visibility(false)
    CFG_ConfirmDeletion_No:visibility(false)
    Configs:update(json.parse(files.read(Config_Data)))
end)

local function KillSay(e)
    local Custom_Table = {
        Inp1:get(),
        Inp2:get(),
        Inp3:get()
    }
    local target = e.target
    local get_target_entity = entity.get(target)
    if not get_target_entity then return end
    
    local health = get_target_entity.m_iHealth

    if not target:get_name() or not health then return end
    
    if health == 0 then
        if Main.Items.Support_Me:get() then
            utils.console_exec("say " .. (Support_Table[math.random(1, #Support_Table)]):format(target:get_name()))
        end
        if Main.Items.n1_one:get() then
            utils.console_exec("say " .. (n1_table[math.random(1, #n1_table)]):format(target:get_name()))
        end
        if Main.Items.Custom_Kill:get() then
            utils.console_exec("say " .. (Custom_Table[math.random(1, #Custom_Table)]):format(target:get_name()))
        end
    end
end

function Main_CM(cmd)
    no_fall_damage(cmd)
    Randomize_DT_Ticks(cmd)
    -- defensive_aa(cmd)
    Visuals_Createmove()
    fastladder(cmd)
    fix_nade()
    AntiAim_createmove(cmd)
    fix_fakeduck()
    -- hk_create_move(cmd)
    -- frametime = globals.frametime
    cvar.r_aspectratio:float(Main.Items.Aspect_Ratio:get() / 10)
end

function Main_Render(cmd)
    -- updateWaits()
    Watermark(cmd)
    draw_scope_lines()
    Visibility_easy()
    Visuals_Indicator()
    Update_SesionTime()
    -- Clan_tag()
end



events.render:set(function(cmd)
    Main_Render(cmd)
end)

events.createmove:set(function(cmd)
    Main_CM(cmd)
end)

events.aim_ack:set(function(e)
    KillSay(e)
end)

