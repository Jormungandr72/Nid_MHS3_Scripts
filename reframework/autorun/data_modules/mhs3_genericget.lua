-- MHS3 generic fetch module v1.0 by NidhoggX
-- Implemented: generic_field(), generic_method(), clear_cache()

-- ==========================================
-- Establish as module
-- ==========================================

if genericget then return end -- Avoid loading module twice
genericget = {} -- Stores module functions

-- ==========================================
-- Create logging functions
-- ==========================================

local MOD_NAME = "[MHS3 GENERICGET MODULE]"
local function log_info(msg) log.info(MOD_NAME .. " " .. msg) end
local function log_error(msg) log.error(MOD_NAME .. " " .. msg) end

-- ==========================================
-- Variables and config
-- ==========================================

genericget.cache = {} -- Map of strings to methods/fields
local hooks_installed = {} -- Map of hooked methods to booleans
local example_data = {
    "app.SaveDataManager", -- Singleton
    "_UserSaveData", -- One entry per field on the path to the target field
    "_UserRelay" -- Target field
}

-- ==========================================
-- Variables and config
-- ==========================================

function genericget.generic_field(data_table)
    -- Gets a specified field from the game. 
    -- See the example_data table in this file for reference on formatting.
    -- Arguments:
    --   data_table (table): a table starting with a singleston string and ending with a target field
    --   target (REField): the field to return
    -- Returns:
    --   REField: the data type of the target field

    -- Get the singleton
    local ok_single, single = pcall(sdk.get_managed_singleton, data_table[1]) -- lua tables start at index 1
    if not ok_single or not single then
        log_error("[generic_field()] Unable to retrieve the following singleton: " .. data_table[1])
        return nil
    else
        log_info("[generic_field()] Retrieved the following singleton: " .. data_table[1])
    end

    -- Loop through table until hitting target
    local i = 2 -- Start index after singleton
    local ok, ret_field = nil, single
    while data_table[i] do
        ok, ret_field = pcall(ret_field.get_field, ret_field, data_table[i])
        if not ok or not ret_field then
            log_error("[generic_field()] Unable to retrieve the following field: " .. data_table[i])
            return nil
        else
            log_info("[generic_field()] Retrieved the following field: " .. data_table[i])
        end
        i = i + 1
    end

    -- Reset index to nth element
    i = i - 1
    -- Cache and return the target field
    genericget.cache[data_table[i]] = ret_field -- Last item in data table
    log_info("[generic_field()] Cached the following field: " .. data_table[i])
    log_info("[generic_field()] Returning the following field: " .. data_table[i])
    return ret_field
end

function genericget.generic_method(obj, method_name)
    -- Gets a specified method from the game.
    -- Arguments:
    --   obj (REField): the object that the method belongs to
    --   method_name (String): a string representing the name of the method
    -- Returns:
    --   REMethod: the data type of the target method

    -- Get the method
    local ok_method, method = pcall(obj.get_method, obj, method_name)
    if not ok_method or not method then
        log_error("[generic_field()] Unable to retrieve the following method: " .. method_name .. "()")
        return nil
    else
        log_info("[generic_field()] Retrieved the following method: " .. method_name .. "()")
    end

    -- Cache and return the target field
    genericget.cache[method_name] = method
    log_info("[generic_field()] Cached the following method: " .. method_name .. "()")
    log_info("[generic_field()] Returning the following method: " .. method_name .. "()")
    return method
end

function genericget.clear_cache()
    -- Resets every key in the cache to nil, clearing it.

    for k in pairs(genericget.cache) do
        genericget.cache[k] = nil
    end
    log_info("[clear_cache()] Cleared cache")
end

-- ==========================================
-- Clear cache when REFramework saves it's config
-- ==========================================

re.on_config_save(genericget.clear_cache)