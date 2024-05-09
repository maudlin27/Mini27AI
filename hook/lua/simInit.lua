---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by maudlin27.
--- DateTime: 09/05/2024 18:27
---
local BaseGameCreateResourceDeposit = CreateResourceDeposit
local M27Map = import('/mods/Mini27AI/lua/AI/M27Map.lua')

CreateResourceDeposit = function(t,x,y,z,size)
    BaseGameCreateResourceDeposit(t,x,y,z,size)
    ForkThread(M27Map.RecordResourcePoint,t,x,y,z,size)
end