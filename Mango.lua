
local Test = {}
function Test:pr(pprint)
    pprint("script_is_ready")
end

function Test:dev(files_, color_, common_, cvar_, entity_, esp_, events_, globals_, json_, materials_, math_, ui_, network_, panorama_, rage_, render_, utils_, vector_, clipboard, csgo_weapons, base64)
local files, color, common, cvar, entity, esp, events, globals, json, materials, math, ui, network, panorama, rage, render, utils, vector, csgo_weapons = files_, color_, common_, cvar_, entity_, esp_, events_, globals_, json_, materials_, math_, ui_, network_, panorama_, rage_, render_, utils_, vector_, csgo_weapons

files.create_folder('nl\\Mango')

files.create_folder('nl\\Mango')
files.create_folder('nl\\Mango\\modules')
files.create_folder('nl\\Mango\\configs')

local Main_Folder = 'nl\\Mango\\'
local Configs_Path = Main_Folder..'configs'


-- // Files \\ --
files.write('nl\\Mango\\modules\\easing.lua', network.get("https://raw.githubusercontent.com/Mana42138/Project-Mango/main/easing.lua"))
-- files.write('nl\\Mango\\modules\\easing23.lua', network.get("https://raw.githubusercontent.com/Mana42138/Project-Mango/main/Base64.lua"))

-- files.write('nl\\Mango\\modules\\noluck.lua', network.get("https://raw.githubusercontent.com/Mana42138/Project-Mango/main/Base64.lua"))
if not files.read('nl\\Mango\\configs.json') then
    files.write('nl\\Mango\\configs.json', json.stringify({}))
end

local weapons = {"Global","SSG-08","Pistols","AutoSnipers","Snipers","Rifles","SMGs","Shotguns","Machineguns","AWP","AK-47","M4A1/M4A4","Desert Eagle","R8 Revolver","AUG/SG 553","Taser"}

local Config_Data = 'nl\\Mango\\configs.json'

-- local Base64_ = require ('Mango\\modules\\noluck')


local ffi = require("ffi")

local clipboard = require('neverlose/clipboard')
local csgo_weapons = require('neverlose/csgo_weapons')
local MTools = require("neverlose/mtools")

-- common.add_notify('Mango', "Hello world!")

ffi.cdef[[
    typedef void* HANDLE;
    typedef HANDLE HWND;
    typedef const char* LPCSTR;
    typedef int BOOL;
    typedef unsigned int UINT;
    typedef long LONG;
    typedef LONG LPARAM;
    typedef LONG LRESULT;
    typedef UINT WPARAM;

    HWND FindWindowA(LPCSTR lpClassName, LPCSTR lpWindowName);
    BOOL SetWindowTextA(HWND hWnd, LPCSTR lpString);

    void* __stdcall URLDownloadToFileA(void* LPUNKNOWN, const char* LPCSTR, const char* LPCSTR2, int a, int LPBINDSTATUSCALLBACK); 
    bool DeleteUrlCacheEntryA(const char* lpszUrlName);
    int GetAsyncKeyState(int vKey);
]]


local js = panorama.loadstring([[
    return {
        OpenExternalBrowserURL: function(url){
            void SteamOverlayAPI.OpenExternalBrowserURL(url)
        }
    }
]])()

local window_title = function()
    local user32 = ffi.load("User32.dll")
    local game_window_class = "Valve001" -- Don't move this
    local game_window_title = "Counter-Strike: Global Offensive - Direct3D 9" -- And Thiz!
    local new_title = "Mango.lua powerd by neverlose.cc | "..common.get_username().." [Live]"
    user32.SetWindowTextA(user32.FindWindowA(game_window_class, new_title), game_window_title)
end

local Client_fps = function()
    local frametime = globals.frametime
    local fps = math.floor((1.0 / frametime) + 0.5)
    return fps
end

local urlmon = ffi.load 'UrlMon'
local wininet = ffi.load 'WinInet'

local Base64 = {}

Base64.code = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

