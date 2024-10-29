local gui = {}
local developer_id = "TesXter"
local script_name = "Undercity"
local code_name = get_hash(developer_id .. "_" .. script_name)
local version = "0.2"

local function create_checkbox(key)
    return checkbox:new(false, get_hash(code_name .. "_" .. key))
end

gui.elements = {
    main_tree = tree_node:new(0),
    main_toggle = create_checkbox("main_toggle"),
}

function gui.render()
    if not gui.elements.main_tree:push(script_name .. " | " .. developer_id .. " | V" .. version) then return end

    gui.elements.main_toggle:render("Enable", "")
    if not gui.elements.main_toggle:get() then
        gui.elements.main_tree:pop()
        return
    end

    gui.elements.main_tree:pop()
end

return gui
