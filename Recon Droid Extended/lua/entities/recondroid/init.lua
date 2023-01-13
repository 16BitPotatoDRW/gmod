AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Combine_Scanner.mdl")
	self:SetModelScale( self:GetModelScale() *.5,.1)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetMaxHealth(50)
	self:SetHealth(50)
	self:EmitSound("npc/combine_gunship/engine_rotor_loop1.wav", 70, 250)
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	//self:SetModelScale(.5,0)
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
		self:Activate()
		phys:Wake()
		phys:EnableMotion(true)
		self:StartMotionController()
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
   
   self.Accel={

		FWD=0,

		RIGHT=0,

		UP=0,

	};

	self.Throttle = {

		FWD = 0,

		RIGHT = 0, 

		UP = 0,

	};

	self.Acceleration = 10;
	self.ForwardSpeed = 280;
	self.BoostSpeed = 300;
	self.UpSpeed = 200;
	
	
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
	SpawnAng.x = SpawnAng.x - 90
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Use(ply)
if ply != self.pilot then return end
	ply.droid = nil
	ply:StripWeapon("ReconDroidController")
	ply:Give("ReconDroidKit")
	self.Owner:SetNWBool( "deployed", false )
	self:Remove()

end

function ENT:OnTakeDamage(damage)
    print("ENT:OnTakeDamage")
    print(damage)
	if (IsValid(self)) then
		self:SetHealth(self:Health() - damage:GetDamage())
		if (self:Health() > 0) then
			self:EmitSound("npc/combine_soldier/die1.wav", 100, 180)
		elseif (self:Health() <= 0) then
			self:Remove()
			self:StopSound("npc/combine_gunship/engine_rotor_loop1.wav")
			self:EmitSound("physics/glass/glass_sheet_break3.wav", 100, 40)
		end
	end
end

function ENT:Handbrake()

	

	for k,v in pairs(self.Throttle) do

		self.Throttle[k] = 0;

	end

	self.Accel.FWD = math.Approach(self.Accel.FWD,0,self.Acceleration*4)

	self.Handbraking = true;

end


