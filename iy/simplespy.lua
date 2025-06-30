if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = game.Players.LocalPlayer
-- // // // Services // // // --
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CoreGui = game:GetService('StarterGui')
local UserInputService = game:GetService('UserInputService')
local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- // // // Locals // // // --
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = LocalCharacter:FindFirstChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local distanceEnemys = 1100
local loadIcon = false
local mapName = {
    ["Leveling City"] = "SoloWorld",
    ["Grass Village"] = "NarutoWorld",
    ["Brum Island"] = "OPWorld",
    ["Faceheal Town"] = "BleachWorld",
    ["Faceheal Island"] = "BleachWorld",
    ["Lucky Kingdom"] = "BCWorld",
    ["Nipon City"] = "ChainsawWorld",
    ["Nipon"] = "ChainsawWorld",
    ["Mori Town"] = "JojoWorld",
    ["Mori"] = "JojoWorld",
    ["Mori Island"] = "JojoWorld",
    ["Dragon City"] = "DBWorld",
    ["XZ City"] = "OPMWorld",
    ["Kindama City"] = "DanWorld",
    ["Hunters City"] = "Solo2World",
    ["Hunters World"] = "Solo2World",
    ["Nen City"] = "HxHWorld",
    ["Nen World"] = "HxHWorld",
    ["Hurricane Town"] = "SlimeWorld",
    ["Hurricane World"] = "SlimeWorld",
    ["Hurricane Island"] = "SlimeWorld",
}


if game.PlaceId == 87039211657390 or game.PlaceId == 128336380114944 or game.PlaceId == 75812907038499 then 
--<>----<>----<>----< Main Script >----<>----<>----<>--
    print("[Akbar Hub | "..GameName.."]")
    local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/FischMain.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/saveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/akbarkidds/Fisch/refs/heads/main/InterfaceManager.lua"))()
    
    local Window = Fluent:CreateWindow({
        Title = "Akbar Hub | "..GameName,
        SubTitle = "v1.6",
        TabWidth = 150,
        Size = UDim2.fromOffset(600, 400),
        Acrylic = false,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftControl
    })

function icons ()
    -- ===================== icon ===================== --
        local screenGui = Instance.new("ScreenGui")
        local minimizeButton = Instance.new("ImageButton")
        local buttonCorner = Instance.new("UICorner")

        screenGui.Name = "MobileMinimize"
        screenGui.Parent = game:GetService("CoreGui")
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        minimizeButton.Parent = screenGui
        minimizeButton.BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000)
        minimizeButton.BorderColor3 = Color3.new(1.000000, 1.000000, 1.000000)
        minimizeButton.BorderSizePixel = 0
        minimizeButton.Position = UDim2.new(0,584,0,14)

        local originalSize = UDim2.new(0, 45, 0, 45)
        minimizeButton.Size = originalSize + UDim2.new(0, originalSize.X.Offset * 0.15, 0, originalSize.Y.Offset * 0.15)
        minimizeButton.Image = "rbxassetid://97909023934615"

        buttonCorner.CornerRadius = UDim.new(0.2, 0)
        buttonCorner.Parent = minimizeButton

        local dragging = false
        local dragInput, touchPos, buttonPos

        minimizeButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                touchPos = input.Position
                buttonPos = minimizeButton.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        minimizeButton.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - touchPos
                minimizeButton.Position = UDim2.new(
                    buttonPos.X.Scale,
                    buttonPos.X.Offset + delta.X,
                    buttonPos.Y.Scale,
                    buttonPos.Y.Offset + delta.Y
                )
            end
        end)

        minimizeButton.MouseButton1Click:Connect(function()
            Window:Minimize()
        end)
        loadIcon = true
