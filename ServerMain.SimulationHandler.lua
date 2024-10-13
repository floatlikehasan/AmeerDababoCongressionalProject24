function Main()
	local RS = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local remotes = RS:WaitForChild("Remotes")
	
	remotes:WaitForChild("LoadSimulation").OnServerEvent:Connect(function(plr, modeStr)
		if script[modeStr] then
			require(script[modeStr]).Main(plr)
		end
	end)
end

return {
	Main()
}