Base64.encode = function(data)
    return "--Mang0 " .. ( ( data:gsub( '.', function( x )
        local r, b='', x:byte(  )
        for i = 8, 1, -1 do r = r .. ( b%2 ^ i - b%2 ^ ( i - 1 ) > 0 and '1' or '0' ) end
        return r
    end ) .. '0000' ):gsub( '%d%d%d?%d?%d?%d?', function( x )
        if ( #x < 6 ) then return '' end
        local c = 0
        for i = 1, 6 do c = c + ( x:sub( i, i ) == '1' and 2 ^ ( 6 - i ) or 0 ) end
        return Base64.code:sub( c + 1, c + 1 )
    end) .. ( { '', '==', '=' } )[ #data%3 + 1 ] )
end

Base64.decode = function(data)
    if data:sub(1, 8) == "--Mang0 " then
        data = data:sub(9)
    end

    data = string.gsub( data, '[^' .. Base64.code .. '=]', '' )
    return ( data:gsub( '.', function( x )
        if ( x == '=' ) then return '' end
        local r, f = '', ( Base64.code:find( x ) - 1 )
        for i = 6, 1, -1 do r = r .. ( f%2 ^ i - f%2 ^ ( i - 1 ) > 0 and '1' or '0' ) end
        return r
    end ):gsub( '%d%d%d?%d?%d?%d?%d?%d?', function( x )
        if ( #x ~= 8 ) then return '' end
        local c = 0
        for i = 1, 8 do c = c + ( x:sub( i, i ) == '1' and 2 ^ ( 8 - i ) or 0 ) end
        return string.char( c )
    end) )
end

local easing = require 'Mango\\modules\\easing'

download = function()
    wininet.DeleteUrlCacheEntryA("https://en.neverlose.cc/static/avatars/Razhvhh.png?t=1692979176")

    urlmon.URLDownloadToFileA(nil, "https://en.neverlose.cc/static/avatars/Razhvhh.png?t=1692979176", "nl\\Mango\\user_image.png", 0,0)
end

download()

local Menu_neverlose = {}

Menu_neverlose.ref = {
    ["ragebot"] = {
        main = ui.find("Aimbot", "Ragebot", "Main"),
        autopeek = ui.find("Aimbot", "Ragebot", "Main", "Peek Assist"),
        hs = ui.find("Aimbot", "Ragebot", "Main", "Hide Shots"),
        dt = ui.find("Aimbot", "Ragebot", "Main", "Double Tap"),
        lag_options = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options"),
        lag_limit = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Fake Lag Limit"),
        hs_options = ui.find("Aimbot", "Ragebot", "Main", "Hide Shots", "Options"),
        hitboxes = ui.find("Aimbot", "Ragebot", "Selection", "Hitboxes"),
        multipoint = ui.find("Aimbot", "Ragebot", "Selection", "Multipoint"),
        safepoint = ui.find("Aimbot", "Ragebot", "Safety", "Safe Points"),
        baim = ui.find("Aimbot", "Ragebot", "Safety", "Body Aim"),
        safety = ui.find("Aimbot", "Ragebot", "Safety"),
        accuracy = ui.find("Aimbot", "Ragebot", "Accuracy", "SSG-08"),
        da = ui.find("Aimbot", "Ragebot", "Main", "Enabled", "Dormant Aimbot"),
    },
    ["antiaim"] = {
        angles = ui.find("Aimbot", "Anti Aim", "Angles"),
        pitch = ui.find("Aimbot", "Anti Aim", "Angles", "Pitch"),
        yaw = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw"),
        base = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Base"),
        offset = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Offset"),
        fakelag = ui.find("Aimbot", "Anti Aim", "Fake Lag"),
        misc = ui.find("Aimbot", "Anti Aim", "Misc"),
        bodyyaw = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw"),
        fs = ui.find("Aimbot", "Anti Aim", "Angles", "Freestanding"),
        fl_enabled = ui.find("Aimbot", "Anti Aim", "Fake Lag", "Enabled"),
        aa_enabled = ui.find("Aimbot", "Anti Aim", "Angles", "Enabled"),
        limit = ui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit"),
        fd = ui.find("Aimbot", "Anti Aim", "Misc", "Fake Duck"),
        hidden = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Hidden"),
        slowwalk = ui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk"),
        inverter = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Inverter"),
        ymoffset = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", "Offset"),
        yawmod = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"),
        options = ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"),
    },
    ["world"] = {
        main = ui.find("Visuals", "World", "Main"),
        other = ui.find("Visuals", "World", "Other"),
    },
    ["misc"] = {
        in_game = ui.find("Miscellaneous", "Main", "In-Game"),
        other = ui.find("Miscellaneous", "Main", "Other"),
        air_strafe = ui.find("Miscellaneous", "Main", "Movement", "Air Strafe"),
    }
}

local Keys = {LBUTTON = 0x01,RBUTTON = 0x02,CANCEL = 0x03,MBUTTON = 0x04,XBUTTON1 = 0x05,XBUTTON2 = 0x06,BACK = 0x08,TAB = 0x09,CLEAR = 0x0C,RETURN = 0x0D,SHIFT = 0x10,CONTROL = 0x11,MENU = 0x12,PAUSE = 0x13,CAPITAL = 0x14,ESCAPE = 0x1B,SPACE = 0x20,PRIOR = 0x21,NEXT = 0x22,END = 0x23,HOME = 0x24,LEFT = 0x25,UP = 0x26,RIGHT = 0x27,DOWN = 0x28,SELECT = 0x29,PRINT = 0x2A,EXECUTE = 0x2B,SNAPSHOT = 0x2C,INSERT = 0x2D,DELETE = 0x2E,HELP = 0x2F,["0"] = 0x30,["1"] = 0x31,["2"] = 0x32,["3"] = 0x33,["4"] = 0x34,["5"] = 0x35,["6"] = 0x36,["7"] = 0x37,["8"] = 0x38,["9"] = 0x39,A = 0x41,B = 0x42,C = 0x43,D = 0x44,E = 0x45,F = 0x46,G = 0x47,H = 0x48,I = 0x49,J = 0x4A,K = 0x4B,L = 0x4C,M = 0x4D,N = 0x4E,O = 0x4F,P = 0x50,Q = 0x51,R = 0x52,S = 0x53,T = 0x54,U = 0x55,V = 0x56,W = 0x57,X = 0x58,Y = 0x59,Z = 0x5A,LWIN = 0x5B,RWIN = 0x5C,APPS = 0x5D,SLEEP = 0x5F,NUMPAD0 = 0x60,NUMPAD1 = 0x61,NUMPAD2 = 0x62,NUMPAD3 = 0x63,NUMPAD4 = 0x64,NUMPAD5 = 0x65,NUMPAD6 = 0x66,NUMPAD7 = 0x67,NUMPAD8 = 0x68,NUMPAD9 = 0x69,MULTIPLY = 0x6A,ADD = 0x6B,SEPARATOR = 0x6C,SUBTRACT = 0x6D,DECIMAL = 0x6E,DIVIDE = 0x6F,F1 = 0x70,F2 = 0x71,F3 = 0x72,F4 = 0x73,F5 = 0x74,F6 = 0x75,F7 = 0x76,F8 = 0x77,F9 = 0x78,F10 = 0x79,F11 = 0x7A,F12 = 0x7B,F13 = 0x7C,F14 = 0x7D,F15 = 0x7E,F16 = 0x7F,F17 = 0x80,F18 = 0x81,F19 = 0x82,F20 = 0x83,F21 = 0x84,F22 = 0x85,F23 = 0x86,F24 = 0x87,NUMLOCK = 0x90,SCROLL = 0x91,LSHIFT = 0xA0,RSHIFT = 0xA1,LCONTROL = 0xA2,RCONTROL = 0xA3,LMENU = 0xA4,RMENU = 0xA5,BROWSER_BACK = 0xA6,BROWSER_FORWARD = 0xA7,BROWSER_REFRESH = 0xA8,BROWSER_STOP = 0xA9,BROWSER_SEARCH = 0xAA,BROWSER_FAVORITES = 0xAB,BROWSER_HOME = 0xAC,VOLUME_MUTE = 0xAD,VOLUME_DOWN = 0xAE,VOLUME_UP = 0xAF,MEDIA_NEXT_TRACK = 0xB0,MEDIA_PREV_TRACK = 0xB1,MEDIA_STOP = 0xB2,MEDIA_PLAY_PAUSE = 0xB3,LAUNCH_MAIL = 0xB4,LAUNCH_MEDIA_SELECT = 0xB5,LAUNCH_APP1 = 0xB6,LAUNCH_APP2 = 0xB7,OEM_1 = 0xBA,OEM_PLUS = 0xBB,OEM_COMMA = 0xBC,OEM_MINUS = 0xBD,OEM_PERIOD = 0xBE,OEM_2 = 0xBF,OEM_3 = 0xC0,OEM_4 = 0xDB,OEM_5 = 0xDC,OEM_6 = 0xDD,OEM_7 = 0xDE,OEM_8 = 0xDF,OEM_102 = 0xE2,PROCESSKEY = 0xE5,PACKET = 0xE7,ATTN = 0xF6,CRSEL = 0xF7,EXSEL = 0xF8,EREOF = 0xF9,PLAY = 0xFA,ZOOM = 0xFB,NONAME = 0xFC,PA1 = 0xFD,OEM_CLEAR = 0xFE}


local Setup_welcome = ui.create(ui.get_icon('user').." user", " ")
local cfgsys = ui.create(ui.get_icon('user').." user", "  ")
local Setup_Updates = ui.create(ui.get_icon('user').." user", "   ")

local image_draw = render.load_image(network.get("https://en.neverlose.cc/static/avatars/"..common.get_username()..".png?t=1692979176"))

Setup_welcome:texture(image_draw, vector(100, 100, 100), color(255,255,255, 255), "Image", 0) -- texture: ImgObject[, size: vector, color: color, mode: string, rounding: number]

local Get_Enemy_Visible = function(entity, is_enemy, is_visible)
    if entity:is_alive() and (entity:is_enemy() and is_enemy) and (entity:is_visible() and is_visible) then
        return true
    end
    return false
end

function normalize_yaw (angle)
    adjusted_yaw = angle;

    if adjusted_yaw < -180 then
        adjusted_yaw = adjusted_yaw + 360
    end
    
    if adjusted_yaw > 180 then
        adjusted_yaw = adjusted_yaw - 360
    end
    

    return adjusted_yaw;
end

local Main = ui.create(ui.get_icon('wheelchair').." Anti-Aim", "Main")

local Misc = ui.create(ui.get_icon('globe').." Visuals", "Misc")

local Main = {
    script_db = {
        username = tostring(common.get_username()),
        lua_name = 'Mang0.lua',
        lua_version = 'v1',
        script_version = "1.5034",
    },
    visuals = {},
    Items = {},
    Main_Anti_Defensive = {
        main = {
            fs = Menu_neverlose.ref.antiaim.fs,
            hidden = ui.find("Aimbot", "Anti Aim", "Angles", "Yaw", "Hidden"),
            lag_options = ui.find("Aimbot", "Ragebot", "Main", "Double Tap", "Lag Options"),
        }
    },
    Tabs = {
        Builder = ui.create(ui.get_icon('wheelchair').." Anti-Aim", "Builder"),
        AntiAim = ui.create(ui.get_icon('wheelchair').." Anti-Aim", "Anti-Aim"),
        Ragebot = ui.create(ui.get_icon('wheelchair').." Anti-Aim", "💀 Ragebot"),
        RageMisc = ui.create(ui.get_icon('wheelchair').." Anti-Aim", ui.get_icon('gear').." Misc"),
        Misc = ui.create(ui.get_icon('globe').." Visuals", ui.get_icon('globe').." Visuals"),
        Scope = ui.create(ui.get_icon('globe').." Visuals", ui.get_icon('asterisk').." Scope"),
        KillSay = ui.create(ui.get_icon('globe').." Visuals", "Killsay"),
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

Main.helpers.gradient_text = function(r1, g1, b1, a1, r2, g2, b2, a2, text)
    local output = ''

    local len = #text-1

    local rinc = (r2 - r1) / len
    local ginc = (g2 - g1) / len
    local binc = (b2 - b1) / len
    local ainc = (a2 - a1) / len

    for i=1, len+1 do
        output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, a1, text:sub(i, i))

        r1 = r1 + rinc
        g1 = g1 + ginc
        b1 = b1 + binc
        a1 = a1 + ainc
    end

    return output.."\aFFFFFFFF"
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

local Yaw_modifier_List = Menu_neverlose.ref.antiaim.yawmod:list()

Main.Items.Global_AA_Enable = Builder_Section:switch("Global Enable")

Main.Items.Global_AA_pitch_settings = Builder_Section:combo("G ~ pitch settings", {"None", "Zero", 'Up', "Down", "Random", "Jitter", "45 deg"}):visibility(false)
Main.Items.Global_AA_yaw_settings = Builder_Section:combo("G ~ yaw settings", {"None", "Static", 'Random', "Side-Way", "Spin"}):visibility(false)
Main.Items.Global_AA_SpinSpeed = Main.Items.Global_AA_yaw_settings:create():slider("Spin Speed", 0, 1000, 0, 1):visibility(false)
Main.Items.Global_AA_Randomize_SpinSpeed = Main.Items.Global_AA_yaw_settings:create():switch("Randomize Spin Speed"):visibility(false)

Main.Items.Global_AA_Yaw_Add_Type = Builder_Section:combo("G ~ Yaw Add Type", {"Static", "Jitter"})
Main.Items.Global_AA_Yaw_Modifier = Builder_Section:combo("G ~ Yaw Modifier", Yaw_modifier_List)

Main.Items.Global_AA_Left_Limit = Builder_Section:slider("G ~ Left Limit", 0, 60, 0, 1)
Main.Items.Global_AA_Right_Limit = Builder_Section:slider("G ~ Right Limit", 0, 60, 0, 1)
Main.Items.Global_AA_Options = Builder_Section:selectable("G ~ Options", Menu_neverlose.ref.antiaim.options:list())
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
        if Menu_neverlose.ref.antiaim.fs:get() then return end
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
                -- Menu_neverlose.ref.ragebot.hs:override(true)
                Menu_neverlose.ref.antiaim.hs_options:override("Break LC")
                rage.antiaim:override_hidden_pitch(pitch_override)
                rage.antiaim:override_hidden_yaw_offset(yaw_override)
                Menu_neverlose.ref.ragebot.lag_options:override("Always On")
                Menu_neverlose.ref.antiaim.hidden:override(true)
            else
                -- Menu_neverlose.ref.ragebot.hs:override()
                Menu_neverlose.ref.ragebot.hs_options:override()
                Menu_neverlose.ref.ragebot.lag_options:override()
                Menu_neverlose.ref.antiaim.hidden:override()
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
                            Menu_neverlose.ref.antiaim.offset:override(-60)
                        else
                            Menu_neverlose.ref.antiaim.offset:override(60)
                        end
                    else
                        if Global_Flag then
                            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Global_AA_Y_Add_Right:get())
                        else
                            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Global_AA_Y_Add_Left:get())
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
                        Menu_neverlose.ref.antiaim.offset:override(0)
                        Global_Flag_2 = false
                    end
                end
            })
        end

        if Main.Items.Global_AA_Yaw_Add_Type:get() == 'Static' then
            if Menu_neverlose.ref.antiaim.inverter:get() then
                Menu_neverlose.ref.antiaim.offset:override(Main.Items.Global_AA_Y_Add_Left:get())
            else
                Menu_neverlose.ref.antiaim.offset:override(Main.Items.Global_AA_Y_Add_Right:get())
            end
        end

        local YawModifier = Main.Items.Global_AA_Yaw_Modifier:get()

        -- if YawModifier ~= "Disabled" then
            if Main.Items.Global_AA_YM_Modifier_randomize:get() then
                YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
            end
            
            Menu_neverlose.ref.antiaim.ymoffset:override(Main.Items.Global_AA_YM_Modifier:get())
            Menu_neverlose.ref.antiaim.yawmod:override(YawModifier)
        -- end

        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Global_AA_Left_Limit:get())
        ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Global_AA_Right_Limit:get())
        Menu_neverlose.ref.antiaim.options:override(Main.Items.Global_AA_Options:get())

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
Main.Items.Standing_AA_Options = Builder_Section:selectable("S ~ Options", Menu_neverlose.ref.antiaim.options:list())
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
    if Menu_neverlose.ref.antiaim.fs:get() then return end
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
            -- Menu_neverlose.ref.ragebot.hs:override(true)
            Menu_neverlose.ref.ragebot.hs_options:override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Menu_neverlose.ref.ragebot.lag_options:override("Always On")
            Menu_neverlose.ref.antiaim.hidden:override(true)
        else
            -- Menu_neverlose.ref.ragebot.hs:override()
            Menu_neverlose.ref.ragebot.hs_options:override()
            Menu_neverlose.ref.ragebot.lag_options:override()
            Menu_neverlose.ref.antiaim.hidden:override()
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
                        Menu_neverlose.ref.antiaim.offset:override(-60)
                    else
                        Menu_neverlose.ref.antiaim.offset:override(60)
                    end
                else
                    if Standing_Flag then
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Standing_AA_Y_Add_Right:get())
                    else
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Standing_AA_Y_Add_Left:get())
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
                    Menu_neverlose.ref.antiaim.offset:override(0)
                    Standing_Flag_2 = false
                end
            end
        })
        -- AAWait(Main.Items.Standing_AA_Y_Time:get(), function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Standing_AA_Y_Add_Right:get())
        -- end, function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Standing_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Standing_AA_Yaw_Add_Type:get() == 'Static' then
        if Menu_neverlose.ref.antiaim.inverter:get() then
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Standing_AA_Y_Add_Left:get())
        else
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Standing_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Standing_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Standing_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        Menu_neverlose.ref.antiaim.ymoffset:override(Main.Items.Standing_AA_YM_Modifier:get())
        Menu_neverlose.ref.antiaim.yawmod:override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Standing_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Standing_AA_Right_Limit:get())
    Menu_neverlose.ref.antiaim.options:override(Main.Items.Standing_AA_Options:get())

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
Main.Items[Setting.."_AA_Options"] = Builder_Section:selectable("W ~ Options", Menu_neverlose.ref.antiaim.options:list())
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
    if Menu_neverlose.ref.antiaim.fs:get() then return end
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
            -- Menu_neverlose.ref.ragebot.hs:override(true)
            Menu_neverlose.ref.ragebot.hs_options:override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Menu_neverlose.ref.ragebot.lag_options:override("Always On")
            Menu_neverlose.ref.antiaim.hidden:override(true)
        else
            -- Menu_neverlose.ref.ragebot.hs:override()
            Menu_neverlose.ref.ragebot.hs_options:override()
            Menu_neverlose.ref.ragebot.lag_options:override()
            Menu_neverlose.ref.antiaim.hidden:override()
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
                        Menu_neverlose.ref.antiaim.offset:override(-60)
                    else
                        Menu_neverlose.ref.antiaim.offset:override(60)
                    end
                else
                    if Walking_Flag then
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Walking_AA_Y_Add_Right:get())
                    else
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Walking_AA_Y_Add_Left:get())
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
                    Menu_neverlose.ref.antiaim.offset:override(0)
                    Walking_Flag_2 = false
                end
            end
        })
        -- AAWait(Main.Items.Walking_AA_Y_Time:get(), function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Walking_AA_Y_Add_Right:get())
        -- end, function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Walking_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Walking_AA_Yaw_Add_Type:get() == 'Static' then
        if Menu_neverlose.ref.antiaim.inverter:get() then
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Walking_AA_Y_Add_Left:get())
        else
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Walking_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Walking_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Walking_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        Menu_neverlose.ref.antiaim.ymoffset:override(Main.Items.Walking_AA_YM_Modifier:get())
        Menu_neverlose.ref.antiaim.yawmod:override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Walking_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Walking_AA_Right_Limit:get())
    Menu_neverlose.ref.antiaim.options:override(Main.Items.Walking_AA_Options:get())

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
Main.Items.Running_AA_Options = Builder_Section:selectable("R ~ Options", Menu_neverlose.ref.antiaim.options:list())
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
    if Menu_neverlose.ref.antiaim.fs:get() then return end
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
            -- Menu_neverlose.ref.ragebot.hs:override(true)
            Menu_neverlose.ref.ragebot.hs_options:override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Menu_neverlose.ref.ragebot.lag_options:override("Always On")
            Menu_neverlose.ref.antiaim.hidden:override(true)
        else
            -- Menu_neverlose.ref.ragebot.hs:override()
            Menu_neverlose.ref.ragebot.hs_options:override()
            Menu_neverlose.ref.ragebot.lag_options:override()
            Menu_neverlose.ref.antiaim.hidden:override()
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
                        Menu_neverlose.ref.antiaim.offset:override(-60)
                    else
                        Menu_neverlose.ref.antiaim.offset:override(60)
                    end
                else
                    if Running_Flag then
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Running_AA_Y_Add_Right:get())
                    else
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Running_AA_Y_Add_Left:get())
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
                    Menu_neverlose.ref.antiaim.offset:override(0)
                    Running_Flag_2 = false
                end
            end
        })
        -- AAWait(Main.Items.Running_AA_Y_Time:get(), function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Running_AA_Y_Add_Right:get())
        -- end, function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Running_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Running_AA_Yaw_Add_Type:get() == 'Static' then
        if Menu_neverlose.ref.antiaim.inverter:get() then
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Running_AA_Y_Add_Left:get())
        else
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Running_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Running_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Running_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        Menu_neverlose.ref.antiaim.ymoffset:override(Main.Items.Running_AA_YM_Modifier:get())
        Menu_neverlose.ref.antiaim.yawmod:override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Running_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Running_AA_Right_Limit:get())
    Menu_neverlose.ref.antiaim.options:override(Main.Items.Running_AA_Options:get())

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
Main.Items.Crouching_AA_Options = Builder_Section:selectable("C ~ Options", Menu_neverlose.ref.antiaim.options:list())
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
    if Menu_neverlose.ref.antiaim.fs:get() then return end
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
            -- Menu_neverlose.ref.ragebot.hs:override(true)
            Menu_neverlose.ref.ragebot.hs_options:override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Menu_neverlose.ref.ragebot.lag_options:override("Always On")
            Menu_neverlose.ref.antiaim.hidden:override(true)
        else
            -- Menu_neverlose.ref.ragebot.hs:override()
            Menu_neverlose.ref.ragebot.hs_options:override()
            Menu_neverlose.ref.ragebot.lag_options:override()
            Menu_neverlose.ref.antiaim.hidden:override()
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
                        Menu_neverlose.ref.antiaim.offset:override(-60)
                    else
                        Menu_neverlose.ref.antiaim.offset:override(60)
                    end
                else
                    if Crouching_Flag then
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Crouching_AA_Y_Add_Right:get())
                    else
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.Crouching_AA_Y_Add_Left:get())
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
                    Menu_neverlose.ref.antiaim.offset:override(0)
                    Crouching_Flag2 = false
                end
            end
        })
        -- AAWait(Main.Items.Crouching_AA_Y_Time:get(), function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Crouching_AA_Y_Add_Right:get())
        -- end, function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.Crouching_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.Crouching_AA_Yaw_Add_Type:get() == 'Static' then
        if Menu_neverlose.ref.antiaim.inverter:get() then
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Crouching_AA_Y_Add_Left:get())
        else
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.Crouching_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.Crouching_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.Crouching_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        Menu_neverlose.ref.antiaim.ymoffset:override(Main.Items.Crouching_AA_YM_Modifier:get())
        Menu_neverlose.ref.antiaim.yawmod:override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.Crouching_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.Crouching_AA_Right_Limit:get())
    Menu_neverlose.ref.antiaim.options:override(Main.Items.Crouching_AA_Options:get())

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
Main.Items.In_Air_AA_Options = Builder_Section:selectable("A ~ Options", Menu_neverlose.ref.antiaim.options:list())
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
    if Menu_neverlose.ref.antiaim.fs:get() then return end
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
            -- Menu_neverlose.ref.ragebot.hs:override(true)
            Menu_neverlose.ref.ragebot.hs_options:override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Menu_neverlose.ref.ragebot.lag_options:override("Always On")
            Menu_neverlose.ref.antiaim.hidden:override(true)
        else
            -- Menu_neverlose.ref.ragebot.hs:override()
            Menu_neverlose.ref.ragebot.hs_options:override()
            Menu_neverlose.ref.ragebot.lag_options:override()
            Menu_neverlose.ref.antiaim.hidden:override()
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
                        Menu_neverlose.ref.antiaim.offset:override(-60)
                    else
                        Menu_neverlose.ref.antiaim.offset:override(60)
                    end
                else
                    if In_Air_Flag then
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AA_Y_Add_Right:get())
                    else
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AA_Y_Add_Left:get())
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
                    Menu_neverlose.ref.antiaim.offset:override(0)
                    In_Air_Flag2 = false
                end
            end
        })
        -- AAWait(Main.Items.In_Air_AA_Y_Time:get(), function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AA_Y_Add_Right:get())
        -- end, function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.In_Air_AA_Yaw_Add_Type:get() == 'Static' then
        if Menu_neverlose.ref.antiaim.inverter:get() then
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AA_Y_Add_Left:get())
        else
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.In_Air_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.In_Air_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        Menu_neverlose.ref.antiaim.ymoffset:override(Main.Items.In_Air_AA_YM_Modifier:get())
        Menu_neverlose.ref.antiaim.yawmod:override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.In_Air_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.In_Air_AA_Right_Limit:get())
    Menu_neverlose.ref.antiaim.options:override(Main.Items.In_Air_AA_Options:get())

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
Main.Items.In_Air_AC_AA_Options = Builder_Section:selectable("AC ~ Options", Menu_neverlose.ref.antiaim.options:list())
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
    if Menu_neverlose.ref.antiaim.fs:get() then return end
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
            -- Menu_neverlose.ref.ragebot.hs:override(true)
            Menu_neverlose.ref.ragebot.hs_options:override("Break LC")
            rage.antiaim:override_hidden_pitch(pitch_override)
            rage.antiaim:override_hidden_yaw_offset(yaw_override)
            Menu_neverlose.ref.ragebot.lag_options:override("Always On")
            Menu_neverlose.ref.antiaim.hidden:override(true)
        else
            -- Menu_neverlose.ref.ragebot.hs:override()
            Menu_neverlose.ref.ragebot.hs_options:override()
            Menu_neverlose.ref.ragebot.lag_options:override()
            Menu_neverlose.ref.antiaim.hidden:override()
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
                        Menu_neverlose.ref.antiaim.offset:override(-60)
                    else
                        Menu_neverlose.ref.antiaim.offset:override(60)
                    end
                else
                    if In_Air_AC_Flag then
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AC_AA_Y_Add_Right:get())
                    else
                        Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AC_AA_Y_Add_Left:get())
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
                    Menu_neverlose.ref.antiaim.offset:override(0)
                    In_Air_AC_Flag2 = false
                end
            end
        })
        -- AAWait(Main.Items.In_Air_AC_AA_Y_Time:get(), function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AC_AA_Y_Add_Right:get())
        -- end, function()
        --     Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AC_AA_Y_Add_Left:get())
        -- end)
    end

    if Main.Items.In_Air_AC_AA_Yaw_Add_Type:get() == 'Static' then
        if Menu_neverlose.ref.antiaim.inverter:get() then
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AC_AA_Y_Add_Left:get())
        else
            Menu_neverlose.ref.antiaim.offset:override(Main.Items.In_Air_AC_AA_Y_Add_Right:get())
        end
    end

    local YawModifier = Main.Items.In_Air_AC_AA_Yaw_Modifier:get()

    -- if YawModifier ~= "Disabled" then
        if Main.Items.In_Air_AC_AA_YM_Modifier_randomize:get() then
            YawModifier = Yaw_modifier_List[math.random(2, #Yaw_modifier_List)]
        end
        
        Menu_neverlose.ref.antiaim.ymoffset:override(Main.Items.In_Air_AC_AA_YM_Modifier:get())
        Menu_neverlose.ref.antiaim.yawmod:override(YawModifier)
    -- end

    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(Main.Items.In_Air_AC_AA_Left_Limit:get())
    ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(Main.Items.In_Air_AC_AA_Right_Limit:get())
    Menu_neverlose.ref.antiaim.options:override(Main.Items.In_Air_AC_AA_Options:get())

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
                Menu_neverlose.ref.antiaim.limit:override(math.random(Main.Items.Fake_Lag_AA_Min_Limit:get(), Main.Items.Fake_Lag_AA_Max_Limit:get()))
            end
        })
    else
        Menu_neverlose.ref.antiaim.limit:override(Main.Items.Fake_Lag_AA_Max_Limit:get())
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
    if not Main.Items.Build_AA:get() then return end

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

