---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by maudlin27.
--- DateTime: 17/06/2024 21:38
---
IsUnitRestricted = function(oUnit, iArmyIndex)
end

local M27ParentDetails = import('/mods/Mini27AI/lua/AI/M27ParentDetails.lua')
if M27ParentDetails.bLoudModActive then
    IsUnitRestricted = function(oUnit)
        return import('/lua/game.lua').UnitRestricted(nil, oUnit.UnitId)
    end
else
    IsUnitRestricted = function(oUnit, iArmyIndex)
        return import('/lua/game.lua').IsRestricted(oUnit.UnitId, iArmyIndex)
    end
end