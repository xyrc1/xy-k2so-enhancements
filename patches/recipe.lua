-- Corrundum - add Processing Unit Recipe (Rare Metals > Platinum)
if mods['corrundum'] and settings.startup['xy-corrundum-processing-unit'].value then
    local platinum_pru = table.deepcopy(data.raw["recipe"]["processing-unit"])
    platinum_pru.name = 'platinum-processing-unit'
    platinum_pru.main_product = 'processing-unit'
    platinum_pru.icons = {
        {
            icon = "__base__/graphics/icons/processing-unit.png",
            icon_size = 64,
            scale = 0.65,
            shift = { 2, 2 },
            draw_background = true,
        },
        {
            icon = "__corrundum__/graphics/icons/platinum-plate.png",
            icon_size = 64,
            scale = 0.45,
            shift = { -11, -11 },
            draw_background = true,
        }
    }
    platinum_pru.category = 'electronics-with-fluid'
    platinum_pru.enabled = false
    platinum_pru.ingredients = {
        {type = "item", name = "platinum-plate", amount = 3},
        {type = "item", name = "advanced-circuit", amount = 6},
        {type = 'fluid', name = 'sulfuric-acid', amount = 10}
    }
    data:extend{platinum_pru}
    table.insert(data.raw.technology['platinum-processing'].effects, {
        type = 'unlock-recipe', recipe = 'platinum-processing-unit'
    })
end