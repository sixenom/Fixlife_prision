local appearanceResource = 'illenium-appearance'

local function getAppearance()
    if GetResourceState(appearanceResource) ~= 'started' then return nil end
    return exports[appearanceResource]:getPedAppearance(PlayerPedId())
end

local function componentValue(components, id)
    local item = components and components[id + 1]
    return item and item.drawable or 0, item and item.texture or 0
end

local function propValue(props, id)
    for i = 1, #(props or {}) do
        if props[i].prop_id == id then return props[i].drawable, props[i].texture end
    end
    return -1, 0
end

local function applyLegacyClothes(clothes)
    if type(clothes) ~= 'table' or GetResourceState(appearanceResource) ~= 'started' then return end

    if clothes.components then
        exports[appearanceResource]:setPedAppearance(PlayerPedId(), clothes)
        return
    end

    local ped = PlayerPedId()
    local current = exports[appearanceResource]:getPedAppearance(ped) or {}
    local function component(id, drawable, texture)
        local oldDrawable, oldTexture = componentValue(current.components, id)
        return { component_id = id, drawable = drawable ~= nil and drawable or oldDrawable, texture = texture ~= nil and texture or oldTexture }
    end
    local function prop(id, drawable, texture)
        local oldDrawable, oldTexture = propValue(current.props, id)
        return { prop_id = id, drawable = drawable ~= nil and drawable or oldDrawable, texture = texture ~= nil and texture or oldTexture }
    end

    exports[appearanceResource]:setPedComponents(ped, {
        component(0),
        component(1, clothes.mask_1, clothes.mask_2),
        component(2),
        component(3, clothes.arms, clothes.arms_2),
        component(4, clothes.pants_1, clothes.pants_2),
        component(5, clothes.bags_1, clothes.bags_2),
        component(6, clothes.shoes_1, clothes.shoes_2),
        component(7, clothes.chain_1, clothes.chain_2),
        component(8, clothes.tshirt_1, clothes.tshirt_2),
        component(9, clothes.bproof_1, clothes.bproof_2),
        component(10, clothes.decals_1, clothes.decals_2),
        component(11, clothes.torso_1, clothes.torso_2)
    })
    exports[appearanceResource]:setPedProps(ped, {
        prop(0, clothes.helmet_1, clothes.helmet_2),
        prop(1, clothes.glasses_1, clothes.glasses_2),
        prop(2, clothes.ears_1, clothes.ears_2),
        prop(6, clothes.watches_1, clothes.watches_2),
        prop(7, clothes.bracelets_1, clothes.bracelets_2)
    })
end

RegisterNetEvent('skinchanger:getSkin', function(callback)
    local skin = getAppearance()
    if not skin then return end

    skin.sex = GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') and 1 or 0
    callback(skin)
end)

RegisterNetEvent('skinchanger:loadClothes', function(_, clothes)
    applyLegacyClothes(clothes)
end)

RegisterNetEvent('skinchanger:loadSkin', function(skin)
    if type(skin) == 'table' and skin.components and GetResourceState(appearanceResource) == 'started' then
        exports[appearanceResource]:setPedAppearance(PlayerPedId(), skin)
    end
end)
