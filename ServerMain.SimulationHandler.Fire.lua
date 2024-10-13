local module = {}

function module.Main(plr:Player)
	local RS = game:GetService("ReplicatedStorage")
	local remotes = RS:WaitForChild("Remotes")
	local fireSimulationModel:Model = RS:FindFirstChild("FireSimulation"):Clone()
	fireSimulationModel.Parent = workspace
	local char = plr.Character or plr.CharacterAdded:Wait()
	local tp = fireSimulationModel:FindFirstChild("KitchenSpawn")
	local hrp:BasePart = char:WaitForChild("HumanoidRootPart")
	local continue1 = false
	local continue2 = false
	local deb1 = false
	local deb2 = false
	hrp.CFrame = tp.CFrame + Vector3.new(0,3,0)
	hrp.Anchored = true
	
	fireSimulationModel:WaitForChild("Trigger1").Touched:Connect(function(hit)
		if not deb1 and hit.Parent:FindFirstChild("Humanoid") and game:GetService("Players"):GetPlayerFromCharacter(hit.Parent) == plr then
			deb1 = true
			continue1 = true
		end
	end)
	
	workspace:WaitForChild("FireExtinguisher").Touched:Connect(function(hit)
		if not deb2 and hit.Parent:FindFirstChild("Humanoid") and game:GetService("Players"):GetPlayerFromCharacter(hit.Parent) == plr then
			deb2 = true
			script:WaitForChild("FireExtinguisher"):Clone().Parent = plr.Backpack
			script:WaitForChild("FireExtinguisher"):Clone().Parent = plr.StarterGear
			workspace:WaitForChild("FireExtinguisher"):Destroy()
			continue2 = true
		end 
	end)
	
	task.wait(5)
	
	remotes:WaitForChild("NextScene"):FireClient(plr, 1)
	
	task.wait(7)
	
	remotes:WaitForChild("NextScene"):FireClient(plr, 2)
	
	task.wait(7)
	
	remotes:WaitForChild("NextScene"):FireClient(plr, 3)
	
	task.wait(5)
	
	hrp.Anchored = false
	
	repeat task.wait() until continue1
	
	remotes:WaitForChild("NextScene"):FireClient(plr, 4)
	plr:WaitForChild("UnderPlayer"):WaitForChild("Task").Value += 1
	
	plr.Character:WaitForChild("HumanoidRootPart").Anchored = true
	
	task.delay(13.5, function()
		plr.Character:WaitForChild("HumanoidRootPart").Anchored = false
	end)
	
	repeat task.wait() until continue2
	
	remotes:WaitForChild("NextScene"):FireClient(plr, 5)
	
	plr.Character:WaitForChild("HumanoidRootPart").Anchored = false
	
	RS:WaitForChild("Remotes"):WaitForChild("FinishedFireScene").OnServerEvent:Connect(function(plr)
		task.spawn(function()
			for _, v:Model in pairs(workspace:WaitForChild("FireSimulation"):WaitForChild("Urban House"):WaitForChild("Model"):WaitForChild("Kitchen and Dining Room"):WaitForChild("Dining Room Table Set"):GetChildren()) do
				if v:IsA("Model") then
					do
						for _, v in pairs(v:GetChildren()) do
							if v:IsA("BasePart") then
								v.Anchored = false
								local rands = {Vector3.yAxis, Vector3.xAxis}
								v:ApplyImpulse(rands[math.random(1,#rands)]*100)
							end
						end
					end
				end
			end
		end)
		remotes:WaitForChild("NextScene"):FireClient(plr, 6)
		plr.Character:WaitForChild("HumanoidRootPart").Anchored = true
		if plr.Backpack:FindFirstChild("FireExtinguisher") then
			plr.Backpack:FindFirstChild("FireExtinguisher"):Destroy()
		end
		if plr.StarterGear:FindFirstChild("FireExtinguisher") then
			plr.StarterGear:FindFirstChild("FireExtinguisher"):Destroy()
		end
		if plr.Character:FindFirstChild("FireExtinguisher") then
			plr.Character:FindFirstChild("FireExtinguisher"):Destroy()
		end
		
		task.wait(8)
		
		remotes:WaitForChild("NextScene"):FireClient(plr, 7)
		fireSimulationModel:WaitForChild("Trigger1").CanCollide = true
		
	end)
end


return module
