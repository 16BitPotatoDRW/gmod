ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Category = "Evan's Remote Recon"
ENT.PrintName = "Recon Droid Camera"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.AutomaticFrameAdvance = true


if SERVER then
	//AddCSLuaFile("autorun/swep_net.lua")
end

function ENT:Initialize()
 timer.Simple(.5,function() self:ResetSequence(1) end)
 self:EmitSound("npc/combine_gunship/engine_rotor_loop1.wav", 70, 250)

end

function ENT:Think()

	self:SetCycle(CurTime() % 1)

end

function ENT:SetupDataTables()
		
		
	if ( SERVER ) then
		
	end

end

function ENT:OnRemove()
self:StopSound("npc/combine_gunship/engine_rotor_loop1.wav")
end