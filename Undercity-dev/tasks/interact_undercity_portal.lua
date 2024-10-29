local utils = require "core.utils"
local explorer = require "core.explorer"
local enums = require "data.enums"

local portal_interaction_time = 0

local function is_interactable_portal(portal)
    local name = portal:get_skin_name()
    return name == enums.portal_names.undercity_portal or 
           name == enums.portal_names.undercity_portal_floor
end

local task = {
    name = "Interact Undercity Portal",
    shouldExecute = function()
        return utils.get_undercity_portal() and 
               utils.player_in_find_zone(enums.zone_names.undercity_zone) and 
               utils.player_on_find_quest(enums.quest_names.undercity_quest)
    end,
    Execute = function()
        -- Get all portals
        local actors = actors_manager:get_all_actors()
        local interactable_portal = nil
        local warp_pad = nil
        
        -- Find both types of portals
        for _, actor in pairs(actors) do
            local name = actor:get_skin_name()
            if is_interactable_portal(actor) then
                interactable_portal = actor
                break
            elseif name == enums.portal_names.undercity_warp_pad then
                warp_pad = actor
            end
        end
        
        -- Prioritize interactable portal if found
        local target = interactable_portal or warp_pad
        if target then
            if utils.distance_to(target) < 2 then
                if is_interactable_portal(target) then
                    interact_object(target)
                    console.print("Interacting with portal")
                end
            else
                explorer:clear_path_and_target()
                explorer:set_custom_target(target:get_position())
                explorer:move_to_target()
                console.print("Moving to " .. (is_interactable_portal(target) and "portal" or "warp pad"))
            end
        end
    end
}
return task
