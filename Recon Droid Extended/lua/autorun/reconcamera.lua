if SERVER then

hook.Add( "SetupPlayerVisibility", "MakeVisible_droid_pov", function( pPlayer, pViewEntity )
	-- Adds any view entity
	if pPlayer:GetNWEntity("droid") && pPlayer:GetNWBool("CameraPOV") && pPlayer:GetNWBool("deployed") && IsValid(pPlayer:GetNWEntity("droid")) then
		AddOriginToPVS( pPlayer:GetNWEntity("droid"):GetPos() ) else
	end
end )

end


if not CLIENT then return end

hook.Add("CalcView", "ReconDroid.CalcView",function(ply, pos, angles, fov, znear, zfar)
	
	
	if  IsValid(ply:GetNWEntity("droid")) && ply:GetNWBool("CameraPOV") && ply:GetNWBool("deployed") then
		local view = {}

		view.origin = ply:GetNWEntity("droid"):GetPos()-( ply:GetNWEntity("droid"):GetForward()*-5 )
		view.angles = ply:GetNWEntity("droid"):GetAngles()
		view.fov = fov
		view.drawviewer = true

		return view
	end
end)