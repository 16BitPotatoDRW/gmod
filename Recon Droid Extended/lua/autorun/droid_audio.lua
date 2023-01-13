
hook.Add("PlayerCanHearPlayersVoice","DroidCanHearVoice",function(lis,tal)
	if lis == tal then return end
	
	if lis.droid == nil && IsValid(tal.droid) then 
		if tal.droid:GetPos():Distance(lis:GetPos()) < 500 then
			return true, false
		end
	elseif tal.droid == nil && IsValid(lis.droid) then 
		if tal:GetPos():Distance(lis.droid:GetPos()) < 500 then
			return true, false
		end
	end
end)
