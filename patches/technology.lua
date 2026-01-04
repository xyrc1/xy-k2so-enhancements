local t = data.raw.technology

local function add_preqs(tech, preqs)
    for _,v in pairs(preqs) do
        table.insert(t[tech].prerequisites, v)
    end
end

if settings.startup['xy-paracelsin-tech-card'].value then
    if settings.startup['xy-paracelsin-tech-card-endgame'].value and mods['Paracelsin'] then
        table.insert(t['kr-singularity-lab'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-antimatter-ammo'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-antimatter-reactor'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-antimatter-reactor-equipment'].unit.ingredients, {'galvanization-science-pack', 1})
        table.insert(t['kr-intergalactic-transceiver'].unit.ingredients, {'galvanization-science-pack', 1})
    end

    if settings.startup['xy-lab-recipe-changes'].value and mods['planet-muluna'] then
        table.insert(t['cryolab'].unit.ingredients, {'galvanization-science-pack', 1})
    end
end

if settings.startup['xy-advanced-tank-expensive-research'].value then
    t['kr-advanced-tank'].unit.count = 2500
    table.insert(t['kr-advanced-tank'].unit.ingredients, {'metallurgic-science-pack', 1})
    table.insert(t['kr-advanced-tank'].unit.ingredients, {'agricultural-science-pack', 1})
    table.insert(t['kr-advanced-tank'].unit.ingredients, {'electromagnetic-science-pack', 1})
    add_preqs('kr-advanced-tank', {'metallurgic-science-pack','agricultural-science-pack','electromagnetic-science-pack'})
end

if settings.startup['xy-tech-inflation'].value then
    -- increase the cost of all mid-late-endgame techs, starting after the first three vanilla planets
    -- does not affect Moshine as that is unrelated

    local settings_post_multi = 1 -- worst var name ever
    local hardcoded_multi = { -- overrides the sweeping changes
        ['planet-discovery-aquilo'] = 8,
        ['planet-discovery-maraxsis'] = 8,
        ['planet-discovery-paracelsin'] = 8,
        ['planet-discovery-moshine'] = 4,
        ['planet-discovery-secretas'] = 30,
        ['legendary-quality'] = 15,
        ['quantum-processor'] = 30,
        ['kr-intergalactic-transceiver'] = 50, -- vanilla megabase could still do this in 5 minutes lol
        ['kr-advanced-card'] = 2,
        ['biolab'] = 2,
    }
    local general_multi = { -- only applies the highest value, will make this a setting eventually but might be clutter? could organize into sections
        ['promethium-science-pack'] = 25,
        ['golden-science-pack'] = 20,
        ['kr-singularity-tech-card'] = 15,
        ['kr-matter-tech-card'] = 10,
        ['cryogenic-science-pack'] = 6,
        ['galvanization-science-pack'] = 6,
        ['hydraulic-science-pack'] = 6,
        ['kr-advanced-tech-card'] = 2,
        ['MAE-cards'] = 5,
    }
    if settings.startup['xy-tech-inflation-scale'].value ~= '100%' then -- dumb but it works so whatever
        if settings.startup['xy-tech-inflation-scale'].value == '50%' then
            settings_post_multi = .5
        elseif settings.startup['xy-tech-inflation-scale'].value == '75%' then
            settings_post_multi = .75
        end
    end


    for _,tech in pairs(t) do
        if (tech.upgrade) or (not tech.unit) or (not tech.unit.count) then goto continue end

        if hardcoded_multi[tech.name] then
            tech.unit.count = math.ceil(tech.unit.count * hardcoded_multi[tech.name] * settings_post_multi)
        else
            -- general application
            local used_cards = {}
            local highest_multi = 1
            local MAE = 0 -- as in metallurgic, agricultural, and electromagnetic science. count up and if this is three then apply
            for _,card in pairs(tech.unit.ingredients) do
                table.insert(used_cards, card[1]) -- 1-indexed lists
            end
            for _,v in pairs(used_cards) do
                if v == 'agricultural-science-pack' or v == 'metallurgic-science-pack' or v == 'electromagnetic-science-pack' then
                    MAE = MAE + 1
                end
                local card_multi = general_multi[v] or -1
                if highest_multi < card_multi then
                    highest_multi = card_multi
                end
            end
            if highest_multi == 1 and MAE == 3 then
                highest_multi = general_multi['MAE-cards']
            end
            if highest_multi ~= 1 then
                tech.unit.count = math.ceil(tech.unit.count * highest_multi * settings_post_multi)
            end
        end

        ::continue::
    end
end