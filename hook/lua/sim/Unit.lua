---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by maudlin27.
--- DateTime: 08/05/2024 22:56
---
local M27Units = import('/mods/Mini27AI/lua/AI/M27Units.lua')

do --Per Balthazaar - encasing the code in do .... end means that you dont have to worry about using unique variables
    local M27OldUnit = Unit
    Unit = Class(M27OldUnit) {
        OnCreate = function(self)
            M27OldUnit.OnCreate(self)
            ForkThread(M27Units.OnCreate, self)
        end,
        OnStopBuild = function(self, unit)
            if unit and not(unit.Dead) and unit.GetFractionComplete and unit:GetFractionComplete() == 1 then
                ForkThread(M27Units.OnConstructed, self, unit)
            end
            return M27OldUnit.OnStopBuild(self, unit)
        end,
    }
end