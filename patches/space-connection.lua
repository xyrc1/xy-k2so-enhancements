local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

if mods['Moshine'] and settings.startup['xy-moshine-connection-length'].value then
    -- Remove the Nauvis > Moshine connection
    data.raw['space-connection']['nauvis-moshine'].length = 25000
    -- Increase the Vulcanus > Moshine distance to something more reasonable, but shorter than average
    data.raw['space-connection']['vulcanus-moshine'].length = 10000

    if mods['maraxsis'] and settings.startup['xy-maraxsis-moshine-connection'].value then
        data:extend{{
            type = 'space-connection',
            name = 'moshine-maraxsis',
            subgroup = 'planet-connections',
            from = 'moshine',
            to = 'maraxsis',
            order = 'n',
            length = 15000,
            asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.gleba_aquilo),
        }}
    end
end