end
    -- ===================== icon ===================== --

    --Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "gamepad-2" }),
        Auto = Window:AddTab({ Title = "Auto", Icon = "repeat" }),
        Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "skull" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "plane" }),
        Tools = Window:AddTab({ Title = "Tools", Icon = "wrench" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }

    local Options = Fluent.Options

    -- ============================================= Other Code =====================================
        do -- no delete
            -- ======== Configuration Variables ========
            local isAttacking = false
            local enemytargetReal
            local VariableIndex = {
                AutoFarm = false,
                TweenToMonster = false,
                AutoArise = false,
                AutoJoinDungeon = false,
                AntiAFKs = true,
                AutoExecute = false,
            }
            
            -- ==================================== Start Function Group ============================
                -- ===================================== Function =====================================

                    local function notif(message, duration)
                        Fluent:Notify({
                            Title = "Akbar Hub | "..GameName,
                            Content = message,
                            SubContent = "", -- Optional
                            Duration = duration -- Set to nil to make the notification not disappear
                        })
                        task.wait(duration)
                    end
                    
                    local function notif2(title, message, duration)
                        Fluent:Notify({
                            Title = "Akbar Hub | "..title,
                            Content = message,
                            SubContent = "", -- Optional
                            Duration = duration -- Set to nil to make the notification not disappear
                        })
                        task.wait(duration)
                    end
                    
                    function moveTo(humanoid, targetPoint)
                        humanoid:MoveTo(targetPoint)
                    end

                    local function toClipboard(String)
                        local clipBoard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
                        if clipBoard then
                            clipBoard(String)
                            notif2('Clipboard','Copied to clipboard', 2)
                        else
                            notif2('Clipboard',"Your exploit doesn't have the ability to use the clipboard", 2)
                        end
                    end

                    local function removeNumbers(string)
                        local x = string:gsub("%d", "")
                        return x
                    end
                -- ============================= à¸¥à¸³à¸”à¸±à¸šà¸‡à¸²à¸™ =============================

                    local function formatnum(num)
                        return string.gsub(num, "(%d)(%d%d%d)$", "%1,%2")  -- à¸•à¸±à¸§à¸­à¸¢à¹ˆà¸²à¸‡à¸à¸²à¸£à¹ƒà¸Šà¹‰à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸ªà¹ˆà¸„à¸±à¹ˆà¸™à¸žà¸±à¸™
                    end

                    local function all_trim(s)
                        if s == nil then s = " " end
                       return s:match( "^%s*(.-)%s*$" )
                    end

                    local function tweenFlyTo(targetPosition, speed, onComplete)
                        if not humanoidRootPart then
                            warn("HumanoidRootPart not found!")
                            return
                        end

                        humanoidRootPart.CanCollide = false
                        humanoidRootPart.Anchored = true 

                        local distance = (humanoidRootPart.Position - targetPosition).Magnitude 
                        local duration = distance / speed 
                        
                        local tweenInfo = TweenInfo.new(
                            duration, 
                            Enum.EasingStyle.Linear, 
                            Enum.EasingDirection.InOut 
                        )
                        local goal = { CFrame = CFrame.new(targetPosition) }
                        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
                        tween:Play()

                        tween.Completed:Connect(function()
                            humanoidRootPart.Anchored = false
                            humanoidRootPart.CanCollide = true
                            if onComplete then
                                onComplete()
                            end
                        end)
                    end

                    --// TWEEN PLAYER
                    local function Tween(P1, Speed)
                        local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = CFrame.new(P1.Position) * CFrame.new(5, 0, 0)}):Play()
                        if _G.StopTween then
                            TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = CFrame.new(P1.Position) * CFrame.new(5, 0, 0)}):Cancel()
                        end
                    end

                    local function isValidEnemy(enemy)
                        local healthBar = enemy:FindFirstChild("HealthBar")
                        local main = healthBar and healthBar:FindFirstChild("Main")
                        local bar = main and main:FindFirstChild("Bar")
                        local amount = bar and bar:FindFirstChild("Amount")
                    
                        if not amount or not amount:IsA("TextLabel") then return false end
                        
                        local hp = tonumber(string.match(amount.Text, "(%d+)"))
                        return hp and hp > 0
                    end

                    local function getDungeonPosition()
                        local dungeonFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Dungeon")
                        if dungeonFolder and #dungeonFolder:GetChildren() > 0 then
                            for _, obj in ipairs(dungeonFolder:GetChildren()) do
                                if obj:IsA("Model") then
                                    print("ðŸ° Found Dungeon (Model):", obj.Name, "| Position:", obj.WorldPivot.Position)
                                    return obj.WorldPivot.Position
                                end
                                if obj:IsA("Part") then
                                    print("ðŸ° Found Dungeon (Part):", obj.Name, "| Position:", obj.Position)
                                    return obj.Position
                                end
                            end
                        end

                        print("âš ï¸ No Dungeon Found!")
                        return nil
                    end

                    local function Autoquest()
                        local quests = game:GetService("Players").LocalPlayer.leaderstats.Quests:GetChildren()
                        for i,quest in pairs(quests) do
                            if quest:IsA("Folder") then
                                for x,q in pairs(quest:GetChildren()) do
                                    if q and q:IsA("Folder") then
                                        if q:FindFirstChild("Progress") then
                                            for y,w in pairs(q:FindFirstChild("Progress"):GetChildren()) do
                                                if w and w:IsA("Folder") then
                                                    if w:GetAttribute("Current") == w:GetAttribute("Max")then
                                                        local args = {
                                                            {
                                                                {
                                                                    Id = q.Name,
                                                                    Type = quest.Name,
                                                                    Event = "ClaimQuest"
                                                                },
                                                                "\f"
                                                            }
                                                        }
                                                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                                    end
                                                end
                                            end
                                            if quest.Name == "Normal" then
                                                local qq = removeNumbers(q.Name) 
                                                local quest1 = string.find(q.Name, "Title") or 0
                                                local quest2 = string.find(q.Name, "Sub") or 0
                                                local quest3 = string.find(q.Name, "Dedu") or 0
                                                local quest4 = string.find(q.Name, "WRed") or 0
                                                if quest1 == 0 and quest2 == 0 and quest3 == 0 and quest4 == 0 then
                                                    local args2 = {
                                                        {
                                                            {
                                                                Id = q.Name,
                                                                Type = quest.Name,
                                                                Event = "TrackQuest"
                                                            },
                                                            "\f"
                                                        }
                                                    }
                                                    game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args2))
                                                    task.wait(1)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                         end
                    end

                    local Main = Tabs.Main:AddSection("Main")
                -- ======== Auto Arise =========
                    local Toggle_quest = Main:AddToggle("autoQuest", {Title = "Auto Quest", Default = false})
                    Toggle_quest:OnChanged(function()
                        if Toggle_quest.Value then
                            while Toggle_quest.Value and task.wait(0.5) do
                                Autoquest()
                            end
                        end
                    end)
                    local Toggle_autoSetSpawn = Main:AddToggle("autoSetSpawn", {Title = "Auto Set Spawn Quest", Default = false})
                    Toggle_autoSetSpawn:OnChanged(function()
                        if Toggle_autoSetSpawn.Value then
                            while Toggle_autoSetSpawn.Value and task.wait(1) do
                                local quest = game:GetService("Players").LocalPlayer.PlayerGui.Hud.Hud.QuestFrame.QuestName.Text
                                if quest ~= "" then
                                    local xx = quest:split("Save Point:")
                                    if all_trim(xx[2]) ~= "" then
                                        if mapName[all_trim(xx[2])] then
                                            local args = {
                                                {
                                                    {
                                                        Event = "ChangeSpawn",
                                                        Spawn = mapName[all_trim(xx[2])]
                                                    },
                                                    "\f"
                                                }
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                            task.wait(2)
                                            game:GetService("Players").LocalPlayer.Character:BreakJoints()
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    local Toggle_AutoArise = Main:AddToggle("autoarise", {Title = "Auto Arise", Default = false})
                    Toggle_AutoArise:OnChanged(function()
                        if Toggle_AutoArise.Value then
                            -- Run in a separate task to prevent blocking
                                while Toggle_AutoArise.Value do
                                    -- Dynamically find the closest enemy with 0 HP
                                    local closestEnemy = nil
                                    local closestDistance = math.huge  -- Start with a large value for distance
                    
                                    -- Get the player's character
                                    local player = game.Players.LocalPlayer
                                    local playerCharacter = player.Character or player.CharacterAdded:Wait()
                                    local playerPosition = playerCharacter:WaitForChild("HumanoidRootPart").Position
                    
                                    -- Iterate through all enemies in the game
                                    for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                                        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                                            local healthBar = enemy:FindFirstChild("HealthBar")
                                            local main = healthBar and healthBar:FindFirstChild("Main")
                                            local title = main and main:FindFirstChild("Title")
                                            local bar = main and main:FindFirstChild("Bar")
                                            local amount = bar and bar:FindFirstChild("Amount")
                    
                                            if title and amount and title:IsA("TextLabel") and amount:IsA("TextLabel") then
                                                local hp = tonumber(string.match(amount.Text, "(%d+)"))
                                                if hp and hp == 0 then  -- Only consider enemies with 0 HP
                                                    -- Calculate the distance to the player
                                                    local enemyPosition = enemy:FindFirstChild("HumanoidRootPart").Position
                                                    local distance = (playerPosition - enemyPosition).magnitude
                    
                                                    -- If this enemy is closer than the previous one, select it
                                                    if distance < closestDistance then
                                                        closestEnemy = enemy
                                                        closestDistance = distance
                                                    end
                                                end
                                            end
                                        end
                                    end
                    
                                    -- If we found a valid closest enemy, send the capture event
                                    if closestEnemy then
                                        local args = {
                                            [1] = {
                                                [1] = {
                                                    ["Event"] = "EnemyCapture",
                                                    ["Enemy"] = closestEnemy.Name  -- Use the dynamically found enemy's name
                                                },
                                                [2] = "\4"
                                            }
                                        }
                    
                                        -- Fire the event to capture the closest enemy with 0 HP
                                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                    end
                    
                                    -- Wait before checking for the next enemy
                                    task.wait()
                                end
                        end
                    end)
                    
                    -- Auto Destroy
                    local toggle_autodestroy = Main:AddToggle("autodestroy", {Title = "Auto Destroy", Default = false})
                    toggle_autodestroy:OnChanged(function()
                        if toggle_autodestroy.Value then
                            -- Run in a separate task to prevent blocking
                                while toggle_autodestroy.Value do
                                    -- Dynamically find the closest enemy
                                    local closestEnemy = nil
                                    local closestDistance = math.huge  -- Start with a large value for distance
                    
                                    -- Get the player's character
                                    local player = game.Players.LocalPlayer
                                    local playerCharacter = player.Character or player.CharacterAdded:Wait()
                                    local playerPosition = playerCharacter:WaitForChild("HumanoidRootPart").Position
                    
                                    -- Iterate through all enemies in the game
                                    for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                                        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                                            -- Calculate the distance to the player
                                            local enemyPosition = enemy:FindFirstChild("HumanoidRootPart").Position
                                            local distance = (playerPosition - enemyPosition).magnitude
                    
                                            -- If this enemy is closer than the previous one, select it
                                            if distance < closestDistance then
                                                closestEnemy = enemy
                                                closestDistance = distance
                                            end
                                        end
                                    end
                    
                                    -- If we found a valid closest enemy, send the EnemyDestroy event
                                    if closestEnemy then
                                        local args = {
                                            [1] = {
                                                [1] = {
                                                    ["Event"] = "EnemyDestroy",
                                                    ["Enemy"] = closestEnemy.Name  -- Use the dynamically found enemy's name
                                                },
                                                [2] = "\4"
                                            }
                                        }
                    
                                        -- Fire the event to destroy the closest enemy
                                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                    end
                    
                                    -- Wait before checking for the next enemy
                                    task.wait()
                                end
                        end
                    end)

                -- ======== Auto Arise =========

                -- ======== Auto Farm =======
                    local function getEquippedPets()
                        local player = game:GetService("Players").LocalPlayer
                        local petsContainer = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("__Disable") 
                            and player.PlayerGui.__Disable:FindFirstChild("Menus") and player.PlayerGui.__Disable.Menus:FindFirstChild("Pets")
                            and player.PlayerGui.__Disable.Menus.Pets:FindFirstChild("Main") and player.PlayerGui.__Disable.Menus.Pets.Main:FindFirstChild("Container")
                    
                        local petsData = {}
                    
                        if petsContainer then
                            for _, pet in ipairs(petsContainer:GetChildren()) do
                                if pet:IsA("ImageButton") then
                                    local petName = pet.Name
                                    local main = pet:FindFirstChild("Main")
                                    local equipped = main and main:FindFirstChild("Equipped")
                    
                                    if equipped and equipped:IsA("ImageLabel") and equipped.Visible then
                                        petsData[petName] = true
                                    end
                                end
                            end
                        end
                        
                        return petsData
                    end

                    local function getClosestMonster()
                        local enemiesFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Client")
                        local player = game.Players.LocalPlayer
                        local character = player and player.Character
                        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

                        if not humanoidRootPart or not enemiesFolder or not enemiesFolder:IsA("Folder") then
                            return nil
                        end

                        local closestMonster = nil
                        local closestDistance = math.huge
                        local closestMonsterData = {}

                        for _, monster in pairs(enemiesFolder:GetChildren()) do
                            if monster:IsA("Model") then
                                if isValidEnemy(monster) then
                                    local monsterRoot = monster:FindFirstChild("HumanoidRootPart")
                                    local healthBar = monster:FindFirstChild("HealthBar")
                                    local monsterName = "Unknown"
                                    local monsterID = monster.Name
                                    local monsterHP = "Unknown"
                                    if healthBar then
                                        local main = healthBar:FindFirstChild("Main")
                                        if main then
                                            local title = main:FindFirstChild("Title")
                                            if title and title:IsA("TextLabel") then
                                                monsterName = title.Text
                                            end
    
                                            local bar = main:FindFirstChild("Bar")
                                            if bar then
                                                local amount = bar:FindFirstChild("Amount")
                                                if amount and amount:IsA("TextLabel") then
                                                    monsterHP = amount.Text
                                                end
                                            end
                                        end
                                    end
    
                                    if monsterRoot then
                                        local distance = (humanoidRootPart.Position - monsterRoot.Position).Magnitude
                                        if distance < closestDistance then
                                            closestDistance = distance
                                            closestMonster = monster
                                            closestMonsterData = {
                                                Name = monsterName,
                                                ID = monsterID,
                                                HP = monsterHP,
                                                Position = monsterRoot.Position,
                                                Monster = monster
                                            }
                                        end
                                    end
                                end
                            end
                        end
                        return closestMonsterData
                    end

                    local function attackMonster(closestMonsterID, petPositions)
                        if not closestMonsterID or not petPositions then
                            return
                        end
                        local args = {
                            {
                                {
                                    PetPos = petPositions,
                                    AttackType = "All",
                                    Event = "Attack",
                                    Enemy = closestMonsterID
                                },
                                "\005"
                            }
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                    end

                    
                    spawn(function()
                        while true and task.wait(0.1) do
                            local proximiStuck = game:GetService("Players").LocalPlayer.PlayerGui
                            if proximiStuck:FindFirstChild("ProximityPrompts") then
                                proximiStuck = proximiStuck.ProximityPrompts:GetChildren()
                                if #proximiStuck then
                                    for i, proxi in pairs(proximiStuck) do
                                        if proxi then
                                            if proxi.Name == "Arise" or proxi.Name == "Destroy" then
                                                proxi:Destroy()
                                            end
                                        end
                                    end
                                end
                            end
                            if not VariableIndex.AutoFarm then
                                if isAttacking then
                                    isAttacking = false
                                end
                                wait(0.5)
                                continue
                            end
                            local enemiesFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Client")
                            local closestMonster = getClosestMonster()
                            local equippedPets = getEquippedPets()
                            
                            if closestMonster and closestMonster.ID then
                                local player = game.Players.LocalPlayer
                                local character = player.Character
                                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

                                if not humanoidRootPart then
                                    continue
                                end

                                local distanceToMonster = (humanoidRootPart.Position - closestMonster.Position).Magnitude

                                if distanceToMonster >= distanceEnemys then
                                    isAttacking = false
                                end

                                local hpValue = tonumber(closestMonster.HP:match("[%d%.]+")) or 0

                                if hpValue > 0 and not isAttacking and distanceToMonster < distanceEnemys then
                                    isAttacking = true
                                    enemytargetReal = closestMonster.Monster
                                    local petPositions = {}
                                    local basePos = closestMonster.Position
                                    distanceToMonster = (humanoidRootPart.Position - closestMonster.Position).Magnitude
                                    if distanceToMonster >= distanceEnemys then
                                        isAttacking = false
                                    end
                                    local offset = 3

                                    for petID, _ in pairs(equippedPets) do
                                        petPositions[petID] = basePos + Vector3.new(math.random(-offset, offset), 0, math.random(-offset, offset))
                                    end

                                    attackMonster(closestMonster.ID, petPositions)
                                else
                                    isAttacking = false
                                end
                            else
                                isAttacking = false
                            end
                        end
                    end)

                    local AutoSection = Tabs.Auto:AddSection("Config Auto")
                    local Toggle_AutoFarm = AutoSection:AddToggle("Toggle_AutoFarm", { Title = "Auto Farm", Default = false })
                    Toggle_AutoFarm:OnChanged(function()
                        VariableIndex.AutoFarm = Toggle_AutoFarm.Value
                        if not VariableIndex.AutoFarm then
                            isAttacking = false
                        end
                    end)

                    Options.Toggle_AutoFarm:SetValue(false)
                    local autohit = AutoSection:AddToggle("autohit", {Title = "Auto Attack", Default = false})
                    autohit:OnChanged(function()
                        if autohit.Value then
                            -- Run in a separate task to prevent blocking
                                while autohit.Value do
                                    -- Dynamically find the closest enemy
                                    local closestEnemy = nil
                                    local closestDistance = math.huge  -- Start with a large value for distance
                                    -- Get the player's character
                                    local player = game.Players.LocalPlayer
                                    local playerCharacter = player.Character or player.CharacterAdded:Wait()
                                    local playerPosition = playerCharacter:WaitForChild("HumanoidRootPart").Position
                                    -- Iterate through all enemies in the game
                                    for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                                        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                                            -- Calculate the distance to the player
                                            local enemyPosition = enemy:FindFirstChild("HumanoidRootPart").Position
                                            local distance = (playerPosition - enemyPosition).magnitude
                                            -- If this enemy is closer than the previous one, select it
                                            if distance < closestDistance then
                                                closestEnemy = enemy
                                                closestDistance = distance
                                            end
                                        end
                                    end
                                    -- If we found a valid closest enemy, send the PunchAttack event
                                    if closestEnemy then
                                        local args = {
                                            [1] = {
                                                [1] = {
                                                    ["Event"] = "PunchAttack",
                                                    ["Enemy"] = closestEnemy.Name  -- Use the dynamically found enemy's name
                                                },
                                                [2] = "\4"
                                            }
                                        }
                    
                                        -- Fire the event to hit the closest enemy
                                        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                    end
                                    -- Wait before checking for the next enemy
                                    task.wait()
                                end
                        end
                    end)

                    local playerposisi
                    local playerinposition = 0
                    local RoomDungeons = ""
                    local RoomDungeons2 = 0
                    local ToggleTweenToMonster = AutoSection:AddToggle("ToggleTweenToMonster", { Title = "Tween To Monster", Default = false })
                    ToggleTweenToMonster:OnChanged(function(Value)
                        VariableIndex.TweenToMonster = Value
                        if VariableIndex.TweenToMonster then
                            while VariableIndex.TweenToMonster and task.wait() do
                                local playerPosition = humanoidRootPart.Position
                                if game.PlaceId == 128336380114944 and playerposisi == playerPosition then
                                    local hudRoom = game:GetService("Players").LocalPlayer.PlayerGui.Hud.UpContanier
                                    if hudRoom:FindFirstChild("Room") then
                                        local infoRoom = hudRoom.Room.Text:split("/") or {}
                                        if #infoRoom > 1 then
                                            local infoRoomValue = tonumber(infoRoom[1]:match("[%d%.]+")) or 0
                                            if infoRoomValue ~= nil then
                                                if infoRoomValue > 1 then
                                                    if workspace.__Main.__World:FindFirstChild("Room_"..infoRoomValue) and infoRoomValue ~= 500 then
                                                        local RoomDungeon = workspace.__Main.__World:FindFirstChild("Room_"..infoRoomValue):FindFirstChild("Entrace")
                                                        local ParentRoom = workspace.__Main.__World:FindFirstChild("Room_"..infoRoomValue)
                                                        playerinposition = playerinposition + 1
                                                        if RoomDungeons ~= ParentRoom.Name and playerinposition > 10 then
                                                            RoomDungeons2 = tonumber(infoRoom[2]:match("[%d%.]+")) or 0
                                                            RoomDungeons = ParentRoom.Name
                                                            player:RequestStreamAroundAsync(RoomDungeon.Position)
                                                            Tween(RoomDungeon, 500)
                                                            playerinposition = 0
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                local closestEnemy = nil
                                local closestDistance = math.huge
                                playerposisi = playerPosition
                                -- Find the closest valid enemy (any enemy with health > 0)
                                for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
                                    if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and isValidEnemy(enemy) then
                                        local distance = (enemy.HumanoidRootPart.Position - playerPosition).Magnitude
                                        if distance < closestDistance then
                                            closestDistance = distance
                                            closestEnemy = enemy
                                        end
                                    end
                                end
                                
                                if closestEnemy then
                                    -- Teleport to the enemy
                                    player:RequestStreamAroundAsync(closestEnemy.HumanoidRootPart.Position)
                                    closestEnemy.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
                                    task.wait()
                                    local distancex = (closestEnemy.HumanoidRootPart.Position - playerPosition).Magnitude

                                    while closestEnemy:FindFirstChild("HealthBar") do
                                        if isAttacking == false then
                                            Tween(closestEnemy.HumanoidRootPart, 500)
                                        end
                                        local healthBar = closestEnemy.HealthBar:FindFirstChild("Main")
                                        local amount = healthBar and healthBar:FindFirstChild("Bar") and healthBar.Bar:FindFirstChild("Amount")
                                        
                                        if amount and amount:IsA("TextLabel") then
                                            local health = tonumber(string.match(amount.Text, "(%d+)"))
                                            if not health or health <= 0 then 
                                                isAttacking = false
                                                break
                                            end
                                        end
                                        task.wait()
                                    end
                                end
                                
                            end
                        end
                    end)

                -- ======== Auto Farm =======

                    local DungeonSelect = {}
                    local DungeonList = {"E", "D", "C", "B", "A", "S", "SS", "N", "G", "M"}

                    local Dungeon1 = Tabs.Dungeon:AddDropdown("MultiDropdown", {
                        Title = "Select Rank",
                        Description = "Select Rank Dungeon.",
                        Values = {"E", "D", "C", "B", "A", "S", "SS", "N", "G", "M"},
                        Multi = true,
                        Default = {},
                    })

                    Dungeon1:OnChanged(function(Value)
                        local Values = {}
                        local RankNunber = 0
                            local Values = {}
                            for Value, State in next, Value do
                                if Value == "E" then
                                    RankNunber = 1
                                end
                                if Value == "D" then
                                    RankNunber = 2
                                end
                                if Value == "C" then
                                    RankNunber = 3
                                end
                                if Value == "B" then
                                    RankNunber = 4
                                end
                                if Value == "A" then
                                    RankNunber = 5
                                end
                                if Value == "S" then
                                    RankNunber = 6
                                end
                                if Value == "SS" then
                                    RankNunber = 7
                                end
                                if Value == "G" then
                                    RankNunber = 8
                                end
                                if Value == "N" then
                                    RankNunber = 9
                                end
                                if Value == "M" then
                                    RankNunber = 10
                                end
                                table.insert(Values, RankNunber)
                            end
                        DungeonSelect = Values
                    end)
                    local stayPlayerInDungeon = 0
                    local toggleAutoJoinDungeon = Tabs.Dungeon:AddToggle("AutoJoinDungeon", { Title = "Auto Join Dungeon / Rejoin / Leave", Default = false })
                    toggleAutoJoinDungeon:OnChanged(function()
                        VariableIndex.AutoJoinDungeon = toggleAutoJoinDungeon.Value
                        if VariableIndex.AutoJoinDungeon then
                            while VariableIndex.AutoJoinDungeon and task.wait() do
                                if DungeonSelect ~= nil then
                                    local defaultDungeon = workspace:FindFirstChild("__Main"):FindFirstChild("__Dungeon")
                                    if defaultDungeon:FindFirstChild("Dungeon") then
                                        print(table.find(DungeonSelect, defaultDungeon:FindFirstChild("Dungeon"):GetAttribute("DungeonRank")))
                                        if table.find(DungeonSelect, defaultDungeon:FindFirstChild("Dungeon"):GetAttribute("DungeonRank")) ~= nil then
                                            local args = {
                                                {
                                                    {
                                                        Event = "DungeonAction",
                                                        Action = "Create"
                                                    },
                                                    "\f"
                                                }
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                            task.wait(1)
                                            local args2= {
                                                {
                                                    {
                                                        Event = "DungeonAction",
                                                        Action = "Start"
                                                    },
                                                    "\f"
                                                }
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args2))
                                            task.wait(5)
                                        end
                                    else
                                        if stayPlayerInDungeon > 5 then
                                            stayPlayerInDungeon = 0
                                            local args = {
                                                {
                                                    {
                                                        Event = "LeaveDungeon"
                                                    },
                                                    "\f"
                                                }
                                            }
                                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                        elseif RoomDungeons == "Room_"..RoomDungeons2 then
                                            stayPlayerInDungeon = stayPlayerInDungeon + 1
                                            task.wait(1)
                                        end
                                    end
                                end
                            end
                            if DungeonSelect == nil or #DungeonSelect == 0 then
                                notif("Select Dungeon Rank First", 2)
                            end
                        end
                    end)

                    local toggleAutoJoinSummer = Tabs.Dungeon:AddToggle("AutoJoinSummer", { Title = "Auto Join Summer", Default = false })
                    toggleAutoJoinSummer:OnChanged(function()
                        if toggleAutoJoinSummer.Value then
                            while toggleAutoJoinSummer.Value and task.wait() do
                                if game.PlaceId ~= 128336380114944 then
                                    local args = {
                                        {
                                            {
                                                Event = "InfiniteModeAction",
                                                Action = "Create"
                                            },
                                            "\f"
                                        }
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                    task.wait(1)
                                    local args2= {
                                        {
                                            {
                                                Event = "InfiniteModeAction",
                                                Action = "Start"
                                            },
                                            "\f"
                                        }
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args2))
                                    task.wait(5)
                                end
                            end
                            
                            if DungeonSelect == nil or #DungeonSelect == 0 then
                                notif("Select Dungeon Rank First", 2)
                            end
                        end
                    end)

                    local Toggle_AutoRankTest = Tabs.Dungeon:AddToggle("Toggle_AutoRankTest", { Title = "Auto Up Rank", Default = false })
                    Toggle_AutoRankTest:OnChanged(function()
                        local rankUp = false
                        while Toggle_AutoRankTest.Value and not rankUp do
                            if Toggle_AutoRankTest.Value and not rankUp then
                                if game.PlaceId ~= 128336380114944 then
                                    local args = {
                                        {
                                            {
                                                Event = "DungeonAction",
                                                Action = "TestEnter"
                                            },
                                            "\f"
                                        }
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                    task.wait(2)
                                    rankUp = true
                                end
                            end
                        end
                    end)

                    Tabs.Dungeon:AddButton({
                        Title = "Teleport to Dungeon",
                        Callback = function()
                            if locations[Teleport_Target] then
                                tweenFlyTo(locations[Teleport_Target], 500, function()
                                    local dungeonPosition = getDungeonPosition()
                                    if dungeonPosition then
                                        tweenFlyTo(dungeonPosition, 500)
                                    else
                                        print("âŒ No Dungeon available to travel to!")
                                    end
                                end)
                            else
                                print("âŒ Invalid Teleport Target:", Teleport_Target)
                            end
                        end
                    })

                    -- ======== Teleport =======

                    local locations = {
                        ["Leveling City"] = Vector3.new(156.59788513183594, 28.27948570251465, -342.618408203125), -- Leveling City
                        ["Grass Village"] = Vector3.new(-3516.568603515625, 59.03760528564453, 2479.522216796875), -- Grass Village
                        ["Brum Island"] = Vector3.new(-3006.69140625, 64.56521606445312, -2253.248291015625), -- Brum Island
                        ["Faceheal Town"] = Vector3.new(2949.715087890625, 50.4575309753418, -2656.518798828125), -- Faceheal Town
                        ["Mont1"] = Vector3.new(-6170.7802734375, 77.83106994628906, 5438.39013671875),
                        ["Mont2"] = Vector3.new(466.29296875, 117.56482696533203, 3452.061279296875),
                        ["Mont3"] = Vector3.new(3302.868896484375, 83.15568542480469, 28.682985305786133),
                        ["Mont4"] = Vector3.new(4327.86669921875, 118.99542999267578, -4818.9599609375),
                        ["Mont5"] = Vector3.new(-621.42041015625, 107.75682830810547, -3568.83251953125),
                        ["Mont6"] = Vector3.new(-5418.4736328125, 107.44157409667969, -5521.29638671875),
                        ["Mont7"] = Vector3.new(-5881.2021484375, 81.40789031982422, 387.6292724609375)
                    }

                    local Teleport_Target = "Leveling City"
                    local Dropdown_tptarget = Tabs.Teleport:AddDropdown("Dropdown_tptarget", {
                        Title = "Select Teleport Target",
                        Values = {"Leveling City", "Grass Village", "Brum Island" , "Faceheal Town" , "Mont1", "Mont2", "Mont3", "Mont4", "Mont5", "Mont6", "Mont7"},
                        Multi = false,
                        Default = "Leveling City",
                    })
                    Dropdown_tptarget:SetValue("Leveling City")
                    Dropdown_tptarget:OnChanged(function(Value)
                        Teleport_Target = Value
                    end)
                    Tabs.Teleport:AddButton({
                        Title = "Teleport to Target",
                        Callback = function()
                            if locations[Teleport_Target] then
                                tweenFlyTo(locations[Teleport_Target], 500)
                            else
                                print("âŒ Invalid Teleport Target:", Teleport_Target)
                            end
                        end
                    })
                -- ======== Teleport =======

            -- ====================================  Tools  ====================================
                local Tools_Option = Tabs.Tools:AddSection("Option")
                local ToggleAntiAFK = Tools_Option:AddToggle("AntiAFK", {Title = "AntiAFK", Default = true })
                ToggleAntiAFK:OnChanged(function(Value)
                    VariableIndex.AntiAFKs = Value
                end)

                local ToggleWhiteScreen = Tools_Option:AddToggle("WhiteScreen", {Title = "White Screen", Default = false })
                ToggleWhiteScreen:OnChanged(function(Value)
                    if Value then
                        game:GetService("RunService"):Set3dRenderingEnabled(false)
                    else
                        game:GetService("RunService"):Set3dRenderingEnabled(true)
                    end
                end)
                
                Tools_Option:AddButton({
                    Title = "Low VFX",
                    Callback = function()
                        workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
                        workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
                        workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
                        workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
                        game:GetService("Lighting").GlobalShadows = false
                        game:GetService("Lighting").FogEnd = 9e9
                        settings().Rendering.QualityLevel = 1
                        for i,v in pairs(workspace:GetDescendants()) do
                            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                                v.Material = "Plastic"
                                v.Reflectance = 0
                            elseif v:IsA("Decal") then
                                v.Transparency = 1
                            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                                v.Lifetime = NumberRange.new(0)
                            elseif v:IsA("Explosion") then
                                v.BlastPressure = 1
                                v.BlastRadius = 1
                            end
                        end
                        for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
                            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                                v.Enabled = false
                            end
                        end
                    end
                })
                Tools_Option:AddButton({
                    Title = "BoostFPS",
                    Callback = function()
                        local ToDisable = {
                            Textures = true,
                            VisualEffects = true,
                            Parts = true,
                            Particles = true,
                            Sky = true
                        }
                    
                        local ToEnable = {
                            FullBright = false
                        }
                    
                        local Stuff = {}
                    
                        for _, v in next, game:GetDescendants() do
                            if ToDisable.Parts then
                                if v:IsA("Part") or v:IsA("Union") or v:IsA("BasePart") then
                                    v.Material = Enum.Material.SmoothPlastic
                                    table.insert(Stuff, 1, v)
                                end
                            end
                    
                            if ToDisable.Particles then
                                if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Explosion") or v:IsA("Sparkles") or v:IsA("Fire") then
                                    v.Enabled = false
                                    table.insert(Stuff, 1, v)
                                end
                            end
                    
                            if ToDisable.VisualEffects then
                                if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
                                    v.Enabled = false
                                    table.insert(Stuff, 1, v)
                                end
                            end
                    
                            if ToDisable.Textures then
                                if v:IsA("Decal") or v:IsA("Texture") then
                                    v.Texture = ""
                                    table.insert(Stuff, 1, v)
                                end
                            end
                    
                            if ToDisable.Sky then
                                if v:IsA("Sky") then
                                    v.Parent = nil
                                    table.insert(Stuff, 1, v)
                                end
                            end
                        end
                    
                        game:GetService("TestService"):Message("Effects Disabler Script : Successfully disabled "..#Stuff.." assets / effects. Settings :")
                    
                        for i, v in next, ToDisable do
                            print(tostring(i)..": "..tostring(v))
                        end
                    
                        if ToEnable.FullBright then
                            local Lighting = game:GetService("Lighting")
                    
                            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
                            Lighting.FogEnd = math.huge
                            Lighting.FogStart = math.huge
                            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                            Lighting.Brightness = 5
                            Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
                            Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
                            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                            Lighting.Outlines = true
                        end
                    end
                })

                local Tools_Addon = Tabs.Tools:AddSection("Addon")
                Tools_Addon:AddButton({
                    Title = "Copy Position",
                    Callback = function()
                        toClipboard(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position))
                    end
                })
                Tools_Addon:AddButton({
                    Title = "Rejoin",
                    -- Description = "Click here to Teleport the map.",
                    Callback = function()
                        local ts = game:GetService("TeleportService") local p = game.Players.LocalPlayer ts:Teleport(game.PlaceId, p) 
                    end
                })
                Tools_Addon:AddButton({
                    Title = "Copy JobID",
                    -- Description = "Click here to Teleport the map.",
                    Callback = function()
                        toClipboard(game.JobId)
                    end
                })
                local InputJobID = Tools_Addon:AddInput("InputJobID", {
                    Title = "JobID",
                    Default = "",
                    Numeric = false, -- Only allows numbers
                    Finished = true, -- Only calls callback when you press enter
                    Callback = function(Value)
                        JobIdInput = Value 
                    end
                })
                Tools_Addon:AddButton({
                    Title = "Copy JobID",
                    Description = "Click here to Join JobID",
                    Callback = function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, JobIdInput)
                    end
                })
                Tools_Addon:AddButton({
                    Title = "Close UI",
                    -- Description = "Click here to Join JobID",
                    Callback = function()
                        Fluent:Destroy()
                    end
                })
            -- ====================================  Tools  ====================================
            if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
                icons ()
            end
        end
    -- ============================================= Other Code End =================================

    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    SaveManager:IgnoreThemeSettings()

    SaveManager:SetIgnoreIndexes({})

    InterfaceManager:SetFolder("AKbarhub")
    SaveManager:SetFolder("AKbarhub/Arise-Crossover")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    Window:SelectTab(1)

    
    -- ====== AnitiAFK ======
        local vu = game:GetService("VirtualUser")
        local ViSendMouseButtonEvent = game:service'VirtualInputManager'
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    -- ====== AnitiAFK ======
    Fluent:Notify({
        Title = "Akbar Hub | "..GameName,
        Content = "The script has been loaded.",
        SubContent = "", -- Optional
        Duration = 3 -- Set to nil to make the notification not disappear
    })
    task.spawn(function()
        local radars =  workspace.__Extra:FindFirstChild("Radars")
        if radars then
            radars = radars:GetChildren()
            if #radars then
                for _, island in pairs(radars) do
                    if island:IsA("Part") then
                        if island:FindFirstChild("BillboardGui") then
                            if not island:FindFirstChild("BillboardGui"):FindFirstChild("TextIslandName") then
                                local TextIslandName = Instance.new("TextLabel")
                                TextIslandName.Name = "TextIslandName"
                                TextIslandName.Parent = island:FindFirstChild("BillboardGui") 
                                TextIslandName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                TextIslandName.Position = UDim2.new(0, 0, 0, 0)
                                TextIslandName.Size = UDim2.new(0, 50, 0, 50)
                                TextIslandName.Font = Enum.Font.SourceSans
                                TextIslandName.Text = island.Name
                                TextIslandName.TextColor3 = Color3.fromRGB(0, 0, 0)
                                TextIslandName.TextSize = 14.000
                            end
                        end
                    end
                    task.wait(1)
                end
            end
        end
    end)
    SaveManager:LoadAutoloadConfig()
end
