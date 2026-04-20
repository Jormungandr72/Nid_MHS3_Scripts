-- MHS3 generic fetch module v1.0 by NidhoggX
-- Implemented:
-- TODO:

-- ==========================================
-- Establish as module
-- ==========================================

if genericfetch then return end -- Avoid loading module twice
genericfetch = {} -- Stores module functions

-- ==========================================
-- Create logging functions
-- ==========================================

local MOD_NAME = "[MHS3 GENERICFETCH MODULE]"
local function log_info(msg) log.info(MOD_NAME .. " " .. msg) end
local function log_error(msg) log.error(MOD_NAME .. " " .. msg) end

-- ==========================================
-- Variables and config
-- ==========================================

local hooks_installed = false

local example_data = {
    "app.SaveDataManager", -- Singleton
    "_UserSaveData", -- Every field on the path to the target field
    "_UserRelay" -- Target field
}

-- ==========================================
-- Variables and config
-- ==========================================

function genericfetch.fetch_field(data_table)
    -- Gets a specified field from the game. 
    -- See the example_data table in this file for reference on formatting.
    -- Arguments:
    --   data_table (table): a table starting with a singleston string and ending with a target field
    --   target ([varies]): the field to return
    -- Returns:
    --   [varies]: the data type of the target field

    -- Get the singleton
    local ok_single, single = pcall(sdk.get_managed_singleton, data_table[1]) -- lua tables start at index 1
    if not ok_single or not single then
        log_error("[fetch_field()] Unable to retrieve the following singleton: " .. data_table[1])
        return nil
    else
        log_info("[fetch_field()] Retrieved the following singleton: " .. data_table[1])
    end

    -- Loop through table until hitting target
    local i = 2 -- Start index after singleton
    local ok, ret_field = nil, single
    while data_table[i] do
        ok, ret_field = pcall(ret_field.get_field, ret_field, data_table[i])
        if not ok or not ret_field then
            log_error("[fetch_field()] Unable to retrieve the following field: " .. data_table[i])
            return nil
        else
            log_info("[fetch_field()] Retrieved the following field: " .. data_table[i])
        end
        i = i + 1
    end

    -- Return the target field
    return ret_field
end