end)

Main.Items.randomize = Main.Tabs.Ragebot:switch("Randomize DT"):tooltip("The More you turn up max the more it gets randomized")
Main.Items.Max = Main.Items.randomize:create():slider("Max", 0, 10, 0, 1)
Main.Items.Min = Main.Items.randomize:create():slider("Min", 0, 10, 0, 1)

Main.Items.Randomize_Multipoint = Main.Tabs.Ragebot:switch("Randomize Multipoint"):tooltip(ui.get_icon("triangle-exclamation").."Randomizing Multipoint from (0-100) Multipoint is when its set to 20 it will focus on the head more and shoot closer to the middle if its at a hundred it will shoot when it is hittable and will probably miss")
Main.Items.Randomize_Multipoint_AllowedWeapons = Main.Items.Randomize_Multipoint:create():selectable("Weapons", weapons)

Main.Items.manualaa = Main.Tabs.RageMisc:combo("Manual AA", {"None", "Left", "Backwards", "Right", "Forwards", "Freestanding"})

Main.Items.AntiHead = Main.Tabs.RageMisc:switch("Anti-Head [BETA]"):tooltip(ui.get_icon("triangle-exclamation").."Attempts to randomize your head yaw making it harder to predict")

function tablefind(tbl, value)
    for k, v in pairs(tbl) do
        if v == value then
            return k
        end
    end
    return nil
