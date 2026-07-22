NativeMenu = {}
local menus = {}

function NativeMenu.CloseAll()
    menus = {}
    lib.hideContext()
end

function NativeMenu.Open(menuType, _, name, data, submit, cancel)
    if menuType == 'dialog' then
        local result = lib.inputDialog(data.title or 'Entrada', {{ type = 'input', label = data.title or 'Valor' }})
        if result then submit({ value = result[1] }, { close = function() end }) else cancel({}, { close = function() end }) end
        return
    end
    local menu = { close = function() menus[name] = nil; lib.hideContext() end }
    menus[name] = menu
    local options = {}
    for _, element in ipairs(data.elements or {}) do
        options[#options + 1] = { title = element.label, onSelect = function() submit({ current = element }, menu) end }
    end
    lib.registerContext({ id = 'fixlife_prision_' .. name, title = data.title or name, options = options })
    lib.showContext('fixlife_prision_' .. name)
end
