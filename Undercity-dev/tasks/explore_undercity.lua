local utils = require "core.utils"
local enums = require "data.enums"
local explorer = require "core.explorer"

local task  = {
    name = "Explore Undercity",
    shouldExecute = function()
        return utils.player_in_find_zone(enums.zone_names.undercity_zone) and utils.player_on_find_quest(enums.quest_names.undercity_quest)
    end,
    Execute = function()
        explorer.enabled = true
    end
}
return task