end

local function Rand_Multipoint()
    if not Main.Items.Randomize_Multipoint:get() then return end
    -- table.foreach(Main.Items.Randomize_Multipoint_AllowedWeapons:get(), print)
    for i,v in pairs(weapons) do
        if tablefind(Main.Items.Randomize_Multipoint_AllowedWeapons:get(), v) then
            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint", "Head Scale"):override(math.random(0, 100))
            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint", "Body Scale"):override(math.random(0, 100))
        else
            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint", "Head Scale"):override()
            ui.find("Aimbot", "Ragebot", "Selection", v, "Multipoint", "Body Scale"):override()
        end
    end
end

local function Randomize_DT_Ticks(cmd)
    if not Main.Items.randomize:get() then return end
    if Main.Items.Min:get() > Main.Items.Max:get() then
        Main.Items.Max:set(Main.Items.Min:get())
    end
    Menu_neverlose.ref.ragebot.lag_limit:override(math.random(Main.Items.Min:get(), Main.Items.Max:get()))
end

local Enemy_Anti_Head = function()
    if not Main.Items.AntiHead:get() then return end
    if Main.Items.manualaa:get() ~= "None" then return end
    local Enemies_Table = entity.get_players(true, false)
    for i,v in pairs(Enemies_Table) do
        if Get_Enemy_Visible(v, true, true) then
            Main.Items.Build_AA:override(false)
            if Menu_neverlose.ref.ragebot.dt:get() or Menu_neverlose.ref.ragebot.hs:get() then
                rage.antiaim:override_hidden_pitch(math.random(-89, 89))
                rage.antiaim:override_hidden_yaw_offset(math.random(-360, 360))
                Menu_neverlose.ref.ragebot.lag_options:override("Always On")
                Menu_neverlose.ref.ragebot.hs_options:override("Break LC")
                Menu_neverlose.ref.antiaim.hidden:override(true)
            else
                Menu_neverlose.ref.antiaim.limit:override(math.random(0, 14))
                Menu_neverlose.ref.antiaim.offset:override(math.random(-30, 45))
                ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override(math.random(-60, 60))
                ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override(math.random(-60, 60))
                Menu_neverlose.ref.antiaim.ymoffset:override(math.random(-34, 34))
            end
        else
            -- Main.Items.Build_AA:override()
            -- Menu_neverlose.ref.ragebot.lag_options:override()
            -- Menu_neverlose.ref.antiaim.hidden:override()
            -- Menu_neverlose.ref.ragebot.hs_options:override()
            -- ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Right Limit"):override()
            -- Menu_neverlose.ref.antiaim.limit:override()
            -- ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Left Limit"):override()
            -- Menu_neverlose.ref.antiaim.ymoffset:override()
        end
    end
