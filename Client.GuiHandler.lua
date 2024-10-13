function Main()
	local TweenService = game:GetService("TweenService")
	local Players = game:GetService("Players")
	local RS = game:GetService("ReplicatedStorage")
	local remotes = RS:WaitForChild("Remotes")
	local plr = Players.LocalPlayer
	local playerGui = plr.PlayerGui
	local logic = false
	
	task.spawn(function() --start
		for _, v in pairs(playerGui:WaitForChild("Main"):GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "StartScreen" then
				v.Visible = false
			end
		end
		local startScreen = playerGui:WaitForChild("Main"):WaitForChild("StartScreen")
		local fade:Frame = startScreen:WaitForChild("Fade")
		local modes:Frame = startScreen:WaitForChild("Modes")
		local welcome = startScreen:WaitForChild("Welcome")
		local name = startScreen:WaitForChild("Name")
		local buttons1 = startScreen:WaitForChild("Buttons1")
		local pickAMode = startScreen:WaitForChild("PickAMode")
		local play = buttons1:WaitForChild("Play")
		local cameraParts:Folder = workspace:WaitForChild("Cameras")
		local running = true
		
		task.spawn(function()
			for _, v in pairs(cameraParts:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 1
				end
			end
		end)
		do --initialize
			startScreen.Visible = true
			welcome.Size = UDim2.new(0,0,0,0)
			name.Size = UDim2.new(0,0,0,0)
			welcome.Visible = false
			name.Visible = false
			buttons1.Visible = true
			modes.Visible = false
			pickAMode.Visible = false
			play.Visible = false
			play.Size = UDim2.new(1.818, 0,0.909, 0)
			workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
			workspace.CurrentCamera.CFrame = cameraParts:WaitForChild("StartScreen").CFrame
			local sOgPos = cameraParts:WaitForChild("StartScreen").CFrame
			task.spawn(function()
				while running do
					TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {CFrame = sOgPos + Vector3.new(0,.5,0)}):Play()
					task.wait(1.5)
					TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {CFrame = sOgPos - Vector3.new(0,.5,0)}):Play()
					task.wait(1.5)
				end
			end)
			
		end
		fade.Visible = true
		task.wait(2)
		TweenService:Create(fade, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
		task.wait(.7)
		welcome.Visible = true
		TweenService:Create(welcome, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(4.211, 0,0.574, 0)}):Play()
		task.wait(.7)
		name.Visible = true
		TweenService:Create(name, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(14.856, 0,1.842, 0)}):Play()
		task.wait(.7)
		play.Visible = true
		TweenService:Create(play, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(4.091, 0,1.196, 0)}):Play()
		
		local playclick = false
		play.MouseButton1Click:Connect(function()
			if playclick then return end
			print(1)
			TweenService:Create(play, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(.01,0,0.01,0)}):Play()
			playclick = true
			task.delay(.5, function()
				local ogPos1 = modes.Position
				local ogPos2=  pickAMode.Position
				modes.Position = modes.Position + UDim2.new(-2,0,0,0)
				pickAMode.Position = pickAMode.Position + UDim2.new(-2,0,0,0)
				pickAMode.Visible = true
				modes.Visible = true
				TweenService:Create(modes, TweenInfo.new(.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = ogPos1}):Play()
				TweenService:Create(pickAMode, TweenInfo.new(.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = ogPos2}):Play()
			end)
		end)
		
		local modeButtons = {
			--modes:WaitForChild("Flood"),
			modes:WaitForChild("Fire"),
			--modes:WaitForChild("Earthquake")
		}
		
		local click = false
		
		for _, v in pairs(modeButtons) do
			v.MouseButton1Click:Connect(function()
				if click then return end
				click = true
				remotes:WaitForChild("LoadSimulation"):FireServer(v.Name)
				remotes:WaitForChild("Loaded"):FireServer()
				running = false
				TweenService:Create(fade, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				task.wait(.4)
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
				task.wait(4)
				TweenService:Create(fade, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				TweenService:Create(workspace.CurrentCamera, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = plr.Character:WaitForChild("Head").CFrame}):Play()
				startScreen.Visible = false
			end)
		end
	end)
	
	task.spawn(function() --scenes
		local dialogueFrame:Frame = playerGui:WaitForChild("Main"):WaitForChild("Dialogue")
		local textLabel:TextLabel = dialogueFrame:WaitForChild("TextLabel")
		local plrImage:ImageLabel = dialogueFrame:WaitForChild("ImageLabel")
		local ogSize = UDim2.new(0.417, 0,0.155, 0)
		
		plrImage.Image = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)

		local function StartTask(text:string)
			local taskFrame:Frame = playerGui:WaitForChild("Main"):WaitForChild("Task")
			taskFrame:WaitForChild("TextLabel").Text = string.format("Task: %s", text)
			taskFrame.Size = UDim2.new(0.001,0,0.001,0)
			taskFrame.Visible = true
			TweenService:Create(taskFrame, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(0.561, 0,0.142, 0)}):Play()
		end
		
		local function endTask()
			local taskFrame:Frame = playerGui:WaitForChild("Main"):WaitForChild("Task")
			TweenService:Create(taskFrame, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(.1,0,.1,0)}):Play()
			
			task.wait(.5)
			taskFrame.Visible = false
			taskFrame.Size = UDim2.new(0.561, 0,0.142, 0)
			taskFrame:WaitForChild("TextLabel").Text = ""
			
		end
		
		local function OpenQuiz()
			task.wait(7)
			
			local quizFrame:Frame = playerGui:WaitForChild("Main"):WaitForChild("Quiz")
			local responseFrames = {}
			
			local correctlyAnswered = 0
			local currentInt = Instance.new("IntValue")
			currentInt.Parent = script
			currentInt.Name = "Current"
			currentInt.Value = 1
			local current = currentInt.Value
			local fireSafetyQuestions = {
				[1] = {
					question = "What should you do if you see fire or smoke in your house?",
					options = {"Hide under your bed", "Run outside and tell an adult", "Stay where you are and wait"},
					correctAnswer = 2
				},
				[2] = {
					question = "If there is a fire, what should you do to escape?",
					options = {"Wait for someone to help you", "Use any safe way to get out, even if it means breaking a window", "Try to fight the fire"},
					correctAnswer = 2
				},
				[3] = {
					question = "What does a fire extinguisher do?",
					options = {"Makes the room colder", "Helps put out small fires", "Lights up the area"},
					correctAnswer = 2
				},
			}
			
			for i, v in pairs(quizFrame:GetChildren()) do
				if v:IsA("Frame") then
					responseFrames[tonumber(v.Name)] = v
				end
			end
			
			local modal = Instance.new("TextButton")
			modal.BackgroundTransparency = 1
			modal.TextTransparency = 1
			modal.Parent = playerGui:WaitForChild("Main")
			modal.Modal = true
			
			quizFrame:WaitForChild("TextLabel").Text = fireSafetyQuestions[1].question
			quizFrame.Visible = true
			
			for _, v in pairs(responseFrames) do
				v:WaitForChild("TextLabel").Text = fireSafetyQuestions[current].options[tonumber(v.Name)]
			end
			
			local cons = {}
			
			for _, v in pairs(responseFrames) do
				cons[#cons+1] = v:WaitForChild("TextButton").MouseButton1Click:Connect(function()
					if fireSafetyQuestions[current].correctAnswer ~= tonumber(v.Name) then
						quizFrame:WaitForChild("Result").Text = "Incorrect. Please try again!"
						quizFrame:WaitForChild("Result").TextColor3 = Color3.fromRGB(255, 53, 19)
						quizFrame:WaitForChild("Result").Visible = true
						task.delay(3.5, function()
							quizFrame:WaitForChild("Result").Visible = false
			
						end)
					else
						quizFrame:WaitForChild("Result").Text = "Correct! Good job!"
						quizFrame:WaitForChild("Result").TextColor3 = Color3.fromRGB(54, 238, 49)
						quizFrame:WaitForChild("Result").Visible = true
						task.delay(3.5, function()
							quizFrame:WaitForChild("Result").Visible = false
							currentInt.Value+=1
						end)
					end
				end)
			end
			
			local continueNext = false
			
			currentInt:GetPropertyChangedSignal("Value"):Connect(function()
				print(currentInt)
				if currentInt.Value == 2 then
					for _, v:RBXScriptConnection in pairs(cons) do
						v:Disconnect()
					end
					table.clear(cons)
					current = 2
					quizFrame:WaitForChild("TextLabel").Text = fireSafetyQuestions[current].question
					
					for _, v in pairs(responseFrames) do
						v:WaitForChild("TextLabel").Text = fireSafetyQuestions[current].options[tonumber(v.Name)]
					end
					
					for _, v in pairs(responseFrames) do
						cons[#cons+1] = v:WaitForChild("TextButton").MouseButton1Click:Connect(function()
							if fireSafetyQuestions[current].correctAnswer ~= tonumber(v.Name) then
								quizFrame:WaitForChild("Result").Text = "Incorrect. Please try again!"
								quizFrame:WaitForChild("Result").TextColor3 = Color3.fromRGB(255, 53, 19)
								quizFrame:WaitForChild("Result").Visible = true
								task.delay(3.5, function()
									quizFrame:WaitForChild("Result").Visible = false

								end)
							else
								quizFrame:WaitForChild("Result").Text = "Correct! Good job!"
								quizFrame:WaitForChild("Result").TextColor3 = Color3.fromRGB(54, 238, 49)
								quizFrame:WaitForChild("Result").Visible = true
								task.delay(3.5, function()
									quizFrame:WaitForChild("Result").Visible = false
									currentInt.Value+=1
								end)
							end
						end)
					end
				elseif currentInt.Value == 3 then
					for _, v:RBXScriptConnection in pairs(cons) do
						v:Disconnect()
					end
					table.clear(cons)
					current = 3
					quizFrame:WaitForChild("TextLabel").Text = fireSafetyQuestions[current].question

					for _, v in pairs(responseFrames) do
						v:WaitForChild("TextLabel").Text = fireSafetyQuestions[current].options[tonumber(v.Name)]
					end

					for _, v in pairs(responseFrames) do
						cons[#cons+1] = v:WaitForChild("TextButton").MouseButton1Click:Connect(function()
							if fireSafetyQuestions[current].correctAnswer ~= tonumber(v.Name) then
								quizFrame:WaitForChild("Result").Text = "Incorrect. Please try again!"
								quizFrame:WaitForChild("Result").TextColor3 = Color3.fromRGB(255, 53, 19)
								quizFrame:WaitForChild("Result").Visible = true
								task.delay(3.5, function()
									quizFrame:WaitForChild("Result").Visible = false

								end)
							else
								quizFrame:WaitForChild("Result").Text = "Correct! Good job!"
								quizFrame:WaitForChild("Result").TextColor3 = Color3.fromRGB(54, 238, 49)
								quizFrame:WaitForChild("Result").Visible = true
								task.delay(3.5, function()
									quizFrame:WaitForChild("Result").Visible = false
									currentInt.Value+=1
									continueNext = true
									return
								end)
							end
						end)
					end
				end
				
				repeat task.wait() until continueNext
				
				logic = true
				
				quizFrame.Visible = false
			end)
		end
		
		local function BringFunFact(text:string)
			local frame = playerGui:WaitForChild("Main"):WaitForChild("FunFact")
			local info:TextLabel = frame:WaitForChild("Info")
			local ogPos = frame.Position
			
			frame.Position = frame.Position + UDim2.new(2,0,0,0)
			
			info.Text = text
			
			frame.Visible = true
			
			TweenService:Create(frame, TweenInfo.new(.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = ogPos}):Play()
			
			task.delay(10, function()
				TweenService:Create(frame, TweenInfo.new(.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = frame.Position + UDim2.new(2,0,0,0)}):Play()
				task.delay(.5, function()
					frame.Visible = false
					info.Text = ""
				end)
			end)
		end
		
		local function AnimateDialogue(text:string)
			dialogueFrame.Visible = true
			dialogueFrame.Size = UDim2.new(.1,0,.1,0)
			task.spawn(function()
				task.delay(.3, function()
					local list = string.split(text, "")
					textLabel.Text = ""
					for _, v in pairs(list) do
						textLabel.Text = textLabel.Text..v
						task.wait(.05)
					end
				end)
			end)
			TweenService:Create(dialogueFrame, TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size=  ogSize}):Play()
			task.delay(6, function()
				TweenService:Create(dialogueFrame, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(.01,0,.01,0)}):Play()
				task.delay(.5, function()
					dialogueFrame.Visible = false
					dialogueFrame.Size = ogSize
					textLabel.Text = ""
				end)
			end)
		end
		local remote = remotes:WaitForChild("NextScene")
		local con = remote.OnClientEvent:Connect(function(sceneInt:number)
			if sceneInt == 1 then
				AnimateDialogue("Oh wow what a beautiful day!")
			elseif sceneInt == 2 then
				remotes:WaitForChild("ChangeFirstPersonCamera"):Fire(false)
				workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
				workspace.CurrentCamera.CFrame = workspace:WaitForChild("Cameras"):WaitForChild("Fire"):WaitForChild("1").CFrame
				workspace:WaitForChild("FireSimulation"):WaitForChild("SmokeDetector"):WaitForChild("Sound"):Play()
				AnimateDialogue("Oh no, the smoke alarm is going off!")
			elseif sceneInt == 3 then
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
				StartTask("Find where the smoke is coming from!")
				task.delay(4, function()
					BringFunFact("Earth is the only planet known to have enough oxygen for fire to burn!")
				end)
				workspace:WaitForChild("FireSimulation"):WaitForChild("SmokeDetector"):WaitForChild("Sound"):Pause()
				remotes:WaitForChild("ChangeFirstPersonCamera"):Fire(true)				
			elseif sceneInt == 4 then
				endTask()
				task.wait(.5)
				script:WaitForChild("Fire").Volume = 0
				script:WaitForChild("Fire"):Play()
				game:GetService("TweenService"):Create(script:WaitForChild("Fire"), TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Volume = .5}):Play()
				AnimateDialogue("Look out, the table has caught on fire!")
				task.wait(7)
				AnimateDialogue("We need a FIRE EXTINGUISHER! Fire extinguishers are used to fight fires. Try to find one!")
			elseif sceneInt == 5 then
				AnimateDialogue("Use your fire extinguisher to take out the fire!")
				
				task.delay(6, function()
					StartTask("Take out the fire!")
				end)
				local fire = workspace:WaitForChild("FirePart"):WaitForChild("Fire")
				
				local cons = {}
				
				local function checkCons()
					if plr:WaitForChild("UnderPlayer"):WaitForChild("FireProgress").Value >= 75 then
						for _, v in pairs(cons) do
							v:Disconnect()
							TweenService:Create(fire, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = 0}):Play()
							task.wait(.5)
							fire:Destroy()
							
							endTask()
							
							remotes:WaitForChild("UpdateTask"):FireServer()
							remotes:WaitForChild("FinishedFireScene"):FireServer()
						end
					end
				end
				
				cons[1] = plr:WaitForChild("UnderPlayer"):WaitForChild("FireProgress"):GetPropertyChangedSignal("Value"):Connect(function()
					TweenService:Create(fire, TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = 75/plr:WaitForChild("UnderPlayer"):WaitForChild("FireProgress").Value}):Play()
					checkCons()
				end)
			elseif sceneInt == 6 then
				game:GetService("TweenService"):Create(script:WaitForChild("Fire"), TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Volume = 0}):Play()
				script:WaitForChild("Fire").Playing = false
				AnimateDialogue("Good job, you took out the fire!")
				
				task.wait(7)
				
				AnimateDialogue("Remember, fires can happen at ANY time. That's why it's useful to have a plan!")
				
				task.wait(7)
				AnimateDialogue("Does YOUR family have a fire escape plan? If not, now's the time to create one!")
				
				task.wait(7)
				
				local paperFrame:ImageLabel = playerGui:WaitForChild("Main"):WaitForChild("EscapeRoute")
				local done = paperFrame:WaitForChild("Finish")
				local check = false
				
				paperFrame.Visible = true
				
				StartTask("Create a fire escape plan!")
				
				local unlock = Instance.new("TextButton")
				unlock.Parent = playerGui:WaitForChild("Main")
				unlock.Transparency = 1
				unlock.Text = ""
				unlock.Size = UDim2.new(1000,0,1000,0)
				unlock.Modal = true
				
				done.MouseButton1Click:Connect(function()
					check = true
				end)

				repeat task.wait() until check 
				
				paperFrame.Visible = false
				unlock:Destroy()
				
				endTask()
				plr:WaitForChild("UnderPlayer"):WaitForChild("Task").Value += 1
				
				AnimateDialogue("Good job coming up with a plan! Make sure to share it with your family!")
								
				local fires = {workspace:WaitForChild("FirePart2"), workspace:WaitForChild("FirePart3"), workspace:WaitForChild("FirePart4")}
				
				task.wait(7)
				
				for _, v in pairs(fires) do
					v:WaitForChild("Fire").Enabled = true
				end
				
				
				
				AnimateDialogue("Oh no, more fires have broken out! We need to safely find a way out!")
				
				script:WaitForChild("Fire").Volume = 0
				script:WaitForChild("Fire"):Play()
				game:GetService("TweenService"):Create(script:WaitForChild("Fire"), TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Volume = .5}):Play()
				
				task.wait(7)
				
				plr.Character:WaitForChild("HumanoidRootPart").Anchored = false

				
				StartTask("Find a way to exit the fire through any means necessary")
				
				game:GetService("ReplicatedStorage"):WaitForChild("Hammer").Parent = workspace
				
				local clicked = false
				local continue1 = false
				
				remotes:WaitForChild("NextScene2").OnClientEvent:Connect(function()
					continue1 = true
				end)
				
				workspace:WaitForChild("Hammer"):WaitForChild("ClickDetector").MouseClick:Connect(function()
					if not clicked then
						clicked = true
						workspace:WaitForChild("Hammer"):Destroy()
						AnimateDialogue("Use your hammer to break the window and escape!")
						dialogueFrame.Position = dialogueFrame.Position - UDim2.new(0,0,-.2,0)
						task.delay(7, function()
							dialogueFrame.Position = dialogueFrame.Position - UDim2.new(0,0,.2,0)
						end)
						remotes:WaitForChild("GiveHammer"):FireServer()
					end
				end)
				
				repeat task.wait() until continue1
				
				endTask()
				
				for _, v in pairs(fires) do
					v:WaitForChild("Fire").Enabled = false
				end
				
				
				game:GetService("TweenService"):Create(script:WaitForChild("Fire"), TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Volume = 0}):Play()
				script:WaitForChild("Fire").Playing = false
				
				AnimateDialogue("Good job, you escaped the fire!")
				
				plr:WaitForChild("UnderPlayer"):WaitForChild("Task").Value += 1
				
				task.wait(7)
				
				AnimateDialogue("Now its time for one last quiz to test your knowledge!")
				
				OpenQuiz()
				
				repeat task.wait() until logic
				
				AnimateDialogue("Thank you so much for playing my congressional app, I hope you learned more about fire safety!")
				
				
			end
		end)
		
	end)
	
end

return {
	Main()
}
