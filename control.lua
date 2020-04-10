local function worth_processing( player )
  return player.valid and player.connected 
     and not player.vehicle
     and player.selected
     and player.character and player.character.valid
     and not player.walking_state.walking
end

local atan2     , pi     , floor
    = math.atan2, math.pi, math.floor

local function orient_players( event )
  if event.tick % 10 == 0 then

    for _, player in pairs( game.players ) do
      if worth_processing( player ) then

        local location = player.position          
        local target   = player.selected.position 

        local angle = atan2(location.y - target.y, location.x - target.x)
              angle = (angle/pi + 1)*4 - 5.5
              angle = angle <  0 and angle + 8 or angle
              angle = angle >= 8 and angle - 8 or angle

        player.character.direction = floor(angle)

      end
    end

  end
end

script.on_event( defines.events.on_tick, orient_players )