end

local manual_aa = function()

    yaw = Menu_neverlose.ref.antiaim.yaw
    base = Menu_neverlose.ref.antiaim.base
    offset = Menu_neverlose.ref.antiaim.offset
    fs = Menu_neverlose.ref.antiaim.fs

        if Main.Items.manualaa:get() == "Left" then
            yaw:override("Backward")
            base:override("Local View")
            offset:override(-90)
            fs:override(false)
            Main.Items.Build_AA:override(false)
        elseif Main.Items.manualaa:get() == "Backwards" then
            yaw:override("Backward")
            base:override("Local View")
            offset:override(0)
            fs:override(false)
            Main.Items.Build_AA:override(false)
        elseif Main.Items.manualaa:get() == "Right" then
            yaw:override("Backward")
            base:override("Local View")
            offset:override(90)
            fs:override(false)
            Main.Items.Build_AA:override(false)
        elseif Main.Items.manualaa:get() == "Forwards" then
            yaw:override("Backward")
            base:override("Local View")
            offset:override(180)
            fs:override(false)
            Main.Items.Build_AA:override(false)
        elseif Main.Items.manualaa:get() == "Freestanding" then
            yaw:override("Backward")
            base:override("Local View")
            offset:override(0)
            fs:override(true)
            Main.Items.Build_AA:override(false)
        elseif Main.Items.manualaa:get() == "None" then
            yaw:override()
            base:override()
            fs:override()
            offset:override()
            Main.Items.Build_AA:override()
        end
end

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
    if not Menu_neverlose.ref.antiaim.fd:get() then return end
    Menu_neverlose.ref.antiaim.limit:override(14)
    ui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles"):override(false)
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


Main.Items.Slientshots = Main.Tabs.Ragebot:switch("Slient shots"):tooltip("A.K.A No fakelag on shots\n\nForce send packet while every shots")

Main.Items.Slientshots_Mode = Main.Items.Slientshots:create():combo("Mode", "Overrides", "Send packets")

local always_choke_slient_shots = function()

    events.createmove:set(function(cmd)
        local localplayer = entity.get_local_player()
        if not localplayer then return end
    
        local my_weapon = localplayer:get_player_weapon()
    
        if Main.Items.Slientshots:get() then
            if my_weapon then
                local last_shot_time = my_weapon["m_fLastShotTime"]
    	    	local time_difference = globals.curtime - last_shot_time
                
                if time_difference <= 0.025 then
                    if Main.Items.Slientshots_Mode:get() == "Overrides" then
                        Menu_neverlose.ref.antiaim.bodyyaw:override(false)
                        Menu_neverlose.ref.antiaim.fl_enabled:override(false)
                        Menu_neverlose.ref.antiaim.limit:override(1)
                    elseif Main.Items.Slientshots_Mode:get() == "Send packets" then
                        --sendpacket_switch = true
                        cmd.no_choke = true
                        cmd.no_choke = false
                        cmd.no_choke = true
                        cmd.no_choke = false
                        cmd.no_choke = true
                    end
                else
                    Menu_neverlose.ref.antiaim.bodyyaw:override()
                    Menu_neverlose.ref.antiaim.fl_enabled:override()
                    Menu_neverlose.ref.antiaim.limit:override()
                end
            end
        end
    end)
end


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

local timing_switch = 20

