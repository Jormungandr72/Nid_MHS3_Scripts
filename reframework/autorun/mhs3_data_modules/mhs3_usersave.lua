-- MHS3 user save data module v1.0 by NidhoggX
-- Implemented:
-- TODO: get other fields, full list under "Functions to get user data"

-- ==========================================
-- Establish as module
-- ==========================================

if usersave then return end -- Don't load the same module twice
usersave = {} -- Stores module functions

-- ==========================================
-- Create logging functions
-- ==========================================

local MOD_NAME = "[MHS3 USER SAVE MODULE]"
local function log_info(msg) log.info(MOD_NAME .. " " .. msg) end
local function log_error(msg) log.error(MOD_NAME .. " " .. msg) end

-- ==========================================
-- Variables and config
-- ==========================================

local hooks_installed = false

-- ==========================================
-- Functions to get user data
-- ==========================================

function usersave.get_relay()
    -- Gets the user save data, stored in variable "_UserRelay"
    -- Returns:
    --   app.savedata.cUserSaveDataParam: the user save data

    -- Get the SaveDataManager singleton
    local ok_manager, manager = pcall(sdk.get_managed_singleton, "app.SaveDataManager")
    if not ok_manager or not manager then
        log_error("[get_relay()] Unable to retrieve the following singleton: app.SaveDataManager")
        return nil
    else
        log_info("[get_relay()] Retrieved the following singleton: app.SaveDataManager")
    end

    -- Get the _UserSaveData field
    local ok_save, save = pcall(sdk.get_field, "_UserSaveData")
    if not ok_save or not save then
        log_error("[get_relay()] Unable to retrieve the following field: _UserSaveData")
        return nil
    else
        log_info("[get_relay()] Retrived the following field: _UserSaveData")
    end

    -- Get the _UserRelay field
    local ok_relay, relay = pcall(sdk.get_field, "_UserRelay")
    if not ok_relay or not relay then
        log_error("[get_relay()] Unable to retrieve the following field: _UserRelay")
        return nil
    else
        log_info("[get_relay()] Retrived the following field: _UserRelay")
    end

    return relay
end

-- get_story_param()
-- get_item_param()
-- get_player_param()
-- get_equip_param()
-- get_otomon_param()
-- get_shop_param()
-- get_battle_param()
-- get_egg_Param()
-- get_area_param()
-- get_field_param()
-- get_region_param()
-- get_partner_param()
-- get_otomon_type_param()
-- get_weapon_type_param()

