local utils = require "core.utils"
local enums = require "data.enums"
local tracker = require "core.tracker"
local explorer = require "core.explorer"

local portal_interaction_time = 0

local task = {
    name = "Enter Portal",
    shouldExecute = function()
        local portal = utils.get_undercity_portal()
        return utils.get_undercity_portal()
    end,
    Execute = function()
        local portal = utils.get_undercity_portal()
        if portal then
            local player_in_naha = utils.player_in_zone(enums.zone_names.naha_zone)
            if player_in_naha then
                interact_object(portal)
                tracker.start_location_reached = false
                portal_interaction_time = get_time_since_inject()
                explorer.reset_exploration()

                -- Add the 5-second timer check
                local current_time = get_time_since_inject()
                if portal_interaction_time > 0 and current_time - portal_interaction_time < 5 then
                    console.print("Waiting for 5 seconds after portal interaction...")
                    return
                else
                    portal_interaction_time = 0
                end
            else
                console.print("Player is not in Naha. Using regular interact_object.")
            end
        end
    end
}

return task