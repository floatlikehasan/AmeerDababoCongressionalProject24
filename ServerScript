workspace.FireSimulation.Parent = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Hammer").Parent = game:GetService("ReplicatedStorage")

task.spawn(function()
	game:GetService("Players").PlayerAdded:Connect(function(plr)
		local underPlr = Instance.new("Folder")
		underPlr.Name = "UnderPlayer"
		underPlr.Parent = plr

		local taskInt = Instance.new("IntValue")
		taskInt.Name = "Task"
		taskInt.Parent = underPlr
		taskInt.Value = 0
		
		local loaded = Instance.new("BoolValue")
		loaded.Parent = underPlr
		loaded.Value = false
		loaded.Name = "Loaded"
		
		local fireProgress = Instance.new("IntValue")
		fireProgress.Name = "FireProgress"
		fireProgress.Value = 0
		fireProgress.Parent = underPlr
	end)

	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpdateTask").OnServerEvent:Connect(function(plr)
		plr:WaitForChild("UnderPlayer"):WaitForChild("Task").Value += 1
	end)
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Loaded").OnServerEvent:Connect(function(plr)
		plr:WaitForChild("UnderPlayer"):WaitForChild("Loaded").Value = true
	end)
	
	for _, v in pairs(game:GetService("CollectionService"):GetTagged("Disappear")) do
		v.Transparency = 1
	end
end)

require(script:FindFirstChild("SimulationHandler"))

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GiveHammer").OnServerEvent:Connect(function(plr)
	local hammer:Tool = game:GetService("Lighting"):WaitForChild("Hammer")
	hammer:Clone().Parent = plr.Backpack
	hammer:Clone().Parent = plr.StarterGear
end)

