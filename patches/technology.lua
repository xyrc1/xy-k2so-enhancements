local t = data.raw.technology
if settings.startup['xy-paracelsin-tech-card'].value then
    if settings.startup['xy-paracelsin-tech-card-endgame'].value and mods['Paracelsin'] then
        table.insert(t['kr-singularity-lab'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-antimatter-ammo'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-antimatter-reactor'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-antimatter-reactor-equipment'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-intergalactic-transceiver'].unit.ingredients, {'galvanization-science-pack', 1})
    end

    if settings.startup['xy-lab-recipe-changes'].value then
        table.insert(t['cryolab'].unit.ingredients, {'galvanization-science-pack', 1})
    end
end

