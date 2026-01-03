-- If installed, group all dedicated science manufactories into the science tab
-- also labs
data:extend({
    {
    type = 'item-subgroup',
    group = 'science',
    name = 'xy-science-production',
    order = 'aa',
    },
})

if mods['science-tab'] and settings.startup['xy-move-lab-category'].value then
    data.raw['item-subgroup']['lab'].group = 'science'
    data.raw['item-subgroup']['lab'].order = '00000'
end
