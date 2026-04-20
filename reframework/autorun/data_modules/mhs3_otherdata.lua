-- MHS3 other data module v1.0 by NidhoggX
-- Implemented: get_setting()
-- TODO: get other fields, full list under "Functions to get game data"

-- ==========================================
-- Establish as module
-- ==========================================

if otherdata then return end -- Avoid loading module twice
otherdata = {} -- Stores module functions

-- ==========================================
-- Create logging functions
-- ==========================================

local MOD_NAME = "[MHS3 OTHER DATA MODULE]"
local function log_info(msg) log.info(MOD_NAME .. " " .. msg) end
local function log_error(msg) log.error(MOD_NAME .. " " .. msg) end

-- ==========================================
-- Variables and config
-- ==========================================

local hooks_installed = false

-- ==========================================
-- Functions to get game data
-- ==========================================

function otherdata.get_setting()
    -- Gets the _Setting field from the VariousDataManager
    -- Returns:
    --  app.user_data.VariousDataManagerSetting: the game data

    -- Get the singleton
    local ok_manager, manager = pcall(sdk.get_managed_singleton, "app.VariousDataManager")
    if not ok_manager or not manager then
        log_error("[get_setting()] Failed to load app.VariousDataManager")
        return nil
    else
        log_info("[get_setting()] Successfully retrieved the app.VariousDataManager singleton")
    end

    -- Get the field
    local ok_setting, setting = pcall(manager.get_field, manager, "_Setting")
    if not ok_setting or not setting then
        log_error("[get_setting()] Failed to load _Setting field")
        return nil
    else
        log_info("[get_setting()] Successfully retrieved the _Setting field")
    end

    return setting
end

-- get_player_data()
-- get_equip_data()
-- get_partner_data()
-- get_enemy_data()
-- get_level_data()
-- get_gene_data()