local DroidPhys = {

	secondstoarrive	= 1;

	maxangular = 5000;

	maxangulardamp = 10000;

	maxspeed = 1000000;

	maxspeeddamp = 500000;

	dampfactor = 0.8;

	teleportdistance = 5000;
	
	deltatime = deltatime

};
ENT.Roll = 0;
function ENT:PhysicsSimulate( phys, deltatime )

	phys:Wake();

	local pos = self:GetPos(); 
	local FWD = self.Entity:GetForward();

	local UP = Vector(0,0,1);

	local RIGHT = FWD:Cross(UP):GetNormalized();
	
	self.Accel.RIGHT = math.Approach(self.Accel.RIGHT,self.Throttle.RIGHT,self.Acceleration);

	self.Accel.UP = math.Approach(self.Accel.UP,self.Throttle.UP,self.Acceleration*0.9);
	if !IsValid(self.pilot) then return end
	if self.Throttle.FWD > 0 then
		self.Throttle.FWD = self.Throttle.FWD - self.Acceleration *.5;
	elseif self.Throttle.FWD < 0 then
		self.Throttle.FWD = self.Throttle.FWD + self.Acceleration * .5;
	end
	
	
	if self.pilot:GetNWBool("CameraPOV") then
		self.Handbraking = false;
		self.Throttle.Up = 2
		if self.Throttle.FWD > 0 && !self.pilot:KeyDown(IN_FORWARD) then
			self.Throttle.FWD = self.Throttle.FWD - self.Acceleration *.5;
		elseif self.Throttle.FWD < 0 && !self.pilot:KeyDown(IN_BACK) then
			self.Throttle.FWD = self.Throttle.FWD + self.Acceleration * .5;
		end
		
		if(self.pilot:KeyDown(IN_FORWARD) && self.pilot:KeyDown(IN_BACK)) then
			
			self:Handbrake();
			
		else
		
			if(self.pilot:KeyDown(IN_FORWARD)) then
	
				self.Throttle.FWD = self.Throttle.FWD + self.Acceleration;
	
			elseif(self.pilot:KeyDown(IN_BACK)) then
	
				self.Throttle.FWD = self.Throttle.FWD - self.Acceleration;
	
			end
		
		end
		
		if(self.pilot:KeyDown(IN_WALK)) then
			self.Acceleration = 10;
			self.ForwardSpeed = 100;
			self.BoostSpeed = 100;
			self.UpSpeed = 100;
		
		else
			self.Acceleration = 10;
			self.ForwardSpeed = 280;
			self.BoostSpeed = 300;
			self.UpSpeed = 200;
		
		end

		local min,max;	
		
			min = (self.ForwardSpeed*0.66)*-1;
		
		if (!self.pilot:KeyDown(IN_SPEED)) then
			max = self.ForwardSpeed;
		else
			max = self.BoostSpeed;
		end
		
		
		if(!self.Handbraking) then
			
		    self.Throttle.FWD = math.Clamp(self.Throttle.FWD,min,max);
		
		    self.Accel.FWD = math.Approach(self.Accel.FWD,self.Throttle.FWD,self.Acceleration);
        
        end
		
		if(self.pilot:KeyDown(IN_MOVERIGHT)) then
		
		    self.Throttle.RIGHT = self.UpSpeed / 1.2;
		
		    self.Roll = 20;
		
		elseif(self.pilot:KeyDown(IN_MOVELEFT)) then
		
		    self.Throttle.RIGHT = (self.UpSpeed / 1.2)*-1;
		
		    self.Roll = -20;
		
		else
		
		    self.Throttle.RIGHT = 0;
		
		    self.Roll = 0;
        
		end
		
		if self.pilot:KeyDown(IN_JUMP) then
		
		    self.Throttle.UP = self.UpSpeed;
		
		elseif self.pilot:KeyDown(IN_DUCK) then
		
		    self.Throttle.UP = -self.UpSpeed;
		
		else
		
		    self.Throttle.UP = 0;
		
		end
		
		local velocity = self:GetVelocity();

        local aim = self.pilot:GetAimVector();

        local ang = aim:Angle();
		
		DroidPhys.angle = ang;
		
		DroidPhys.deltatime = deltatime;
		
		if(self.AutoCorrect or Should_AlwaysCorrect) then
		
		    local heightTrace = util.TraceLine({
		
		        start = self:GetPos(),
		
		        endpos = self:GetPos()+Vector(0,0,-100),
		
		        filter = self:GetChildEntities(),
		
		    })
		
		    if(heightTrace.Hit) then
		
		        local nextPos = self:GetPos()+(FWD*self.Accel.FWD)+(UP*self.Accel.UP)+(RIGHT*self.Accel.RIGHT);
		
		        if(nextPos.z <= heightTrace.HitPos.z + 100) then
		
		            newZ = heightTrace.HitPos.z + 100;
		
		            self.Accel.FWD = math.Clamp(self.Accel.FWD,0,1000);
		
		        end
		
		    end
		
		
		
		    local forwardTrace = util.TraceLine({
		
		        start = self:GetPos(),
		
		        endpos = self:GetPos()+self:GetForward(),
		
		        filter = self:GetChildEntities(),
		
		    })
		
		
		
		    if(forwardTrace.Hit) then
		
		        self.Accel.FWD = 0;
		
		    end
		
		
		
		end
		
		
		
		local fPos = pos+(FWD*self.Accel.FWD)+(UP*self.Accel.UP);
		
		
		
		    fPos = fPos+(RIGHT*self.Accel.RIGHT);
		
		
		
		
		if(newZ) then
		
		    DroidPhys.pos = Vector(fPos.x,fPos.y,newZ);
		
		else
		
		    DroidPhys.pos = fPos;
		
		end
		
		
		
		phys:ComputeShadowControl(DroidPhys);
		
		 phys:Wake();
	end 
        

end


function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end



function ENT:OnRemove()
self:StopSound("npc/combine_gunship/engine_rotor_loop1.wav")
end

