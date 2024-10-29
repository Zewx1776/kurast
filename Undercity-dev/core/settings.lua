local gui = require "gui"

local settings = {
    enabled = false,
    path_angle = 10,
    elites_only = false,
    melee_logic = false
}

function settings:update_settings()
    settings.enabled = gui.elements.main_toggle:get()
end

return settings