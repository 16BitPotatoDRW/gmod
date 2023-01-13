AddCSLuaFile()

SWEP.PrintName = "Stim Bag"
SWEP.Author = "Potato"
SWEP.Purpose = "In retrospect, it probably wasn't a good idea to put a bunch of medical sharps in a plastic bag."
SWEP.Instructions = "Left click to open the stim/medshot menu. R to confirm/close. If you somehow lose this while the menu is open, you're stuck."
SWEP.Contact = "PLEASE just bind a key to +ARC_VM_MEDSHOT so you don't have to use this stupid thing."

SWEP.Slot = 5
SWEP.SlotPos = 2
SWEP.Spawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_package.mdl" )
SWEP.UseHands = true
SWEP.HoldType = "slam"

function SWEP:PrimaryAttack()
	self.Owner:ConCommand("+ARC_VM_MEDSHOT")
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	self.Owner:ConCommand("-ARC_VM_MEDSHOT")
end

function SWEP:Holster()
	self:Reload()
return true
end

function SWEP:OnRemove()
--	self:Reload()
return true
end

function SWEP:OnDrop()
--	self:GetOwner():ConCommand("-ARC_VM_MEDSHOT")
end

function SWEP:ShouldDropOnDie() return false end