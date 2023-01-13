AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NONE )
	//self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
	
		phys:Wake()
	
	end 
	
  if !self:IsOnGround() then 
        local td = {}
        td.start = self:GetPos() 
        td.endpos = td.start - Vector( 0, 0, 10000 )
        td.filter = self
        local trace = util.TraceLine(td)
        self:SetPos(trace.HitPos + Vector(0,0,20))
   end
   //phys:EnableGravity(false)
   
end

function ENT:Think()
	if IsValid(self) then
			
	end
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.HitPos ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Use(ply)

	ply.camera = nil
	ply:StripWeapon("ReconDroidController")
	ply:Give("ReconDroidKit")
	self.Owner:SetNWBool( "deployed", false )
	self:Remove()

end



function ENT:OnRemove()
end

