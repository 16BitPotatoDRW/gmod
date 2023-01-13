if SERVER then 
	
	hook.Add("PlayerSwitchWeapon","TurnoffController",function( ply, oldWeapon, newWeapon )
		
	end)

	
	
end

if !CLIENT then return end

local modelexample = ClientsideModel( "models/lt_c/holograms/eletc_paths.mdl" )
//modelexample:SetNoDraw( true )

local offsetvec = Vector( 4, -5.5, 0 ) //3
local offsetang = Angle( 180, 0, 0 )



/*
hook.Add( "PostPlayerDraw" , "controller_show" , function( ply )
	if ply == LocalPlayer() then timer.Simple(.5,function() LocalPlayer().shutoff = false end)LocalPlayer().shutoff = true end
	
	for index, ply in pairs(player.GetAll()) do
		if ply == LocalPlayer() then continue end
		if !ply:GetNWBool("HasController") then continue end
		if ply:GetNWBool( "Show_Controller" ) then 
			local boneid = ply:LookupBone( "ValveBiped.Bip01_R_Hand" )
			if not boneid then
				return
			end
		
			local matrix = ply:GetBoneMatrix( boneid )
		
			if not matrix then
				return
			end
		
			local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )
		
			modelexample:SetPos( newpos )
			modelexample:SetAngles( newang )
			modelexample:SetupBones()
			modelexample:DrawModel()
		end

	end
end)


	
hook.Add("HUDPaint", "Controllerrmodel", function()
    local ply = LocalPlayer()
	local ang = LocalPlayer():GetAimVector()
	if LocalPlayer().shutoff then return end
   if !LocalPlayer():Alive() then return end
   if !LocalPlayer():GetNWBool("HasController") then return end
        cam.Start3D()
			if LocalPlayer():GetNWBool( "Show_Controller" ) then
					modelexample:SetModel("models/lt_c/holograms/eletc_paths.mdl")
					local ang = LocalPlayer():EyeAngles() 
					ang.z = ang.z + 180
					//ang.y = ang.y + 180
					modelexample:SetPos( LocalPlayer():GetShootPos() + ang:Right() * -10 - ang:Up() * -5 + ang:Forward()* 30 )
					modelexample:SetAngles(ang + Angle(180,0,0))
					modelexample:SetupBones()
					modelexample:DrawModel()
			end
        cam.End3D()
end)
*/