local fps = 0
local cur_mode = 0
local timing = timing_switch

local function hk_create_move(cmd)
    timing = timing + 1
end

local clantag = {}

clantag.animation = {
    "M           ", -- 9 characters
    "Ma          ", -- 9 characters
    "Man         ", -- 9 characters
    "Mang        ", -- 9 characters
    "Mang0       ", -- 9 characters
    "Mang0.      ", -- 9 characters
    "Mang0.l     ", -- 9 characters
    "Mang0.lu    ", -- 9 characters
    "Mang0.lua   ", -- 9 characters
    "Mang0.lua   ", -- 9 characters (repeated for symmetry)
    "Mang0.lu    ", -- 9 characters
    "Mang0.l     ", -- 9 characters
    "Mang0.      ", -- 9 characters
    "Mang0       ", -- 9 characters
    "Mang        ", -- 9 characters
    "Man         ", -- 9 characters
    "Ma          ", -- 9 characters
    "M           ", -- 9 characters
}

clantag.vars = {
    remove = false,
    timer = 0
}

clantag.run = function()
    if not Main.Items.Clantag:get() then return end
    local curtime = math.floor(globals.curtime * 2)

    if clantag.vars.timer ~= curtime then
        common.set_clan_tag(clantag.animation[curtime % #clantag.animation + 1])
        clantag.vars.timer = curtime
    end

    clantag.vars.remove = true
end

clantag.remove = function()
    if clantag.vars.remove then
        common.set_clan_tag("")
        clantag.vars.remove = false
    end
end

Main.Items.Clantag:set_callback(function()
    clantag.remove()
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
        if string.find(i, "CustScope") then
            v:visibility(Main.Items.CScope:get())
        elseif string.find(i, "CustKillsay") then
            v:visibility(Main.Items.Custom_Kill:get())
        elseif string.find(i, "AA_options") then
            v:visibility(Main.Items.Build_AA:get())
        end
    end
end

local fonts = {
    font = { font = render.load_font("Verdana Bold", 11), size = 11 },
    font1 = { font = render.load_font("Verdana Bold", 10), size = 10 },
    font2 = { font = render.load_font("Arial", 11), size = 11 },
    font5 = { font = render.load_font("Arial Bold", 11), size = 11 },
    font55 = { font = render.load_font("Arial Bold", 26), size = 26 },
    font7 = { font = render.load_font("Arial", 13,"a"), size = 13 },
    fontpred = { font = render.load_font("Arial Bold", 12), size = 12 },
    fontideal = { font = render.load_font("Verdana", 12), size = 12 },
    verdana_skt = { font = render.load_font("Verdana", 13), size = 13 },
    verdana_bolde = { font = render.load_font("Verdana", 11, 'b'), size = 11 },
    verdanar11 = { font =  render.load_font('Verdana', 11, 'a'), size = 11 },
    fontxd = { font = render.load_font("Verdana Bold", 23), size = 23 },
    fontxd2 = { font = render.load_font("Verdana", 12), size = 12 },
    fontdx = { font = render.load_font("Verdana Bold", 10,"o")},
    fontarrow = { font = render.load_font("Verdana Bold", 21, 'a'), size = 21 },
    console = { font = render.load_font("Verdana Bold", 10, 'd'), size = 10 }
}

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

Main.visuals.Frame = function(x, y, z, height, color_, rounding)
    local pos1, pos2 = vector(x, y), vector(x + z ,y + height)
    render.rect(vector(x, y), vector(x + z ,y + height), color(color_.r, color_.g, color_.b, color_.a), rounding, false)
    return pos1, pos2
end

Main.visuals.Textlabel = function(x,y,cen,string,color,TYPE,font,fontsize)
    --1=for Defaultfont, 
    --2=for Smallfont, 
    --3 = for Consolefont
    --4=for Boldfont

    render.text(fonts.font.font, vector(x,y), color, cen and 'c' or '', string)
end

Main.visuals.Shadow = function(pos_a, pos_b, width, height, colour, thickness, offset, rounding)
    render.shadow(vector(pos_a, pos_b), vector(pos_a + width, pos_b + height), color(colour.r, colour.g, colour.b, colour.a), thickness, offset, rounding)
end

Main.visuals.watermark = {}

Main.visuals.watermark.tag = {}

Main.visuals.watermark.tag.animation = {
    "M           ", -- 9 characters
    "Ma          ", -- 9 characters
    "Man         ", -- 9 characters
    "Mang        ", -- 9 characters
    "Mang0       ", -- 9 characters
    "Mang0.      ", -- 9 characters
    "Mang0.l     ", -- 9 characters
    "Mang0.lu    ", -- 9 characters
    "Mang0.lua   ", -- 9 characters
    "Mang0.lua   ", -- 9 characters (repeated for symmetry)
    "Mang0.lu    ", -- 9 characters
    "Mang0.l     ", -- 9 characters
    "Mang0.      ", -- 9 characters
    "Mang0       ", -- 9 characters
    "Mang        ", -- 9 characters
    "Man         ", -- 9 characters
    "Ma          ", -- 9 characters
    "M           ", -- 9 characters
}

Main.visuals.watermark.tag.vars = {
    remove = false,
    timer = 0
}

-- Function to update and run the animation
Main.visuals.watermark.tag.run = function()
    local curtime = math.floor(globals.curtime * 2)  -- Speed control (change multiplier for faster/slower)
    
    -- Avoid redundant updates if the time hasn't changed
    if Main.visuals.watermark.tag.vars.timer ~= curtime then
        -- Get the correct frame of the animation using modulo operation
        local animation_frame = Main.visuals.watermark.tag.animation[curtime % #Main.visuals.watermark.tag.animation + 1]
        
        -- Update the timer so it only changes when curtime changes
        Main.visuals.watermark.tag.vars.timer = curtime

        -- Return the updated frame text
        return animation_frame
    end

    -- Default return in case no update is needed (keep the previous frame)
    return Main.visuals.watermark.tag.animation[Main.visuals.watermark.tag.vars.timer % #Main.visuals.watermark.tag.animation + 1]
end

Main.Items.Watermark = Main.Tabs.Misc:switch("Watermark"):tooltip("Turns on the custom watermark")
Main.Items.WatermarkType = Main.Items.Watermark:create():combo("Watermark Type", {"Static", "Dynamic"})

Main.Items.WatermarkColor = Main.Items.Watermark:create():color_picker("Watermark Color", {
	["Normal"] = {
		color(25, 25, 25, 255)
	}
})

Main.Items.WatermarkShadow = Main.Items.Watermark:create():color_picker("Watermark Shadow", {
	["Normal"] = {
		color(171, 28, 28, 255)
	}
})

Main.visuals.watermark.draw = function()
    if not Main.Items.Watermark:get() then return end

    local speed = globals.frametime * 5
    local color_ref = Main.Items.WatermarkColor:get()
    local water_shadow = Main.Items.WatermarkShadow:get()
    local pos = { x = 0, y = 0, w = 0, h = 0 }
    pos.x, pos.y = render.screen_size().x, 0

    local offset = { x = 10, y = 10 }

    pos.x = pos.x - offset.x
    pos.y = pos.y + offset.y

    local text = ''
    local Clantag_text = ''

    local username = Main.script_db.username

    -- if UI.get('watermark_name') == 'Custom' then
    --     username = UI.get('watermark_name_ref')
    -- end
    -- print(Main.visuals.watermark.tag.run())
    local Lua_Name = Main.helpers.gradient_text(200, 171, 255, 255, 90, 124, 190, 255, Main.visuals.watermark.tag.run())
    if Main.Items.WatermarkType:get() == "Static" then
        Clantag_text = Main.helpers.gradient_text(200, 171, 255, 255, 90, 124, 190, 255, Main.script_db.lua_name)
    elseif Main.Items.WatermarkType:get() == "Dynamic" then
        if Lua_Name and Lua_Name ~= "" then
            Clantag_text = Clantag_text .. Lua_Name
        end
    end

    text = text.."                "
    -- Make sure to only append if Lua_Name contains valid text (no blank updates)
    
    -- Append additional information to the text, such as version and username
    text = text .. ' [' .. Main.script_db.lua_version .. '] | ' .. username .. ' | '

    local local_time = common.get_system_time()

    local time = string.format("%02d:%02d:%02d", local_time.hours, local_time.minutes, local_time.seconds)

    local ping = globals.is_in_game and math.floor(utils.net_channel().avg_latency[1] * 1000) or 0

    text = text .. 'delay: ' .. ping .. 'ms | ' .. time

    local text_size = render.measure_text(1, '', text)

    local posx2 = pos.x
    pos.x = pos.x - text_size.x
    pos.w = text_size.x
    pos.h = 16
    local Length = 40
    local Height = 27

    -- if UI.get('ui_style') == 0 then

    -- x,y,w,h,color,rounding

    -- render.rect(vector(pos.x - 10, pos.y), vector(pos.x - 10+pos.w + 10,pos.y+pos.h + 7), color(25, 25, 25, 255), 3, false)

    Main.visuals.Frame(pos.x - Length, pos.y, pos.w + Length, Height, color_ref, 3)

    Main.visuals.Shadow(pos.x - Length - 0.1, pos.y, pos.w + Length+0.1, Height, water_shadow, 20, 0, 2)

    Main.visuals.Textlabel(pos.x - 10 + 6, pos.y + text_size.y / 2 - 1 + 2, false, text, color(255, 255, 255, 255), 1, 1)

    Main.visuals.Textlabel(pos.x - 10, pos.y + 7, false, Clantag_text, color(255, 255, 255, 255), 1, 1)

    -- local image_draw = render.load_image(network.get("https://en.neverlose.cc/static/avatars/"..common.get_username()..".png?t=1692979176"))
    
    render.texture(image_draw, vector(pos.x - 35, pos.y+3), vector(20, 20), color(255, 255, 255, 200))

    -- Main.visuals.base_render.box_filled(pos.x - 10, pos.y, pos.w + 10, { r = color_ref.r, g = color_ref.g, b = color_ref.b, a = 255 })

    -- Main.visuals.global_render.box(pos.x - 10, pos.y, pos.w + 10, { r = color_ref.r, g = color_ref.g, b = color_ref.b, a = 255 })

    -- Main.visuals.base_render.string(pos.x - 10 + 6, pos.y + text_size.y / 2 - 1, false, text, color(255, 255, 255, 255), 1, 1)
    -- elseif UI.get('ui_style') == 1 then
    --     Main.visuals.Render_engine.container(pos.x - 9, pos.y, pos.w + 9, pos.h, { r = color.r, g = color.g, b = color.b, a = 1 }, text, fonts.verdanar11.size, fonts.verdanar11.font)
    -- end
end

local Exploit = 0

local function Visuals_Createmove()
    Exploit = rage.exploit:get()
end

Main.Items.viewmodel = Main.Tabs.Misc:switch("Viewmodel Changer")

Main.Items.fov = Main.Items.viewmodel:create():slider("FOV", 0, 100, 90)
Main.Items.x = Main.Items.viewmodel:create():slider("X", - 15, 15, 0)
Main.Items.y = Main.Items.viewmodel:create():slider("Y", - 15, 15, 0)
Main.Items.z = Main.Items.viewmodel:create():slider("Z", - 15, 15, 0)

local viewmodel = function ()

    fov = Main.Items.fov:get()
    x = Main.Items.x:get()
    y = Main.Items.y:get()
    z = Main.Items.z:get()

    if Main.Items.viewmodel:get() then
        cvar["sv_competitive_minspec"]:int(0)
        cvar["viewmodel_fov"]:float(fov)
        cvar["viewmodel_offset_x"]:float(x)
        cvar["viewmodel_offset_y"]:float(y)
        cvar["viewmodel_offset_z"]:float(z)
    else
        cvar["sv_competitive_minspec"]:int(1)
        cvar["viewmodel_fov"]:string("def.")
        cvar["viewmodel_offset_x"]:string("def.")
        cvar["viewmodel_offset_y"]:string("def.")
        cvar["viewmodel_offset_z"]:string("def.")
    end

end

local font = render.load_font("c:/windows/fonts/calibrib.ttf", 28, "ad")
local alpha = 255

local function Visuals_Indicator()
    if not Main.Items.CE:get() then return end
    local localplayer = entity.get_local_player()
    local screen_size = Main.helpers.screen_size
    local DoubleTap = Menu_neverlose.ref.ragebot.dt:get()
    local HS = Menu_neverlose.ref.ragebot.hs:get()
    local FD = Menu_neverlose.ref.antiaim.fd:get()

    local x, y = render.screen_size().x, render.screen_size().y

    local localplayer = entity.get_local_player()
    if not localplayer then return end
    
    local exploit_color = (rage.exploit:get() == 1) and color("#cccccd") or color(255,0,0,255)
    local slowdown = entity.get_local_player().m_flVelocityModifier
    local fade_factor = ((1 / .15) * globals.frametime) * 255

    local vel = localplayer.m_vecVelocity
    local speed = math.sqrt(vel.x * vel.x + vel.y * vel.y)


    if localplayer:is_alive() then
        if (slowdown == 1 and alpha ~= 0) then
            alpha = easing:clamp(alpha - fade_factor, 0, 255) 
        elseif (slowdown ~= 1 and alpha ~= 255) then
            alpha = easing:clamp(alpha + fade_factor, 0, 255)
        end
    else
        alpha = 0
    end

    local offset = 1

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

    render.shadow(vector(x/2 - 120,y / 2 - 333), vector(x/2 + 120,y / 2 - 325), color(76, 159, 242, alpha),20,0,1)
    render.rect_outline(vector(x/2 - 120,y / 2 - 333), vector(x/2 + 120,y / 2 - 325), color(0,0,0, alpha), 1.2)
    render.rect(vector(x/2 - 119,y / 2 - 332), vector(x/2 + slowdown * (119 - (-119)) + (-119) ,y / 2 - 326), color(168, 151, 205, alpha))
    render.text(1, vector(x / 2, y / 2 - 345), color(255,255,255,alpha), "c", "\a698EFFFF" .. ui.get_icon("triangle-exclamation") .. " Slowed Down: " .. math.floor(slowdown * 100 + 0.5) .. "%")

    
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
            Main.visuals.base_render.string(pos.x, pos.y + DTX, false, Text.OnShot, color(14,155,195,255), 1, 1)
        end
    end

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

Main.Items.Debug = Main.Tabs.RageMisc:switch("\a698EFFFF" .. ui.get_icon("triangle-exclamation") .. " Debug Mode")

local debug_mode = function()

    if not Main.Items.Debug:get() then return end


    local elements = {
        ["Feet Yaw"] = true, --Main.Items.Debuglist:get("Feet Yaw"),
        ["Choked Commands"] = true, --Main.Items.Debuglist:get("Choked Commands"),
        ["Real Yaw"] = true, --Main.Items.Debuglist:get("Real Yaw"),
        ["Abs Yaw"] = true, --Main.Items.Debuglist:get("Abs Yaw"),
        ["Desync"] = true, --Main.Items.Debuglist:get("Desync"),
    }

    local x,y = render.screen_size().x,render.screen_size().y

    if not entity.get_local_player() then return end
    if not globals.is_in_game or not globals.is_connected then return end
    local DesyncAngle = math.ceil(math.abs(normalize_yaw(entity.get_local_player():get_anim_state().eye_yaw % 360 - math.floor(entity.get_local_player():get_anim_state().abs_yaw) % 360)))

    local position2 = vector(x-1530,y-710)
    render.rect(vector(290, 385), position2, color(25,25,25,100), 10, false) -- color: color[, rounding: number, no_clamp: boolean]
    

    local i = 0
    for element, value in pairs(elements) do
        if value then
            local position = vector(300, y - 800 + (15 * i))
            local text = ""
            
            if element == "Feet Yaw" then
                text = "Feet Yaw: " .. math.floor(entity.get_local_player().m_flPoseParameter[11] == nil and 0 or entity.get_local_player().m_flPoseParameter[11] * 120 - 60) or "Unknown ?"
            elseif element == "Choked Commands" then
                text = "Choke: " .. globals.choked_commands
            elseif element == "Real Yaw" then
                text = "Real yaw: " .. math.floor(entity.get_local_player():get_anim_state().eye_yaw)
            elseif element == "Abs Yaw" then
                text = "Abs yaw: " .. math.floor(entity.get_local_player():get_anim_state().abs_yaw)
            elseif element == "Desync" then
                text = "Desync: " .. DesyncAngle
            end
            render.text(1, position, color(255, 255, 255), "", text)
            i = i + 1
        end
    end

    

end


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


ui.sidebar(Main.helpers.gradient_text(200, 171, 255, 255, 90, 124, 190, 255, Main.script_db.lua_name), 'user-shield')

-- common.add_notify("Hello, " .. common.get_username() .. "!","\aFFFFFFFFWelcome back to "..Main.script_db.lua_name.."!")

if not _G.Sesion_Time then
    _G.Sesion_Time = 0
end

-- Setup_welcome:label("\aFFFFFFFFBuild \a858585FF» \aFCCDFFFF" ..script_db.lua_version)
Setup_welcome:label("Welcome, "..Main.helpers.RGBToColorString(Main.script_db.username, color(130, 95, 208, 255)).. "!") --\aA9ACFFFF
Setup_welcome:label(Main.script_db.lua_name.." » "..Main.helpers.RGBToColorString(Main.script_db.lua_version, color(130, 95, 208, 255)).. " Live Build")
local SesionTime = Setup_welcome:label("Session Time » " .. _G.Sesion_Time .. " ")

Setup_Updates:label([[
]]..Main.helpers.gradient_text(200, 171, 255, 255, 90, 124, 190, 255, "Update Log! [Version ".. Main.script_db.script_version.."]")..[[


- Updated Anti-Aim
- Added Anti-Head
- Fixed Som visuals
- Fixed Clan Tag
- Added Viewmodel Changer
- Added Debug Mode
- Added Silent Shots
- Added Manual AA
- Updated Watermark

- To do List
    - Better Visuals
    - Hit marker
    - Hit logs

]])


local function FormatTime(seconds)
    local timeString = ""
    
    if seconds < 60 then
        timeString = seconds .. " "
    elseif seconds < 3600 then
        local minutes = math.floor(seconds / 60)
        local sec = seconds % 60
        timeString = minutes .. " min" .. (sec > 0 and (" " .. sec .. " ") or "")
    elseif seconds < 86400 then
        local hours = math.floor(seconds / 3600)
        local minutes = math.floor((seconds % 3600) / 60)
        timeString = hours .. " hour" .. (hours > 1 and "s" or "") .. (minutes > 0 and (" " .. minutes .. " min") or "")
    else
        local days = math.floor(seconds / 86400)
        local hours = math.floor((seconds % 86400) / 3600)
        timeString = days .. " day" .. (days > 1 and "s" or "") .. (hours > 0 and (" " .. hours .. " hour" .. (hours > 1 and "s" or "")) or "")
    end
    
    return timeString
end

local function Update_SesionTime()
    wait({
        time=1,
        flag="SesionTime",
        Number=0.008,
        callback = function()
            _G.Sesion_Time = _G.Sesion_Time + 1
            SesionTime:name("Session Time » " .. FormatTime(_G.Sesion_Time))
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

local CFG_load = cfgsys:button(ui.get_icon('check').."     Load Config     "):tooltip("Will load the selected config\n\n"..Main.helpers.RGBToColorString("This will override any unsaved settings.", color(50, 25, 255, 255)))
local CFG_save = cfgsys:button(ui.get_icon('floppy-disk').."      Save Config      "):tooltip("Will save the settings to the selected config.")
local export_cfg = cfgsys:button(ui.get_icon('upload').."   Export Config    "):tooltip("Config will be coppied to your clipboard.")
local import_cfg = cfgsys:button(ui.get_icon('download').."  Import Config   "):tooltip(ui.get_icon("triangle-exclamation").."This will override the current config! \n\n"..Main.helpers.RGBToColorString("Make a new config if needed", color(50, 25, 255, 255)))

local CFG_delete = cfgsys:button(ui.get_icon('trash')):tooltip(ui.get_icon("triangle-exclamation").." Deleted Selected Config This will add a extra check before deleting.")
local CFG_ConfirmDeletion_Yes = cfgsys:button(ui.get_icon('check')):visibility(false)
local CFG_ConfirmDeletion_No = cfgsys:button(" X "):visibility(false)


local function decode(data)
    return Base64.decode(data)
end

local function encode(data)
    return Base64.encode(data)
end


local Base64_Decode = cfgsys:button(ui.get_icon('code')):tooltip('Decode')
local Base64_Encode = cfgsys:button(ui.get_icon('upload')):tooltip('Encode')

Base64_Decode:set_callback(function()
clipboard.set(clipboard.get())
common.add_notify(Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155,155,255,255)), "Successfully Decoded!")
end, false)

Base64_Encode:set_callback(function()
clipboard.set(clipboard.get())
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
    clipboard.set(encode(files.read(Configs_Path.."\\"..GetCFGS(Configs:get())..".lua")))
end



function config_load(text, is_import, CFN)
    local CFN = CFN or ''
    local is_import = is_import or false
    local config_load_func = {}
    config_load_func.state = true
    local text = text

    if text:sub(1, 8) ~= "--Mang0 " then
        common.add_notify(
            "Config ~ Error",
            Main.helpers.RGBToColorString("Invalid config: Missing --Mang0 tag.", color(255, 50, 25, 255))
        )
        error("Invalid config: Missing --Mang0 tag.")
        return nil
    end

    if config_load_func.state then
        if is_import == true then
            common.add_notify(
                Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155, 155, 255, 255)),
                "New Config Has been imported to " ..
                Main.helpers.RGBToColorString(GetCFGS(Configs:get()), color(122, 122, 255, 255))
            )
        elseif is_import == 'NONE' then
            common.add_notify(
                Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155, 155, 255, 255)),
                Main.helpers.RGBToColorString(CFN, color(122, 122, 255, 255)) .. " New Config!"
            )
        elseif is_import == false then
            common.add_notify(
                Main.helpers.RGBToColorString(Main.script_db.lua_name, color(155, 155, 255, 255)),
                Main.helpers.RGBToColorString(GetCFGS(Configs:get()), color(122, 122, 255, 255)) .. " has been Loaded!"
            )
        end

        -- Decode the config text
        local decoded_text = Base64.decode(text)
        local cfg_data = json.parse(decoded_text)
        
        -- If decoding and parsing were successful, load the config
        if cfg_data ~= nil then
            for key, value in pairs(cfg_data) do
                local item = Main.Items[key]
                if item ~= nil then
                    local invalue = value
                    item:set(invalue)
                end
            end
        else
            error("Failed to load config: Invalid data format.")
        end
    end

    return config_load_func
end

local Clean_Cfg = [[{}]]

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
        local encoded_config = json_config --encode(json_config)
        files.write(Configs_Path.."\\"..CFG_Name:get()..".lua", encoded_config)
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
    local encoded_config = json_config --encode(json_config)
    files.write(Configs_Path.."\\"..GetCFGS(Configs:get())..".lua", encoded_config)
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


Main.Items.Aspect_Ratio = Main.Tabs.Misc:slider("Aspect Ratio", 0, 60, 0, 1)

function Main_CM(cmd)
    no_fall_damage(cmd)
    Randomize_DT_Ticks(cmd)
    -- defensive_aa(cmd)
    Visuals_Createmove()
    fastladder(cmd)
    fix_nade()
    AntiAim_createmove(cmd)
    fix_fakeduck()
    Rand_Multipoint()
    manual_aa()
    Enemy_Anti_Head()
    cvar.r_aspectratio:float(Main.Items.Aspect_Ratio:get() / 10)
end

function Main_Render(cmd)
    Main.visuals.watermark.draw()
    draw_scope_lines()
    Visibility_easy()
    Visuals_Indicator()
    Update_SesionTime()
    debug_mode()
    viewmodel()
    clantag.run()
    -- Clan_tag()
    -- window_title()
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

once_callback = function()
    always_choke_slient_shots()
end

once_callback()

end
