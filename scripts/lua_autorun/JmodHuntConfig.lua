-- Autorun file
AddCSLuaFile()

JMod = JMod or {}
JMod.LuaConfig = JMOD_LUA_CONFIG or {}
JMod.LuaConfig.BuildFuncs = JMod.LuaConfig.BuildFuncs or {}

JMod.LuaConfig.BuildFuncs["(c)Instant Hesco (Small)"] = function(playa, position, angles)
        local Ent = ents.Create("prop_physics")
        Ent:SetModel("models/2rek/icefuse/hesco_s_1.mdl")
        Ent:SetPos(position)
        Ent:SetAngles(angles)
        Ent.Owner=playa
        Ent:Spawn()
    end