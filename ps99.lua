-- ts file was generated at discord.gg/25ms

task.spawn(function()
    local function checkErrorPrompt()
        local errorPrompt = game:GetService("CoreGui"):WaitForChild("RobloxPromptGui", 60):WaitForChild("promptOverlay", 60):WaitForChild("ErrorPrompt", 999999)
        print("Found:", errorPrompt)
        if errorPrompt then
            game["Teleport Service"]:Teleport(game.PlaceId)
        end
    end
    
    while true do
        checkErrorPrompt()
        task.wait(1)
    end
end)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

game:GetService("TweenService")
game:GetService("UserInputService")

function antiafk()
    if getgenv().AA then
        return
    else
        print("Anti-Afk Inited.")
        local networkModule = require(game.ReplicatedStorage.Library.Client.Network)
        local originalFire = networkModule.Fire
        setreadonly(networkModule, false)
        
        function networkModule.Fire(...)
            local args = {...}
            if args[1] ~= "Idle Tracking: Update Timer" then
                return originalFire(...)
            end
        end
        
        setreadonly(networkModule, true)
        
        -- Disable window focus change connections
        for _, connection in pairs(getconnections(game.UserInputService.WindowFocusReleased)) do
            if connection.Disable then
                connection:Disable()
            end
        end
        
        for _, connection in pairs(getconnections(game.UserInputService.WindowFocused)) do
            if connection.Disable then
                connection:Disable()
            end
        end
        
        getgenv().AA = true
        
        while true do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Unknown, false, nil)
            wait(math.random(15, 120))
        end
    end
end

local keySystemLoaded = false
local keySystemValid = false
local keySystemFunction = nil

task.spawn(function()
    local success, keyFunction, isValid, loadFunction = pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/Verteniasty/Pet-rbx/refs/heads/main/KeySystemMain.lua")))
    if success then
        keySystemFunction = loadFunction
        keySystemValid = isValid
        keySystemLoaded = true
    end
end)

local numbers = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
local characterSets = {
    {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"},
    numbers
}

local function generateRandomString(length)
    local result = ""
    for _ = 1, length do
        local charSet = characterSets[math.random(1, #characterSets)]
        result = result .. charSet[math.random(1, #charSet)]
    end
    return result
end

local executorName = identifyexecutor()
local blunderModule = require(game.ReplicatedStorage.Blunder.BlunderMessage)
local originalKeyFunction = blunderModule.key
setreadonly(blunderModule, false)

function blunderModule.key(...)
    local args = ...
    if args.message == "PING" or args.message == "Anti Cheat fetched error in console" then
        return originalKeyFunction(...)
    end
    
    warn("Anti Cheat fetched error in console")
    print("BLUNDER")
    print(args.messageType)
    print(args.message, "\n")
    
    -- Send webhook notification about error
    local embeds = {
        {
            color = 16711680, -- Red
            fields = {
                {
                    name = "Error Message",
                    value = args.message
                },
                {
                    name = "Error Traceback",
                    value = args.stackTrace
                }
            },
            thumbnail = {
                url = "https://cdn.discordapp.com/attachments/1350493793803042816/1350494850935422986/warning.png"
            },
            footer = {
                text = game.Players.LocalPlayer.Name .. executorName
            }
        }
    }
    
    -- Webhook sending logic would go here
end

setreadonly(blunderModule, true)

getgenv().VRT = {
    Lib = {}
}

-- Load library modules
for _, moduleScript in pairs(game:GetService("ReplicatedStorage").Library.Client:GetDescendants()) do
    if moduleScript:IsA("ModuleScript") then
        local success, module = pcall(function()
            return require(moduleScript)
        end)
        
        if success then
            getgenv().VRT.Lib[tostring(moduleScript)] = module
            getgenv().VRT.Lib[1] = "Inited"
        end
    end
end

local function checkRequestHook()
    local flags = {}
    if debug.getinfo(getgenv().request).what == "Lua" then
        table.insert(flags, "WHAT")
    end
    if isfunctionhooked(request) then
        table.insert(flags, "FH1")
    end
    if isfunctionhooked(getgenv().request) then
        table.insert(flags, "FH2")
    end
    return #flags > 0, flags
end

function SendWebhook(webhookUrl, data)
    local isHooked, _ = checkRequestHook()
    if not isHooked then
        request({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game.HttpService:JSONEncode(data)
        })
    end
end

local scriptVersion = nil

task.spawn(function()
    scriptVersion = request({
        Url = "https://raw.githubusercontent.com/Verteniasty/Pets-Go/refs/heads/main/Version",
        Method = "GET"
    }).Body
    
    local executor = identifyexecutor() or "Unknown"
    local gameInfo = game.MarketplaceService:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
    
    local webhookData = {
        username = "Execution Logs",
        footer = {
            text = "Vrt Execution Log",
            icon_url = "https://cdn.discordapp.com/icons/1103035026930671656/724be00a3c4c6abaa52dc3d0dfff8991.webp"
        },
        embeds = {
            {
                title = "New Execution",
                color = 4962791,
                fields = {
                    {
                        name = "",
                        value = "**Player Name: " .. game.Players.LocalPlayer.Name .. "**\n" ..
                               "Placeid: " .. game.PlaceId .. "\n" ..
                               "Game Name: " .. gameInfo.Name .. "\n" ..
                               "Execution Time: " .. os.date("%c") .. "\n" ..
                               "Executor: " .. executor .. "**\n" ..
                               "Script version: " .. scriptVersion
                    }
                }
            }
        }
    }
    
    SendWebhook("https://discord.com/api/webhooks/1360241802187112569/Xy16q8-7oTrrnVed2iRNKssVXy24oAtVqstyX47AL1VAQ3CTIeSEvtJlrw8yOgRo4g7t", webhookData)
end)

game:GetService("RunService")

-- Initialize required modules
local network = require(game:WaitForChild("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Network"))
local itemsModule = require(game:GetService("ReplicatedStorage").Library.Items)
local petAssignments = {}
local playerPetsList = {}
local allPets = {}
local playerPetModule = require(game.ReplicatedStorage.Library.Client.PlayerPet)
local eggOpeningModule = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game["Egg Opening Frontend"])
local notificationModule = require(game:GetService("ReplicatedStorage").Library.Client.NotificationCmds)
local instanceModule = require(game:GetService("ReplicatedStorage").Library.Client.InstancingCmds)
local instanceZoneModule = require(game:GetService("ReplicatedStorage").Library.Client.InstanceZoneCmds)

require(game:GetService("ReplicatedStorage").Library.Client.CustomEggsCmds)
local eggCommands = require(game:GetService("ReplicatedStorage").Library.Client.EggCmds)
require(game:GetService("ReplicatedStorage").Library.Types.Quests)
require(game.ReplicatedStorage.Library.Client.Save)

local currentInstance = nil
local currentInstanceId = nil
local currentInstanceFolder = nil
local currentEventName = nil
local currentQuestData = {}

getgenv().v_settings = {
    functionToggles = {
        MailboxEnabled = false,
        HugeMailboxEnabled = false,
        MailboxUsername = "",
        MailboxItems = {},
        InputedMailboxItem = "",
        InputedMailboxAmount = 0,
        MailboxSendHugesType = "",
        MailboxClaimAll = false,
        SelectedLootboxes = {},
        SelectedGifts = {},
        SelectedChestsUpgrades = {},
        BuySelectedChestUpgrades = false,
        ChestHeroicMode = false
    },
    functionsValues = {
        ClickAuraValue = 75,
        EggAnimation = eggOpeningModule.PlayEggAnimation,
        PetSpeed = playerPetModule.CalculateSpeedMultiplier
    },
    functions = {
        CollectOrbs = function()
            for _, orb in pairs(game:GetService("Workspace").__THINGS:FindFirstChild("Orbs"):GetChildren()) do
                network.Fire("Orbs: Collect", {tonumber(orb.Name)})
                orb:Destroy()
            end
        end,
        
        ClickAura = function()
            if not game.Players.LocalPlayer.Character then
                return
            end
            
            local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
            local clickAuraRange = getgenv().v_settings.functionsValues.ClickAuraValue
            
            for _, breakable in pairs(workspace.__THINGS:WaitForChild("Breakables"):GetChildren()) do
                if breakable:IsA("Model") and (playerRoot.Position - breakable.WorldPivot.Position).Magnitude < clickAuraRange then
                    network.UnreliableFire("Breakables_PlayerDealDamage", breakable.Name)
                    break
                end
            end
        end,
        
        VisualizeClickAura = function(range)
            if workspace:FindFirstChild("ClickAuraVisualizer") and getgenv().v_settings.functionToggles.ClickAuraVisualizer then
                local visualizer = workspace:FindFirstChild("ClickAuraVisualizer")
                visualizer.Size = Vector3.new(0.2, range * 2, range * 2)
                visualizer.Rotation = Vector3.new(0, 0, 90)
                return visualizer
            end
            
            if getgenv().v_settings.functionToggles.ClickAuraVisualizer then
                local visualizer = Instance.new("Part", workspace)
                visualizer.Name = "ClickAuraVisualizer"
                visualizer.CanCollide = false
                visualizer.Anchored = true
                visualizer.Shape = "Cylinder"
                visualizer.Size = Vector3.new(0.2, range * 2, range * 2)
                visualizer.Transparency = 0.5
                visualizer.BrickColor = BrickColor.new("Light green (Mint)")
                visualizer.Rotation = Vector3.new(0, 0, 90)
                return visualizer
            end
        end,
        
        OptimizeBreakables = function()
            getgenv().v_settings.OptimizeBreakables = workspace.__DEBRIS.ChildAdded:Connect(function(child)
                pcall(function()
                    game.Debris:AddItem(child, 0)
                end, function() end)
            end)
        end,
        
        OptimizePets = function()
            for _, petModel in pairs(workspace.__THINGS.Pets:GetChildren()) do
                for _, descendant in pairs(petModel:GetDescendants()) do
                    if descendant:IsA("Part") then
                        descendant.Color = Color3.fromRGB(255, 255, 255)
                        descendant.Size = Vector3.new(2.5, 2.5, 2.5)
                        descendant.Material = Enum.Material.SmoothPlastic
                    elseif descendant:IsA("SpecialMesh") or descendant:IsA("ParticleEmitter") or descendant:IsA("MeshPart") or descendant:IsA("Decal") then
                        descendant:Destroy()
                    end
                end
            end
        end,
        
        FastFarm = function()
            table.clear(petAssignments)
            local closestBreakables = GetClosestBreakables()
            local pets = PlayerPets()
            local petsPerBreakable = math.floor(#pets / #closestBreakables)
            local remainder = #pets % #closestBreakables
            
            local petIndex = 1
            for breakableIndex, breakableName in pairs(closestBreakables) do
                local assignedPets = petsPerBreakable
                if breakableIndex <= remainder then
                    assignedPets = assignedPets + 1
                end
                
                for _ = 1, assignedPets do
                    if pets[petIndex] then
                        petAssignments[pets[petIndex].euid] = breakableName
                        petIndex = petIndex + 1
                    end
                end
            end
            
            network.Fire("Breakables_JoinPetBulk", petAssignments)
        end,
        
        FastFarm2 = function()
            table.clear(petAssignments)
            local closestBreakables = GetClosestBreakables()
            local pets = PlayerPets()
            
            for _, pet in pairs(pets) do
                local randomBreakable = RandomCoinNumber(closestBreakables)
                if randomBreakable then
                    petAssignments[pet.Name] = randomBreakable
                end
            end
            
            network.Fire("Breakables_JoinPetBulk", petAssignments)
        end,
        
        OpenClosestEgg = function()
            local maxHatch = eggCommands.GetMaxHatch()
            local closestCustomEgg, customEggDistance = FindClosestCustomEgg()
            local closestEgg, eggDistance = FindClosestEgg()
            
            if eggDistance and customEggDistance then
                if customEggDistance < eggDistance then
                    network.Invoke("CustomEggs_Hatch", tostring(closestCustomEgg), maxHatch)
                elseif eggDistance < customEggDistance then
                    network.Invoke("Eggs_RequestPurchase", closestEgg, maxHatch)
                end
            end
        end,
        
        HugePetSpeed = function()
            function playerPetModule.CalculateSpeedMultiplier()
                return math.huge
            end
        end,
        
        HideEggAnimation = function()
            function eggOpeningModule.PlayEggAnimation()
                -- Empty function to hide animation
            end
        end,
        
        HookEggAnimation = function()
            eggOpeningModule.PlayEggAnimation = getgenv().v_settings.functionsValues.EggAnimation
            function eggOpeningModule.PlayEggAnimation(eggName)
                local maxHatch = require(game:GetService("ReplicatedStorage").Library.Client.EggCmds).GetMaxHatch()
                notificationModule.Message.Bottom({
                    Message = "Still Opening " .. eggName .. " " .. tostring(maxHatch),
                    Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                })
            end
        end,
        
        CombinePetCards = function()
            local inventory = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory
            if not inventory.Card then
                print("Don't have any cards")
                return "Don't have any cards"
            end
            
            local cards = inventory.Card
            local function calculateCombinedAmount(amount)
                local result = amount / 3
                if result % 1 ~= 0 then
                    -- Handle remainder
                end
                return result
            end
            
            local cardsToCombine = {}
            for cardId, cardData in pairs(cards) do
                local cardAmount = cardData._am or 1
                if cardAmount >= 3 then
                    cardsToCombine[cardId] = calculateCombinedAmount(cardAmount)
                end
            end
            
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CardCombinationMachine_ActivateBulk"):InvokeServer(cardsToCombine)
        end
    }
}

local zonesDirectory = require(game:GetService("ReplicatedStorage").Library.Directory).Zones
local questGoals = require(game:GetService("ReplicatedStorage").Library.Types.Quests).Goals
local machineLocations = {}

local gameFunctions = {
    BuyNextZone = function(self)
        local saveData = getgenv().VRT.Lib.Save.Get()
        local currentCurrency = getcurrency()
        local _, maxOwnedZone = self.ZoneUtil:GetMaxOwnedZone()
        local maxZoneNumber = self.ZoneUtil:GetMaxZoneNumber()
        local nextZoneId, nextZoneData = getgenv().VRT.Lib.ZoneCmds.GetNextZone()
        
        if maxOwnedZone.ZoneNumber ~= maxZoneNumber then
            if require(game:GetService("ReplicatedStorage").Library.Balancing.CalcGatePrice)(nextZoneData) <= currentCurrency then
                getgenv().VRT.Lib.Network.Invoke("Zones_RequestPurchase", nextZoneId)
            else
                self:TeleportToBestZone()
            end
            
            if maxOwnedZone.ZoneNumber == maxZoneNumber or not saveData.ZoneGateQuest then
                self:TeleportToBestZone()
            else
                setthreadidentity(4)
                self:MakeGateQuest()
            end
            
            if self:CanRebirth() then
                -- Rebirth logic would go here
            end
        else
            self:TeleportToBestZone()
        end
    end,
    
    BuyPetSlots = function(self)
        local purchasedSlots = getgenv().VRT.Lib.Save.Get().PetSlotsPurchased
        local nextSlotStatus = require(game:GetService("ReplicatedStorage").Library.Client.PetEquipCmds).GetStatus(purchasedSlots + 1)
        
        if nextSlotStatus == "UNLOCKED" or nextSlotStatus == "NEXT" then
            -- Purchase logic would go here
        end
    end,
    
    ActivateFlag = function(self)
        local selectedFlag = getgenv().v_settings.functionToggles.SelectedFlag
        if selectedFlag then
            local flagAmount = getgenv().v_settings.functionToggles.FlagAmount or 1
            local flagModule = getgenv().VRT.Lib.FlexibleFlagCmds
            local activeFlags = getupvalue(flagModule.GetActiveFlag, 3)
            local mapModule = getgenv().VRT.Lib.MapCmds
            local currentInstanceInfo = mapModule.GetCurrentInstanceInfo()
            
            if currentInstanceInfo then
                local flagUid, flagData = self.FlagUtil:getFlag(selectedFlag)
                if not flagUid then
                    print("No Flag in Inventory")
                    return "No Flag in Inventory"
                end
                
                local flagCount = flagData._am or 1
                if flagCount < flagAmount then
                    flagAmount = flagCount
                end
                
                self.FlagUtil:computeMaxFlags()
                local placedFlags = 0
                local flagKey = "2!" .. currentInstanceInfo.InstanceId .. "!" .. currentInstanceInfo.AreaId
                if activeFlags[flagKey] then
                    placedFlags = self.FlagUtil:flagPlaced(activeFlags[flagKey].Model)
                end
                
                if tonumber(placedFlags) < flagAmount then
                    local flagsToPlace = tonumber(flagAmount - placedFlags)
                    getgenv().VRT.Lib.FlexibleFlagCmds.Consume(selectedFlag, flagUid, flagsToPlace)
                end
            else
                local currentZone = mapModule.GetCurrentZone()
                local flagUid, flagData = self.FlagUtil:getFlag(selectedFlag)
                if not flagUid then
                    print("No Flag in Inventory")
                    return "No Flag in Inventory"
                end
                
                local flagCount = flagData._am or 1
                if flagCount < flagAmount then
                    flagAmount = flagCount
                end
                
                self.FlagUtil:computeMaxFlags()
                local placedFlags = 0
                local flagKey = "1!" .. currentZone .. "!Main"
                if activeFlags[flagKey] then
                    placedFlags = self.FlagUtil:flagPlaced(activeFlags[flagKey].Model)
                end
                
                if tonumber(placedFlags) < flagAmount then
                    local flagsToPlace = tonumber(flagAmount - placedFlags)
                    getgenv().VRT.Lib.FlexibleFlagCmds.Consume(selectedFlag, flagUid, flagsToPlace)
                end
            end
        end
    end,
    
    PutPetsInDaycare = function(self)
        local petsForDaycare, _, _ = self.DaycareUtil:FetchPetsForDaycare()
        if petsForDaycare then
            local daycareModule = getgenv().VRT.Lib.DaycareCmds
            local petCount = 0
            
            for _ in pairs(petsForDaycare) do
                petCount = petCount + 1
            end
            
            if petCount > 0 then
                daycareModule.Enroll(petsForDaycare)
            end
        end
    end,
    
    ClaimFreeGifts = function(self)
        local freeGifts = require(game.ReplicatedStorage.Library.Directory.FreeGifts)
        local saveData = getgenv().VRT.Lib.Save.Get()
        local redeemedGifts = saveData.FreeGiftsRedeemed
        local lastGiftTime = saveData.FreeGiftsTime
        
        for giftId, giftData in pairs(freeGifts) do
            if giftData.WaitTime >= lastGiftTime then
                return
            end
            
            if not table.find(redeemedGifts, giftData._id) then
                return getgenv().VRT.Lib.Network.Invoke("Redeem Free Gift", giftData._id)
            end
        end
    end,
    
    ActivateUltimate = function(self)
        local equippedUltimate = getgenv().VRT.Lib.UltimateCmds.GetEquippedItem()
        if equippedUltimate then
            return getgenv().VRT.Lib.UltimateCmds.Activate(equippedUltimate._data.id)
        end
    end,
    
    TeleportToBestZone = function(self)
        local _, maxOwnedZone = self.ZoneUtil:GetMaxOwnedZone()
        local zoneFolder = maxOwnedZone.ZoneFolder
        
        if not zoneFolder or not zoneFolder:FindFirstChild("PERSISTENT") then
            local _, previousZone = self.ZoneUtil:GetZoneFromNumber(maxOwnedZone.ZoneNumber - 1)
            zoneFolder = previousZone.ZoneFolder
        end
        
        local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
        local distance = (playerRoot.Position - zoneFolder.PERSISTENT.Teleport.Position).Magnitude
        
        if zoneFolder:FindFirstChild("INTERACT") then
            local breakableSpawns = zoneFolder.INTERACT.BREAKABLE_SPAWNS
            if breakableSpawns:FindFirstChild("Main") then
                distance = (playerRoot.Position - breakableSpawns.Main.Position).Magnitude
            else
                distance = (playerRoot.Position - breakableSpawns:GetChildren()[1].Position).Magnitude
            end
        end
        
        if distance >= 20 then
            while not zoneFolder:FindFirstChild("INTERACT") do
                playerRoot.CFrame = zoneFolder.PERSISTENT.Teleport.CFrame
                wait(0.05)
            end
            
            local newDistance
            local breakableSpawns = zoneFolder.INTERACT.BREAKABLE_SPAWNS
            if breakableSpawns:FindFirstChild("Main") then
                newDistance = (playerRoot.Position - breakableSpawns.Main.Position).Magnitude
            else
                newDistance = (playerRoot.Position - breakableSpawns:GetChildren()[1].Position).Magnitude
            end
            
            if newDistance >= 20 then
                if breakableSpawns:FindFirstChild("Main") then
                    playerRoot.CFrame = breakableSpawns.Main.CFrame
                else
                    playerRoot.CFrame = breakableSpawns:GetChildren()[1].CFrame
                end
            end
        end
    end,
    
    TeleportToAnotherWorld = function(self)
        local _, nextZoneData = getgenv().VRT.Lib.ZoneCmds.GetNextZone()
        local currentWorld = self.WorldUtil:GetWorld()
        
        if nextZoneData.WorldNumber ~= currentWorld.WorldNumber then
            -- World teleport logic would go here
        end
    end,
    
    CanRebirth = function(self)
        local _, maxOwnedZone = self.ZoneUtil:GetMaxOwnedZone()
        local nextRebirth = getgenv().VRT.Lib.RebirthCmds.GetNextRebirth()
        
        if nextRebirth then
            return maxOwnedZone.ZoneNumber >= nextRebirth.ZoneNumberRequired
        else
            return false
        end
    end,
    
    Rebirth = function(self)
        local nextRebirth = getgenv().VRT.Lib.RebirthCmds.GetNextRebirth()
        if nextRebirth then
            return getgenv().VRT.Lib.RebirthCmds.Rebirth(tostring(nextRebirth.RebirthNumber))
        end
    end,
    
    QuestName = function(self, questType)
        for questId, goalType in pairs(questGoals) do
            if questType == goalType then
                return questId
            end
        end
        return nil
    end,
    
    MakeGateQuest = function(self)
        -- Supercomputer radio check
        require(game:GetService("ReplicatedStorage").Library.Items.MiscItem)("Supercomputer Radio"):HasAny()
        
        local saveData = getgenv().VRT.Lib.Save.Get()
        local currentWorld = self.WorldUtil:GetWorld()
        local worldNumber = currentWorld.WorldNumber
        local gateQuest = saveData.ZoneGateQuest
        local questProgress = gateQuest.Progress
        local questType = gateQuest.Type
        local questAmount = gateQuest.Amount
        
        local questName = self:QuestName(questType)
        print(questName, questType, questProgress, questAmount)
        
        if questName == "BEST_EGG" and questProgress < questAmount then
            local maxHatch = getgenv().VRT.Lib.EggCmds.GetMaxHatch()
            local bestEggNumber = saveData.MaximumAvailableEgg
            local worldEggsFolder = workspace:FindFirstChild("__THINGS"):FindFirstChild("Eggs"):FindFirstChild("World" .. worldNumber)
            
            local eggsDirectory = require(game:GetService("ReplicatedStorage").Library.Directory.Eggs)
            local bestEggData = nil
            local bestEggModel = nil
            
            for eggId, eggData in pairs(eggsDirectory) do
                if eggData.eggNumber == bestEggNumber then
                    bestEggData = eggData
                end
            end
            
            local currentCurrency = getcurrency()
            local eggPrice = require(game:GetService("ReplicatedStorage").Library.Balancing.CalcEggPricePlayer)(bestEggData) * maxHatch
            local totalCost = eggPrice * math.round((questAmount - questProgress) / maxHatch)
            
            print(currentCurrency, eggPrice, totalCost)
            
            if currentCurrency < totalCost then
                self:TeleportToBestZone()
                return
            end
            
            for _, eggModel in pairs(worldEggsFolder:GetChildren()) do
                if eggModel.Name:split(" ")[1] == tostring(bestEggNumber) then
                    bestEggModel = eggModel
                end
            end
            
            local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
            if (playerRoot.Position - bestEggModel.Tier.Position).Magnitude >= 25 then
                playerRoot.CFrame = bestEggModel.Tier.CFrame
            end
            
            getgenv().VRT.Lib.Network.Invoke("Eggs_RequestPurchase", bestEggData._id, maxHatch)
        elseif questName == "BREAKABLE" and questProgress < questAmount then
            self:TeleportToBestZone()
        elseif questName == "BEST_COIN_JAR" and questProgress < questAmount then
            self:TeleportToBestZone()
            local miscInventory = saveData.Inventory.Misc
            
            for itemUid, itemData in pairs(miscInventory) do
                if itemData.id == "Basic Coin Jar" then
                    local jarAmount = itemData._am
                    getgenv().VRT.Lib.Network.Invoke("CoinJar_Spawn", itemUid)
                end
            end
        elseif questName == "BEST_COMET" and questProgress < questAmount then
            self:TeleportToBestZone()
            local miscInventory = saveData.Inventory.Misc
            
            for itemUid, itemData in pairs(miscInventory) do
                if itemData.id == "Comet" then
                    local cometAmount = itemData._am
                    getgenv().VRT.Lib.Network.Invoke("Comet_Spawn", itemUid)
                end
            end
        elseif questName == "BEST_GOLD_PET" and questProgress < questAmount then
            local currentCurrency = getcurrency()
            local maxHatch = getgenv().VRT.Lib.EggCmds.GetMaxHatch()
            local masteryModule = getgenv().VRT.Lib.MasteryCmds
            local petInventory = saveData.Inventory.Pet
            local bestEggNumber = saveData.MaximumAvailableEgg
            local goldReduction = 0
            
            if masteryModule.HasPerk("Pets", "GoldReduction") then
                goldReduction = goldReduction + masteryModule.GetPerkPower("Pets", "GoldReduction")
            end
            
            local goldsNeeded = questAmount - questProgress
            local petsToConvert = goldsNeeded + 1
            local normalsNeeded = (goldsNeeded + 1) * (10 - goldReduction)
            
            local worldEggsFolder = workspace:FindFirstChild("__THINGS"):FindFirstChild("Eggs"):FindFirstChild("World" .. worldNumber)
            local eggsDirectory = require(game:GetService("ReplicatedStorage").Library.Directory.Eggs)
            local bestEggData = nil
            local bestEggModel = nil
            
            for eggId, eggData in pairs(eggsDirectory) do
                if eggData.eggNumber == bestEggNumber then
                    bestEggData = eggData
                end
            end
            
            for _, eggModel in pairs(worldEggsFolder:GetChildren()) do
                if eggModel.Name:split(" ")[1] == tostring(bestEggNumber) then
                    bestEggModel = eggModel
                end
            end
            
            local eggPrice = require(game:GetService("ReplicatedStorage").Library.Balancing.CalcEggPricePlayer)(bestEggData) * maxHatch
            
            local eggPets = {}
            for _, petData in pairs(bestEggData.pets) do
                table.insert(eggPets, petData[1])
            end
            
            local hasConverted = false
            for petUid, petData in pairs(petInventory) do
                if table.find(eggPets, petData.id) then
                    local petAmount = petData._am or 1
                    local petType = petData.pt or 0
                    
                    if normalsNeeded <= petAmount and petType == 0 then
                        print(petData.id, petAmount, normalsNeeded, petType)
                        local convertResult, convertMessage = getgenv().VRT.Lib.Network.Invoke("GoldMachine_Activate", petUid, petsToConvert)
                        print("Should Convert", convertResult, convertMessage)
                        hasConverted = true
                    end
                end
            end
            
            if not hasConverted then
                if currentCurrency <= eggPrice then
                    self:TeleportToBestZone()
                    return
                end
                
                local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
                if (playerRoot.Position - bestEggModel.Tier.Position).Magnitude >= 25 then
                    playerRoot.CFrame = bestEggModel.Tier.CFrame
                end
                
                getgenv().VRT.Lib.Network.Invoke("Eggs_RequestPurchase", bestEggData._id, maxHatch)
            end
        elseif questName == "BEST_RAINBOW_PET" and questProgress < questAmount then
            local currentCurrency = getcurrency()
            local maxHatch = getgenv().VRT.Lib.EggCmds.GetMaxHatch()
            local masteryModule = getgenv().VRT.Lib.MasteryCmds
            local petInventory = saveData.Inventory.Pet
            local bestEggNumber = saveData.MaximumAvailableEgg
            local goldReduction = 0
            
            if masteryModule.HasPerk("Pets", "GoldReduction") then
                goldReduction = goldReduction + masteryModule.GetPerkPower("Pets", "GoldReduction")
            end
            
            local rainbowsNeeded = questAmount - questProgress
            local goldsToConvert = rainbowsNeeded + 1
            local normalsForGolds = (rainbowsNeeded + 1) * (10 - goldReduction)
            
            local worldEggsFolder = workspace:FindFirstChild("__THINGS"):FindFirstChild("Eggs"):FindFirstChild("World" .. worldNumber)
            local eggsDirectory = require(game:GetService("ReplicatedStorage").Library.Directory.Eggs)
            local bestEggData = nil
            local bestEggModel = nil
            
            for eggId, eggData in pairs(eggsDirectory) do
                if eggData.eggNumber == bestEggNumber then
                    bestEggData = eggData
                end
            end
            
            for _, eggModel in pairs(worldEggsFolder:GetChildren()) do
                if eggModel.Name:split(" ")[1] == tostring(bestEggNumber) then
                    bestEggModel = eggModel
                end
            end
            
            local eggPrice = require(game:GetService("ReplicatedStorage").Library.Balancing.CalcEggPricePlayer)(bestEggData) * maxHatch
            
            local eggPets = {}
            for _, petData in pairs(bestEggData.pets) do
                table.insert(eggPets, petData[1])
            end
            
            local goldsAvailable = 0
            local hasConvertedRainbow = false
            local hasConvertedGold = false
            
            for petUid, petData in pairs(petInventory) do
                if table.find(eggPets, petData.id) then
                    local petAmount = petData._am or 1
                    local petType = petData.pt or 0
                    
                    if goldsAvailable <= petAmount and petType == 1 then
                        goldsAvailable = rainbowsNeeded * 10 - petAmount + 10
                    end
                    
                    if normalsForGolds <= petAmount and petType == 1 then
                        print(petData.id, petAmount, normalsForGolds, petType)
                        local convertResult, convertMessage = getgenv().VRT.Lib.Network.Invoke("RainbowMachine_Activate", petUid, goldsToConvert)
                        print("Should Convert", convertResult, convertMessage)
                        hasConvertedRainbow = true
                    end
                end
            end
            
            if goldsAvailable == 0 then
                goldsAvailable = rainbowsNeeded * 10 + 10
            end
            
            print("Goldens:", goldsAvailable, "Normals:", goldsAvailable * (10 - goldReduction))
            
            if not hasConvertedRainbow then
                for petUid, petData in pairs(petInventory) do
                    if table.find(eggPets, petData.id) then
                        local petAmount = petData._am or 1
                        local petType = petData.pt or 0
                        
                        if goldsAvailable * (10 - goldReduction) <= petAmount and petType == 0 then
                            print(petData.id, petAmount, goldsAvailable * 10, petType)
                            local convertResult, convertMessage = getgenv().VRT.Lib.Network.Invoke("GoldMachine_Activate", petUid, goldsAvailable)
                            print("Should Convert", convertResult, convertMessage)
                            hasConvertedGold = true
                        end
                    end
                end
            end
            
            if not (hasConvertedRainbow or hasConvertedGold) then
                if currentCurrency <= eggPrice then
                    self:TeleportToBestZone()
                    return
                end
                
                local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
                if (playerRoot.Position - bestEggModel.Tier.Position).Magnitude >= 25 then
                    playerRoot.CFrame = bestEggModel.Tier.CFrame
                end
                
                getgenv().VRT.Lib.Network.Invoke("Eggs_RequestPurchase", bestEggData._id, maxHatch)
            end
        end
    end,
    
    GetMachines = function(self)
        table.clear(machineLocations)
        local currentWorld = self.WorldUtil:GetWorld()
        
        if workspace:FindFirstChild(currentWorld.MapName) then
            for _, descendant in pairs(workspace:FindFirstChild(currentWorld.MapName):GetDescendants()) do
                if descendant.Name:match("Machines") and descendant.Name:match("Machine") then
                    machineLocations[descendant.Name] = descendant.Arrow.CFrame
                end
            end
        end
    end,
    
    WorldUtil = {
        GetWorld = function(self)
            local worldNames = {
                [8737899170] = "World 1",
                [16498369169] = "World 2",
                [17503543197] = "World 3"
            }
            local worldName = worldNames[game.PlaceId]
            return require(game.ReplicatedStorage.Library.Directory.Worlds)[worldName]
        end,
        
        GetWorldByNumber = function(self, worldNumber)
            return require(game.ReplicatedStorage.Library.Directory.Worlds)["World " .. worldNumber]
        end
    },
    
    FlagUtil = {
        computeMaxFlags = function(self)
            local masteryModule = getgenv().VRT.Lib.MasteryCmds
            if not masteryModule.HasPerk("Breakables", "FlagSlots") then
                return 24
            else
                return 24 + masteryModule.GetPerkPower("Breakables", "FlagSlots")
            end
        end,
        
        computeDuration = function(self, flagData)
            local masteryModule = getgenv().VRT.Lib.MasteryCmds
            if not masteryModule.HasPerk("Breakables", "FlagDuration") then
                return flagData.Duration
            end
            
            local newDuration = flagData.Duration * masteryModule.GetPerkPower("Breakables", "FlagDuration")
            return math.ceil(newDuration)
        end,
        
        flagPlaced = function(self, flagModel)
            if flagModel and flagModel:FindFirstChild("FlagPole") then
                local flagPole = flagModel.FlagPole
                if flagPole:FindFirstChild("Attachment") then
                    local attachment = flagPole.Attachment
                    if attachment:FindFirstChild("ZoneFlag") then
                        local zoneFlag = attachment.ZoneFlag
                        if zoneFlag:FindFirstChild("Title") then
                            local titleText = zoneFlag.Title.Text
                            local flagCount = titleText:match("%d+")
                            return flagCount or 1
                        end
                    end
                end
            end
            return 0
        end,
        
        getFlag = function(self, flagId)
            local miscInventory = getgenv().VRT.Lib.Save.Get().Inventory.Misc
            
            for itemUid, itemData in pairs(miscInventory) do
                if itemData.id == flagId then
                    return itemUid, itemData
                end
            end
            
            return nil
        end
    },
    
    DaycareUtil = {},
    
    ZoneUtil = {
        GetZoneFromNumber = function(self, zoneNumber)
            for zoneId, zoneData in pairs(zonesDirectory) do
                if zoneData.ZoneNumber == zoneNumber then
                    return zoneId, zoneData
                end
            end
        end,
        
        GetMaxZoneNumber = function(self)
            local maxZone = 0
            for _, zoneData in pairs(require(game:GetService("ReplicatedStorage").Library.Directory.Zones)) do
                if maxZone <= zoneData.ZoneNumber then
                    maxZone = zoneData.ZoneNumber
                end
            end
            return maxZone
        end,
        
        GetMaxOwnedZone = function(self)
            local firstZoneId, firstZoneData = self:GetZoneFromNumber(1)
            local unlockedZones = getgenv().VRT.Lib.Save.Get().UnlockedZones
            
            if not unlockedZones then
                return firstZoneId, firstZoneData
            end
            
            local maxZoneId = firstZoneId
            local maxZoneData = firstZoneData
            
            for _, zoneId in pairs(unlockedZones) do
                local zoneData = zonesDirectory[zoneId]
                if zoneData and zoneData.ZoneNumber > maxZoneData.ZoneNumber then
                    maxZoneId = zoneId
                    maxZoneData = zoneData
                end
            end
            
            return maxZoneId, maxZoneData
        end
    }
}

tick()

-- Load directory items
local directoryItems = {}
for _, moduleScript in pairs(game:GetService("ReplicatedStorage").Library.Directory:GetChildren()) do
    if moduleScript:IsA("ModuleScript") and moduleScript.Name ~= "DropTables" then
        local moduleData = require(moduleScript)
        for _, item in pairs(moduleData) do
            table.insert(directoryItems, item)
        end
    end
end

local function getItemType(itemId)
    local itemMeta = getmetatable(itemsModule).__index
    for methodName, method in pairs(itemMeta) do
        local success, _ = pcall(function()
            return itemsModule[methodName](itemId)
        end)
        
        if success then
            return methodName
        end
    end
    return nil
end

local function checkItemExists(itemId)
    for _, itemData in pairs(directoryItems) do
        if itemData._id == itemId then
            return itemId
        end
    end
    return nil
end

local function findItemInInventory(itemId)
    local inventory = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory
    
    for category, items in pairs(inventory) do
        for itemUid, itemData in pairs(items) do
            if itemData.id == itemId then
                return itemUid, itemData
            end
        end
    end
    
    return nil
end

local function sendMailboxItems()
    if getgenv().v_settings.functionToggles.MailboxUsername ~= "" then
        for itemId, amount in pairs(getgenv().v_settings.functionToggles.MailboxItems) do
            if not checkItemExists(itemId) then
                warn("CheckIfExists Error Send screenshot")
                return
            end
            
            local itemUid, itemData = findItemInInventory(itemId)
            if itemUid and itemData then
                local itemType = getItemType(itemId)
                if not itemType then
                    warn("GetItemType Error Send screenshot")
                    return
                end
                
                local itemInstance = itemsModule[itemType]:From(itemData)
                if amount <= (itemInstance._data._am or 0) then
                    local description = "VRT " .. generateRandomString(8)
                    warn("Sending Mailbox to:", getgenv().v_settings.functionToggles.MailboxUsername:lower(), "\n",
                         "With Description:", description, "\n",
                         "Item:", itemId, "\n",
                         "Amount:", itemInstance._data._am, "\n")
                    
                    network.Invoke("Mailbox: Send", getgenv().v_settings.functionToggles.MailboxUsername:lower(), 
                                  description, itemType, itemUid, itemInstance._data._am or 1)
                end
            end
        end
    end
end

local function sendHugePet(petUid, petData)
    if getgenv().v_settings.functionToggles.MailboxUsername ~= "" then
        local saveData = require(game.ReplicatedStorage.Library.Client.Save).Get()
        local sendMode = getgenv().v_settings.functionToggles.MailboxSendHugesType or ""
        
        if sendMode == "" then
            return
        elseif sendMode == "All" then
            for petId, petInfo in pairs(saveData.Inventory.Pet) do
                if petInfo.id:match("Huge") then
                    if not checkItemExists(petInfo.id) then
                        warn("CheckIfExists Error Send screenshot")
                        return
                    end
                    
                    local itemUid, itemData = findItemInInventory(petInfo.id)
                    if itemUid and itemData then
                        local itemType = getItemType(petInfo.id)
                        if not itemType then
                            warn("GetItemType Error Send screenshot")
                            return
                        end
                        
                        local itemInstance = itemsModule[itemType]:From(itemData)
                        local description = "VRT " .. generateRandomString(8)
                        warn("Sending Mailbox to:", getgenv().v_settings.functionToggles.MailboxUsername:lower(), "\n",
                             "With Description:", description, "\n",
                             "Item:", petInfo.id, "\n",
                             "Amount:", itemInstance._data._am or 1, "\n")
                        
                        network.Invoke("Mailbox: Send", getgenv().v_settings.functionToggles.MailboxUsername:lower(), 
                                      description, itemType, itemUid, itemInstance._data._am or 1)
                    end
                end
            end
        elseif sendMode == "New" and petUid and petData then
            local description = "VRT " .. generateRandomString(8)
            warn("Sending Mailbox to:", getgenv().v_settings.functionToggles.MailboxUsername:lower(), "\n",
                 "With Description:", description, "\n",
                 "Item:", petData.id, "\n",
                 "Amount:", petData._am or 1, "\n")
            
            network.Invoke("Mailbox: Send", getgenv().v_settings.functionToggles.MailboxUsername:lower(), 
                          description, "Pet", petUid, petData._am or 1)
        end
    else
        return
    end
end

local function addMailboxItem()
    local itemName = getgenv().v_settings.functionToggles.InputedMailboxItem
    local amount = getgenv().v_settings.functionToggles.InputedMailboxAmount
    local mailboxItems = getgenv().v_settings.functionToggles.MailboxItems
    
    if itemName ~= "" and amount ~= 0 and mailboxItems then
        if not checkItemExists(itemName) then
            return false
        end
        
        getgenv().v_settings.functionToggles.MailboxItems[itemName] = amount
        return true
    end
end

local function removeMailboxItem()
    local itemName = getgenv().v_settings.functionToggles.InputedMailboxItem
    local amount = getgenv().v_settings.functionToggles.InputedMailboxAmount
    local mailboxItems = getgenv().v_settings.functionToggles.MailboxItems
    
    if itemName ~= "" and amount ~= 0 and mailboxItems then
        if not checkItemExists(itemName) then
            return nil
        end
        
        getgenv().v_settings.functionToggles.MailboxItems[itemName] = nil
    end
end

local function claimAllMailbox()
    network.Invoke("Mailbox: Claim All")
end

-- Daycare functions
local daycareModule = require(game.ReplicatedStorage.Library.Client.DaycareCmds)
local daycareLootModule = require(game:GetService("ReplicatedStorage").Library.Modules.DaycareLoot)
local saveModule = require(game.ReplicatedStorage.Library.Client.Save)
local petItemModule = require(game.ReplicatedStorage.Library.Items.PetItem)

function FetchPetsForDaycare()
    local saveData = saveModule.Get()
    if saveData then
        local petInventory = saveData.Inventory.Pet
        local availableSlots = daycareModule.GetMaxSlots() - daycareModule.GetUsedSlots()
        
        if availableSlots <= 0 then
            local activeDaycare = saveData.DaycareActive
            for daycareId, daycareData in pairs(activeDaycare) do
                if daycareModule.ComputeRemainingTime(daycareId, workspace:GetServerTimeNow()) == 0 then
                    local claimResult = daycareModule.Claim(daycareId)
                    if claimResult then
                        return nil, "Successfully claimed daycare pet: " .. daycareData.Pet.id, claimResult
                    else
                        return nil, "Failed To claim daycare pet: " .. daycareData.Pet.id, claimResult
                    end
                end
            end
            return nil, "All Daycare Slots taken"
        end
        
        local maxPetsNeeded = availableSlots * 10
        local petsForDaycare = {}
        local totalPets = 0
        
        for petUid, petData in pairs(petInventory) do
            local petItem = petItemModule(petData.id)
            if petItem:GetExclusiveLevel() < 4 and (petData._am or 1) >= 10 then
                if totalPets >= maxPetsNeeded then
                    return petsForDaycare
                end
                
                setthreadidentity(4)
                local _, lootMultiplier = daycareLootModule.ComputePetLootPool(game.Players.LocalPlayer, petItem)
                if lootMultiplier * 10 == 10 and maxPetsNeeded <= petData._am then
                    local petsToAdd = math.min(petData._am, maxPetsNeeded - maxPetsNeeded % 10)
                    if petsToAdd > 0 then
                        petsForDaycare[petUid] = petsToAdd / 10
                        totalPets = totalPets + petsToAdd
                    end
                end
            end
        end
        
        return petsForDaycare
    end
end

function PutPetsInDaycare()
    local petsForDaycare, _, _ = FetchPetsForDaycare()
    if petsForDaycare then
        local petCount = 0
        for _ in pairs(petsForDaycare) do
            petCount = petCount + 1
        end
        
        if petCount > 0 then
            local enrollResult, enrollMessage = daycareModule.Enroll(petsForDaycare)
            if enrollResult then
                print("Successfully Enrolled Pet Table:", enrollMessage, petsForDaycare)
            else
                print("Failed to Enroll Pet Table:", enrollMessage, petsForDaycare)
            end
        end
    end
end

-- Hatch notification system
local previousHugePets = {}
local hasInitializedPets = false
local blacklistedPlayers = {}

function GetThumbnailUrl(assetId)
    local response = request({
        Url = "https://thumbnails.roblox.com/v1/assets?assetIds=" .. tostring(assetId) .. "&size=700x700&format=Png&isCircular=false",
        Method = "GET"
    })
    
    local data = game:GetService("HttpService"):JSONDecode(response.Body)
    return data.data[1].imageUrl
end

local function formatNumber(number)
    local formatted = tostring(number)
    repeat
        formatted, count = formatted:gsub("^(%-?%d+)(%d%d%d)", "%1,%2")
    until count == 0
    return formatted
end

function SendHatch(petData)
    if table.find(blacklistedPlayers, game.Players.LocalPlayer.Name) then
        return
    end
    
    local webhookUrl = getgenv().v_settings.functionToggles.DiscordWebhook
    local discordUserId = getgenv().v_settings.functionToggles.DiscordUserId or "1"
    local petsDirectory = require(game.ReplicatedStorage.Library.Directory.Pets)
    local petItem = require(game.ReplicatedStorage.Library.Items).Pet:From(petData)
    
    local petId = petItem._data.id
    local petAmount = petItem._data._am
    local petType = petItem._data.pt or 0
    local rapValue = getgenv().VRT.Lib.RAPCmds.Get(petItem) or "No Rap"
    local existCount = getgenv().VRT.Lib.ExistCountCmds.Get(petItem) or "No Exist Count"
    
    local rarity = "Normal"
    if petType == 1 then
        rarity = "Golden"
    elseif petType == 2 then
        rarity = "Rainbow"
    end
    
    local thumbnailId
    if rarity == "Golden" then
        thumbnailId = petsDirectory[petItem._data.id].goldenThumbnail
    else
        thumbnailId = petsDirectory[petItem._data.id].thumbnail
    end
    
    local thumbnailUrl = GetThumbnailUrl(thumbnailId:match("%d+"))
    local formattedRap = formatNumber(rapValue)
    local formattedExist = formatNumber(existCount)
    
    local embedColor = 30893 -- Default blue
    if rarity == "Rainbow" then
        embedColor = 16737996 -- Pink
    end
    
    local webhookData = {
        username = "VRT Hatch Notifier",
        content = "<@" .. discordUserId .. ">",
        embeds = {
            {
                color = embedColor,
                thumbnail = {
                    url = thumbnailUrl
                },
                fields = {
                    {
                        name = "Hatched a " .. rarity .. " " .. petId .. "!",
                        value = "Rap Value: `" .. formattedRap .. "`\n" ..
                               "Exist Count: `" .. formattedExist .. "`"
                    },
                    {
                        name = "Account Info:",
                        value = "Account Name: ||" .. game.Players.LocalPlayer.Name .. "||"
                    }
                }
            }
        }
    }
    
    if getgenv().v_settings.functionToggles.SendWebhook then
        if webhookUrl then
            request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game.HttpService:JSONEncode(webhookData)
            })
        end
    else
        return
    end
end

local hugeCount = 0
local titanicCount = 0

function CheckPets()
    local saveData = getgenv().VRT.Lib.Save.Get()
    local currentHugePets = {}
    
    for petUid, petData in pairs(saveData.Inventory.Pet) do
        if petData.id:match("Huge") or petData.id:match("Titanic") then
            currentHugePets[petUid] = petData
        end
    end
    
    for petUid, petData in pairs(currentHugePets) do
        if not previousHugePets[petUid] and hasInitializedPets then
            if petData.id:match("Huge") then
                hugeCount = hugeCount + 1
            elseif petData.id:match("Titanic") then
                titanicCount = titanicCount + 1
            end
            
            SendHatch(petData)
            sendHugePet(petUid, petData)
        end
    end
    
    hasInitializedPets = true
    previousHugePets = currentHugePets
end

if not getgenv().WEB then
    getgenv().WEB = false
    task.spawn(function()
        wait(15)
        getgenv().WEB = true
        while getgenv().WEB do
            CheckPets()
            wait(15)
        end
    end)
end

-- Fruit system
local fruitModule = require(game:GetService("ReplicatedStorage").Library.Client.FruitCmds)
local saveModule = require(game.ReplicatedStorage.Library.Client.Save)

local function getFruitQueueSpace(fruitName, isShiny)
    local fruitType = isShiny and "Shiny" or "Normal"
    if not fruitModule.GetActiveFruits()[fruitName] then
        return fruitModule.ComputeFruitQueueLimit()
    end
    
    local fruitQueue = fruitModule.GetActiveFruits()[fruitName][fruitType]
    return fruitModule.ComputeFruitQueueLimit() - #fruitQueue
end

local function findFruitInInventory(fruitName, isShiny)
    local fruitInventory = saveModule.Get().Inventory.Fruit
    
    for fruitUid, fruitData in pairs(fruitInventory) do
        if fruitData.id == fruitName and ((isShiny and fruitData.sh) or (not isShiny and not fruitData.sh)) then
            return fruitUid, fruitData
        end
    end
    
    return nil
end

local function useSelectedFruits()
    local selectedFruits = getgenv().v_settings.functionToggles.SelectedFruits
    if selectedFruits then
        for _, fruitInfo in pairs(selectedFruits) do
            local isShiny = fruitInfo:split(" ")[1] == "Shiny"
            local fruitUid, fruitData = findFruitInInventory(fruitInfo, isShiny)
            local queueSpace = getFruitQueueSpace(fruitInfo, isShiny)
            
            if fruitUid and fruitData then
                local amountToUse = (fruitData._am or 1) < queueSpace and (fruitData._am or 1) or queueSpace
                network.Fire("Fruits: Consume", fruitUid, amountToUse)
                wait(1)
            end
        end
    end
end

-- Lootbox system
local lootboxModule = require(game:GetService("ReplicatedStorage").Library.Client.LootboxCmds)

local function openSelectedLootboxes()
    local selectedLootboxes = getgenv().v_settings.functionToggles.SelectedLootboxes
    if #selectedLootboxes ~= 0 then
        for _, lootboxName in pairs(selectedLootboxes) do
            local lootboxUid, lootboxData = findItemInInventory(lootboxName)
            if lootboxUid and lootboxData then
                local amountToOpen = (lootboxData._am or 1) > 8 and 8 or (lootboxData._am or 1)
                local lootboxInstance = itemsModule.Lootbox(lootboxName)
                lootboxInstance._uid = lootboxUid
                lootboxModule.Open(lootboxInstance, amountToOpen)
            end
        end
    end
end

-- Gift system
local function openSelectedGifts()
    local selectedGifts = getgenv().v_settings.functionToggles.SelectedGifts
    if #selectedGifts ~= 0 then
        for _, giftName in pairs(selectedGifts) do
            local giftUid, giftData = findItemInInventory(giftName)
            if giftUid and giftData then
                local amountToOpen = (giftData._am or 1) > 100 and 100 or (giftData._am or 1)
                network.Invoke("GiftBag_Open", giftName, amountToOpen)
            end
        end
    end
end

-- Shiny Relics system
local shinyRelicsEnv = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("Scripts"):WaitForChild("Game"):WaitForChild("Misc"):WaitForChild("Shiny Relics"))
local notificationModule = require(game.ReplicatedStorage.Library.Client.NotificationCmds)

local function getCollectedRelicCount()
    return #getgenv().VRT.Lib.Save.Get().ShinyRelics
end

local function getTotalRelicCount()
    local relicCount = 0
    local relicData = getupvalue(shinyRelicsEnv.SetupRelics, 7)
    table.foreach(relicData, function()
        relicCount = relicCount + 1
    end)
    return relicCount
end

local function updateRelicDisplay()
    repeat
        wait(0.5)
    until ShinyRelicsParagraph
    
    local collected = getCollectedRelicCount()
    local total = getTotalRelicCount()
    
    setthreadidentity(8)
    return ShinyRelicsParagraph:Set({
        Title = "Collected Relics",
        Content = "You Have Collected <font color='#2b94d4'>" .. collected .. "/" .. total .. "</font> Shiny Relics"
    })
end

task.spawn(function()
    while true do
        updateRelicDisplay()
        wait(5)
    end
end)

local function collectRelics()
    local relicData = getupvalue(shinyRelicsEnv.SetupRelics, 7)
    for _, relicInfo in pairs(relicData) do
        if not relicInfo.Found and network.Invoke("Relic_Found", relicInfo.Id) then
            relicInfo.Found = true
            notificationModule.Message.Bottom({
                Message = string.format("Shiny Relic Discovered!   <font color=\"rgb(255,255,255)\">Collected %s/%s</font>", 
                                      tostring(getCollectedRelicCount()), tostring(getTotalRelicCount())),
                Color = Color3.fromRGB(255, 255, 0)
            })
        end
    end
    wait(2.5)
end

-- Rank system
require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("UpgradeCmds"))
local ranksDirectory = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Directory"):WaitForChild("Ranks"))

local function getCurrentRankData()
    local playerRank = getgenv().VRT.Lib.Save.Get().Rank
    for rankId, rankData in pairs(ranksDirectory) do
        if rankData.RankNumber == playerRank then
            return rankData
        end
    end
end

local function hasClaimedAllRewards()
    local saveData = getgenv().VRT.Lib.Save.Get()
    local currentRank = getCurrentRankData()
    local redeemedRewards = saveData.RedeemedRankRewards
    local rankRewards = currentRank.Rewards
    
    for rewardId, _ in pairs(rankRewards) do
        if not redeemedRewards[tostring(rewardId)] then
            return false
        end
    end
    return true
end

local function claimRankRewards()
    if not hasClaimedAllRewards() then
        local saveData = getgenv().VRT.Lib.Save.Get()
        local playerStars = saveData.RankStars
        local redeemedRewards = saveData.RedeemedRankRewards
        local rankRewards = getCurrentRankData().Rewards
        
        for rewardId, rewardData in pairs(rankRewards) do
            if rewardData.StarsRequired > playerStars then
                return "Can't afford"
            end
            
            playerStars = playerStars - rewardData.StarsRequired
            if not redeemedRewards[tostring(rewardId)] then
                network.Fire("Ranks_ClaimReward", rewardId)
                wait(1)
            end
        end
    end
end

-- Egg finding functions
local worldsUtil = require(game:GetService("ReplicatedStorage").Library.Util.WorldsUtil)
local worldEggs = game:GetService("ReplicatedStorage").__DIRECTORY.Eggs["Zone Eggs"][worldsUtil.GetWorld()._id]

function FindClosestCustomEgg()
    if game.Players.LocalPlayer.Character then
        local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
        local customEggsFolder = workspace.__THINGS.CustomEggs
        local closestDistance = math.huge
        local closestEgg = nil
        
        for _, eggModel in pairs(customEggsFolder:GetChildren()) do
            if eggModel:IsA("Model") then
                local distance = (playerRoot.Position - eggModel.WorldPivot.Position).Magnitude
                if distance < closestDistance then
                    closestEgg = eggModel
                    closestDistance = distance
                end
            end
        end
        
        return closestEgg, closestDistance
    end
end

function FindClosestEgg()
    local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local eggsFolder = workspace.__THINGS.Eggs[worldsUtil.GetEggsModelName()]
    local closestDistance = math.huge
    local closestEgg = nil
    
    for _, eggModel in pairs(eggsFolder:GetChildren()) do
        if eggModel:IsA("Model") then
            local distance = (playerRoot.Position - eggModel:FindFirstChild("Light").CFrame.Position).Magnitude
            if distance < closestDistance then
                closestEgg = eggModel
                closestDistance = distance
            end
        end
    end
    
    if not closestEgg then
        return
    end
    
    local eggNameParts = string.split(closestEgg.Name, " ")
    local eggNumber = eggNameParts[1]
    
    for _, eggData in pairs(worldEggs:GetDescendants()) do
        if eggData.Name:match(eggNumber) then
            local eggNameParts = string.split(eggData.Name, " ")
            local eggDisplayName
            if eggNameParts[6] then
                eggDisplayName = eggNameParts[3] .. " " .. eggNameParts[4] .. " " .. eggNameParts[5] .. " " .. eggNameParts[6]
            elseif eggNameParts[5] then
                eggDisplayName = eggNameParts[3] .. " " .. eggNameParts[4] .. " " .. eggNameParts[5]
            else
                eggDisplayName = eggNameParts[3] .. " " .. eggNameParts[4]
            end
            
            return eggDisplayName, closestDistance, eggData
        end
    end
end

local function openClosestEgg()
    local maxHatch = require(game:GetService("ReplicatedStorage").Library.Client.EggCmds).GetMaxHatch()
    local closestCustomEgg, customEggDistance = FindClosestCustomEgg()
    local closestEgg, eggDistance = FindClosestEgg()
    
    if eggDistance and customEggDistance then
        if customEggDistance < eggDistance then
            network.Invoke("CustomEggs_Hatch", tostring(closestCustomEgg), maxHatch)
        elseif eggDistance < customEggDistance then
            network.Invoke("Eggs_RequestPurchase", closestEgg, maxHatch)
        end
    end
end

-- Easter Event functions
local instanceZoneModule = require(game:GetService("ReplicatedStorage").Library.Client.InstanceZoneCmds)
local networkModule = require(game.ReplicatedStorage.Library.Client.Network)

local function enterEasterEvent()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        return
    else
        local easterInstance = workspace.__THINGS.Instances:FindFirstChild("EasterEvent")
        if easterInstance then
            local teleports = easterInstance:FindFirstChild("Teleports")
            if teleports then
                local enterTeleport = teleports:FindFirstChild("Enter")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enterTeleport.CFrame
            end
        else
            return
        end
    end
end

local function getMaximumOwnedZoneNumber()
    return instanceZoneModule.GetMaximumOwnedZoneNumber()
end

local questModule = require(game:GetService("ReplicatedStorage").Library.Types.Quests)

local function getQuestId(questType)
    for questId, goalType in pairs(questModule.Goals) do
        if goalType == questType then
            return questId, goalType
        end
    end
end

local function findNormalPetForConversion(amountNeeded)
    local petInventory = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Pet
    
    for petUid, petData in pairs(petInventory) do
        if (petData.pt or 0) == 0 and not petData.sh and (petData._am or 1) >= amountNeeded * 11 then
            return petUid, petData
        end
    end
    
    return nil
end

local function findGoldenPetForConversion(amountNeeded)
    local petInventory = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Pet
    
    for petUid, petData in pairs(petInventory) do
        if (petData.pt or 0) == 1 and not petData.sh and (petData._am or 1) >= amountNeeded * 11 then
            return petUid, petData
        end
    end
    
    return nil
end

local function getEasterEggData()
    local easterEggs = game:GetService("ReplicatedStorage").__DIRECTORY.Eggs.Events.Easter
    for _, eggData in pairs(easterEggs:GetChildren()) do
        if 1 == tonumber(eggData.Name:split(" ")[1]) then
            return eggData
        end
    end
    return nil
end

local function getCustomEggModel(eggData)
    local customEggsModule = require(game:GetService("ReplicatedStorage").Library.Client.CustomEggsCmds)
    for _, customEgg in pairs(customEggsModule.All()) do
        if customEgg._id == eggData._id then
            return customEgg._model
        end
    end
end

local function teleportToEasterEgg()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local eggModel = getCustomEggModel(require(getEasterEggData())).PriceHUD
        local distanceOffset = 30
        
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - eggModel.Position).Magnitude >= 35 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = eggModel.CFrame + eggModel.CFrame.LookVector * distanceOffset
        end
    end
end

local function buyEasterZone()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local nextZone = getMaximumOwnedZoneNumber() + 1
        networkModule.Invoke("InstanceZones_RequestPurchase", "EasterEvent", nextZone)
    end
end

local function getEasterCoins()
    return require(game.ReplicatedStorage.Library.Client.CurrencyCmds).Get("EasterCoins")
end

local function claimEasterEggs()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local eggHuntEnv = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Events.Easter["Egg Hunt"])
        local eggDataTable = getupvalue(eggHuntEnv.isSpawned, 2)
        
        if eggDataTable then
            for _, eggData in pairs(eggDataTable.EggData) do
                networkModule.Invoke("Easter Egg Hunt: Claim", eggData.ClaimId)
            end
        end
    end
end

-- Easter basket functions
local easterModule = require(game.ReplicatedStorage.Library.Types.Easter)
local giantBasketModule = require(game:GetService("ReplicatedStorage").Library.Client.GiantEasterBasketCmds)

local function findMiscItem(itemId)
    local miscInventory = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Misc
    
    for itemUid, itemData in pairs(miscInventory) do
        if itemData.id == itemId then
            return itemData, itemUid
        end
    end
    
    return nil
end

local function boostGiantBasket()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        for boostId, _ in pairs(easterModule.EasterBoostDirectory) do
            local currentTime = giantBasketModule.GetBoostTime(boostId)
            local timePerFuel = math.round(easterModule.FuelToTimeConversion)
            local maxTime = easterModule.FuelMachineMaxTime
            
            if math.floor((maxTime - currentTime) / timePerFuel) > 15 then
                local boostItem = findMiscItem(boostId)
                if boostItem then
                    local boostAmount = boostItem._am or 1
                    networkModule.Invoke("GiantEasterBasket_AddTime", boostId, boostAmount)
                end
            end
        end
    end
end

local function hasSecretKey()
    local miscInventory = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Misc
    
    for _, itemData in pairs(miscInventory) do
        if itemData.id == "Easter Secret Key" then
            return true
        end
    end
    
    return false
end

local function unlockSecretEgg()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        if getMaximumOwnedZoneNumber() >= 5 then
            if hasSecretKey() then
                networkModule.Invoke("Easter_SecretUnlock")
                networkModule.Fire("Instancing_PlayerLeaveInstance", "EasterEvent")
                wait(0.5)
                networkModule.Invoke("Instancing_PlayerEnterInstance", "EasterEggRoulette")
                wait(0.5)
                networkModule.Invoke("Instancing_InvokeCustomFromClient", "EasterEggRoulette", "ClaimSecretEgg", 7)
                networkModule.Fire("Instancing_PlayerLeaveInstance", "EasterEggRoulette")
                wait(0.5)
                networkModule.Invoke("Instancing_PlayerEnterInstance", "EasterEvent")
                wait(1)
                
                -- Clean up GUI
                for _, guiElement in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
                    if guiElement:IsA("Model") then
                        guiElement:Destroy()
                    end
                end
            end
        end
    else
        return
    end
end

local lastEggOpenTime = tick()

local function farmEasterLastArea()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local instanceModule = require(game:GetService("ReplicatedStorage").Library.Client.InstancingCmds)
        local saveData = require(game.ReplicatedStorage.Library.Client.Save).Get()
        
        if saveData then
            local instanceData = instanceModule.Get()
            if instanceData then
                local instanceVars = saveData.InstanceVars
                local currentCoins = getEasterCoins()
                local nextZone = getMaximumOwnedZoneNumber() + 1
                local zoneData = instanceData.instanceZones[nextZone]
                
                if zoneData then
                    local currentQuest = instanceVars.EasterEvent.QuestActive
                    if currentQuest then
                        local questId = getQuestId(currentQuest.Type)
                        local questsNeeded = currentQuest.Amount - currentQuest.Progress
                        
                        print("[DEBUG] \n Current Quest: " .. questId .. " \n Amount Needed: " .. currentQuest.Progress .. "/" .. currentQuest.Amount)
                        
                        if questId == "GOLD_PET" and 0 < questsNeeded then
                            local normalPet = findNormalPetForConversion(questsNeeded)
                            if normalPet then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.__THINGS.__INSTANCE_CONTAINER.Active.EasterEvent.Teleports["1"].CFrame
                                wait(1)
                                networkModule.Invoke("GoldMachine_Activate", normalPet, questsNeeded)
                            else
                                teleportToEasterEgg()
                                getgenv().v_settings.functions.OpenClosestEgg()
                            end
                        elseif questId == "EGG" and 0 < questsNeeded then
                            teleportToEasterEgg()
                            openClosestEgg()
                        elseif questId == "RAINBOW_PET" and 0 < questsNeeded then
                            local goldenPet = findGoldenPetForConversion(questsNeeded)
                            if goldenPet then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.__THINGS.__INSTANCE_CONTAINER.Active.EasterEvent.Teleports["1"].CFrame
                                wait(1)
                                networkModule.Invoke("RainbowMachine_Activate", goldenPet, questsNeeded)
                            else
                                teleportToEasterEgg()
                                getgenv().v_settings.functions.OpenClosestEgg()
                            end
                        elseif questId == "BREAKABLE" and 0 < questsNeeded then
                            local targetZone = 1
                            local easterEvent = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent")
                            if not easterEvent then
                                return
                            end
                            
                            for _, teleport in pairs(easterEvent.Teleports:GetChildren()) do
                                if tonumber(teleport.Name) == targetZone and 
                                   (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (teleport.Position + Vector3.new(55, 0, -25))).Magnitude >= 35 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = teleport.CFrame + Vector3.new(55, 0, -25)
                                end
                            end
                        elseif questsNeeded < 0 then
                            if currentCoins < zoneData.CurrencyCost then
                                if tick() - lastEggOpenTime >= 60 then
                                    lastEggOpenTime = tick()
                                    openClosestEgg()
                                end
                                
                                local easterEvent = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent")
                                local currentZone = getMaximumOwnedZoneNumber()
                                local teleports = easterEvent:FindFirstChild("Teleports")
                                
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (teleports[tostring(currentZone)].Position + Vector3.new(55, 0, -25))).Magnitude >= 35 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = teleports[tostring(currentZone)].CFrame + Vector3.new(55, 0, -25)
                                end
                            else
                                buyEasterZone()
                            end
                        end
                    elseif currentCoins < zoneData.CurrencyCost then
                        local teleports = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent"):FindFirstChild("Teleports")
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (teleports["1"].Position + Vector3.new(55, 0, -25))).Magnitude >= 35 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = teleports["1"].CFrame + Vector3.new(55, 0, -25)
                        end
                    else
                        buyEasterZone()
                    end
                    return
                else
                    local currentZone = getMaximumOwnedZoneNumber()
                    local easterEvent = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent")
                    
                    if easterEvent then
                        for _, teleport in pairs(easterEvent.Teleports:GetChildren()) do
                            if tonumber(teleport.Name) == currentZone and 
                               (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (teleport.Position + Vector3.new(55, 0, -25))).Magnitude >= 35 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = teleport.CFrame + Vector3.new(55, 0, -25)
                            end
                        end
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end

-- Easter upgrades
local easterUpgrades = game:GetService("ReplicatedStorage").__DIRECTORY.EventUpgrades.Event.EasterUpgrades
local upgradeList = {}

for _, upgradeModule in pairs(easterUpgrades:GetChildren()) do
    local upgradeData = require(upgradeModule)
    table.insert(upgradeList, upgradeData._id)
end

local function getEasterTokens()
    local saveData = require(game.ReplicatedStorage.Library.Client.Save).Get()
    if saveData then
        local miscInventory = saveData.Inventory.Misc
        for _, itemData in pairs(miscInventory) do
            if itemData.id == "Easter Token" then
                return itemData._am or 1
            end
        end
        return nil
    end
end

local function buyEasterUpgrades()
    local selectedUpgrades = getgenv().v_settings.functionToggles.SelectedChestsUpgrades
    if #selectedUpgrades ~= 0 then
        local purchasedUpgrades = require(game.ReplicatedStorage.Library.Client.Save).Get().EventUpgrades
        
        for _, upgradeModule in pairs(easterUpgrades:GetChildren()) do
            local upgradeData = require(upgradeModule)
            if table.find(selectedUpgrades, upgradeData._id) then
                local currentTier = (purchasedUpgrades[upgradeData._id] or 0) + 1
                local tierCost = upgradeData.TierCosts[currentTier]
                
                if not tierCost then
                    return
                end
                
                if tierCost._data._am <= getEasterTokens() and networkModule.Invoke("EventUpgrades: Purchase", upgradeData._id) and math.random(1, 3) == 3 then
                    networkModule.Fire("EventLog_Once", "CloseTab", "EasterUpgradeMachine")
                end
            end
        end
    end
end

local function makeChestHeroic()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        if require(game.ReplicatedStorage.Library.Client.Save).Get().EasterHeroicActivations >= 1 then
            networkModule.Fire("Instancing_FireCustomFromClient", "EasterEvent", "SpawnHeroicChest")
        end
    else
        return
    end
end

-- Utility functions
function getcurrency()
    local currentWorld = gameFunctions.WorldUtil:GetWorld()
    local worldNumber = currentWorld.WorldNumber
    
    if worldNumber == 1 then
        return getgenv().VRT.Lib.CurrencyCmds.Get("Coins")
    elseif worldNumber == 2 then
        return getgenv().VRT.Lib.CurrencyCmds.Get("TechCoins")
    elseif worldNumber == 3 then
        return getgenv().VRT.Lib.CurrencyCmds.Get("VoidCoins")
    end
end

function RandomCoinNumber(breakableList)
    if breakableList == nil then
        return nil
    elseif #breakableList ~= 0 then
        return breakableList[math.random(1, #breakableList)]
    else
        return nil
    end
end

function PlayerPets()
    table.clear(playerPetsList)
    for _, petData in pairs(playerPetModule.GetAll()) do
        if petData.owner == game.Players.LocalPlayer then
            table.insert(playerPetsList, petData)
        end
    end
    return playerPetsList
end

function partunderplayer()
    local hitPart, hitPosition = nil, nil
    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
        local character = game.Players.LocalPlayer.Character
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local rayDirection = Vector3.new(0, -500, 0)
            local ray = Ray.new(humanoidRootPart.Position, rayDirection)
            hitPart, hitPosition = game.Workspace:FindPartOnRay(ray, character)
        end
    end
    return hitPart, hitPosition
end

function GetClosestBreakables()
    if game.Players.LocalPlayer.Character then
        table.clear(allPets)
        local allBreakables = workspace.__THINGS:WaitForChild("Breakables"):GetChildren()
        local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        
        local instanceData = getgenv().VRT.Lib.InstancingCmds.Get()
        local instanceId = instanceData and instanceData.instanceID or nil
        local currentZone = getgenv().VRT.Lib.MapCmds.GetCurrentZone()
        
        for _, breakable in pairs(allBreakables) do
            if breakable:IsA("Model") then
                local breakableZone = breakable:GetAttribute("ParentID")
                if (breakableZone == currentZone or breakableZone == instanceId) and 
                   (breakable.WorldPivot.Position - playerPosition).Magnitude < 85 then
                    table.insert(allPets, breakable.Name)
                end
            end
        end
        
        return allPets
    end
end

function MaxEventZone()
    if instanceModule.Get() then
        return #instanceModule.Get().instanceZones
    end
end

function GetCurrentEvent()
    local allInstances = instanceModule.All()
    for _, instanceName in pairs(allInstances) do
        if instanceName:match("Event") then
            currentEventName = instanceName
        end
    end
end

function GetCurrentEventInstance()
    local instanceData = instanceModule.Get()
    if not instanceData then
        return false
    end
    
    currentInstance = instanceData
    currentInstanceId = instanceData.instanceID
    return true
end

function GetCurrentEventInstanceZones()
    return currentInstance.instanceZones
end

function GetCurrentEventInstanceFolder()
    currentInstanceFolder = workspace.__THINGS.Instances:FindFirstChild(currentInstanceId)
    return currentInstanceFolder
end

function GetEventMaximumZoneNumber()
    return instanceZoneModule.GetMaximumOwnedZoneNumber()
end

function GetMaxHatchCount()
    return eggCommands.GetMaxHatch()
end

function GetEventZoneToBuy()
    local instanceZones = GetCurrentEventInstanceZones()
    local maxZone = GetEventMaximumZoneNumber()
    
    if instanceZones[maxZone] and instanceZones[maxZone + 1] then
        return instanceZones[maxZone], instanceZones[maxZone + 1]
    else
        return nil
    end
end

function BuyZone()
    local currentCoins = getcurrency()
    local zoneToBuy = GetEventZoneToBuy()
    local zoneCost = zoneToBuy.CurrencyCost
    local zoneName = zoneToBuy.DisplayName
    
    if zoneCost > currentCoins then
        return false
    end
    
    local buyArgs = {currentInstanceId, GetEventMaximumZoneNumber() + 1}
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("InstanceZones_RequestPurchase"):InvokeServer(unpack(buyArgs))
    return true
end

function GetQuestFromId(questId)
    for goalId, goalType in pairs(questGoals) do
        if questId == goalType then
            return goalId
        end
    end
end

function GetIdFromQuest(questName)
    for goalId, goalType in pairs(questGoals) do
        if questName == goalId then
            return goalType
        end
    end
end

function CurrentZoneQuest()
    table.clear(currentQuestData)
    local instanceVars = saveModule.InstanceVars[currentInstanceId].QuestActive
    currentQuestData.progress = instanceVars.Progress
    currentQuestData.type = instanceVars.Type
    currentQuestData.amount = instanceVars.Amount
    return currentQuestData
end

function MakeQuest()
    local questData = CurrentZoneQuest()
    local questName = GetQuestFromId(questData.type)
    
    if questData.progress >= questData.amount then
        BuyZone()
    end
    
    warn(questName)
    
    if questName == "RAINBOW_PET" then
        local petInventory = saveModule.Inventory.Pet
        for petUid, petData in pairs(petInventory) do
            local petAmount = petData._am or 1
            local petType = petData.pt
            if not petData.sh and petType == 1 and questData.amount * 10 < petAmount then
                local convertArgs = {petUid, questData.amount + 2}
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("RainbowMachine_Activate"):InvokeServer(unpack(convertArgs))
            end
        end
    elseif questName == "BREAKABLE" then
        local instanceFolder = GetCurrentEventInstanceFolder()
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - instanceFolder.BREAKABLE_SPAWNS.Main_1.Position).Magnitude >= 40 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = instanceFolder.BREAKABLE_SPAWNS.Main_1.CFrame
        end
    elseif questName == "EGG" then
        TeleportToEventZone(1)
    elseif questName == "GOLD_PET" then
        local petInventory = saveModule.Inventory.Pet
        for petUid, petData in pairs(petInventory) do
            local petAmount = petData._am or 1
            local petType = petData.pt or 0
            if not petData.sh and petType == 0 and questData.amount * 10 < petAmount then
                local convertArgs = {petUid, questData.amount + 2}
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("RainbowMachine_Activate"):InvokeServer(unpack(convertArgs))
            end
        end
    end
end

function TeleportToEventZone(zoneNumber)
    local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local breakableSpawns = GetCurrentEventInstanceFolder().BREAKABLE_SPAWNS
    local teleports = workspace.__THINGS.__INSTANCE_CONTAINER.Active.PetGamesEvent.Teleports
    
    if breakableSpawns:FindFirstChild("Main_" .. tostring(zoneNumber)) and 
       (playerRoot.Position - breakableSpawns:FindFirstChild("Main_" .. tostring(zoneNumber)).Position).Magnitude <= 90 then
        local closestEgg = GetClosestEventEgg()
        if (playerRoot.Position - closestEgg.Center.Position).Magnitude >= 50 then
            playerRoot.CFrame = closestEgg.Center.CFrame + Vector3.new(0, 0, -30)
        end
    else
        playerRoot.CFrame = teleports[tostring(zoneNumber)].CFrame
        task.wait(1)
    end
end

function PrintDebugInfo()
    print("Debug Info:")
    print(" - ScriptVersion: ", scriptVersion)
    print(" - shouldcreatenewraid: ", shouldcreatenewraid)
    print(" - InRaid: ", InRaid())
    print(" - GetDifficulty: ", GetDifficulty())
    print(" - GetAvailablePortal: ", GetAvailablePortal())
    print(" - GetPartyMode: ", GetPartyMode())
    print(" - IsFarming: ", getgenv().Raid.IsFarming)
    print(" - GetThreadIdentity: ", getthreadidentity())
    print(" - GetThreadContext: ", getthreadcontext())
    setthreadidentity(8)
end

-- Load flag data
local flagDirectory = require(game:GetService("ReplicatedStorage").Library.Directory.ZoneFlags)
local availableFlags = {Flags = {}}

for flagId, _ in pairs(flagDirectory) do
    table.insert(availableFlags.Flags, flagId)
end

setthreadidentity(8)

local function formatTableAsString(tableData)
    local result = ""
    for key, value in pairs(tableData) do
        result = result .. key .. " " .. value .. "\n"
    end
    return result
end

local function formatTableForFile(tableData)
    local result = ""
    local isFirst = true
    for key, value in pairs(tableData) do
        if isFirst then
            result = result .. key .. " " .. value
            isFirst = false
        else
            result = result .. "," .. key .. " " .. value
        end
    end
    return result
end

-- Load saved mailbox items
(function()
    if isfile("VRT/Config/MailboxItems.txt") then
        local fileContent = readfile("VRT/Config/MailboxItems.txt")
        local items = {}
        
        for itemString in string.gmatch(fileContent, "([^,]+)") do
            local itemName, itemAmount = string.match(itemString, "^(.-)%s*(%d+)$")
            if itemName and itemAmount then
                table.insert(items, {
                    name = itemName,
                    amount = tonumber(itemAmount)
                })
            end
        end
        
        for _, itemData in pairs(items) do
            getgenv().v_settings.functionToggles.MailboxItems[itemData.name] = itemData.amount
        end
    end
end)()

-- UI Creation
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield.CreateWindow({
    Name = "VRT PET SIM 99",
    Icon = 0,
    LoadingTitle = "VRT PET SIM 99",
    LoadingSubtitle = "VRT PET SIM 99",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "VRT"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

-- Helper functions for UI creation
local function createAutoToggle(tab, name, flag, targetFunction, delay, disableFlag)
    tab:CreateToggle({
        Name = name,
        CurrentValue = false,
        Flag = flag,
        Callback = function(value)
            getgenv().v_settings.functionToggles[flag] = value
            task.spawn(function()
                while getgenv().v_settings.functionToggles[flag] do
                    if not getgenv().v_settings.functionToggles[disableFlag] then
                        local success, errorMsg = pcall(function()
                            return targetFunction()
                        end)
                        if not success then
                            warn("[ERROR]", flag, errorMsg)
                        end
                    end
                    task.wait(delay)
                end
            end)
        end
    })
end

local function createFunctionToggle(tab, name, flag, targetFunction, delay, enableFlag, disableFlag, specialFlag)
    tab:CreateToggle({
        Name = name,
        CurrentValue = false,
        Flag = flag,
        Callback = function(value)
            if flag == "StatiscticsUI" and not value then
                for _, guiElement in pairs(game.CoreGui:GetChildren()) do
                    if guiElement.Name == "MainScreen" then
                        guiElement:Destroy()
                    end
                end
            end
            
            if enableFlag == "FarmRaid" then
                shouldcreatenewraid = true
            end
            
            print("Setting:", flag, "To:", value)
            getgenv().v_settings.functionToggles[flag] = value
            
            local waitTime = 0
            task.spawn(function()
                while getgenv().v_settings.functionToggles[flag] do
                    if not getgenv().v_settings.functionToggles[disableFlag] then
                        local success, errorMsg = xpcall(targetFunction, function(err)
                            return debug.traceback(err, 2)
                        end)
                        if not success then
                            warn("[ERROR]", flag, errorMsg)
                        end
                    end
                    
                    if specialFlag ~= "MineEvery" then
                        waitTime = delay
                    else
                        waitTime = getgenv().v_settings.functionToggles[specialFlag] or delay
                    end
                    task.wait(waitTime)
                end
            end)
        end
    })
end

local function createButton(tab, name, callback)
    tab:CreateButton({
        Name = name,
        Callback = callback
    })
end

local function createDropdown(tab, name, flag, options, isMultiSelect)
    if isMultiSelect then
        if not getgenv().v_settings.functionToggles[flag] then
            getgenv().v_settings.functionToggles[flag] = {}
        end
        
        tab:CreateDropdown({
            Name = name,
            Options = options,
            CurrentOption = {},
            MultipleOptions = isMultiSelect,
            Flag = flag,
            Callback = function(selectedOptions)
                for _, option in pairs(selectedOptions) do
                    if table.find(options, option) and not table.find(getgenv().v_settings.functionToggles[flag], option) then
                        table.insert(getgenv().v_settings.functionToggles[flag], option)
                    end
                end
                
                for i, existingOption in pairs(getgenv().v_settings.functionToggles[flag]) do
                    if not table.find(selectedOptions, existingOption) then
                        table.remove(getgenv().v_settings.functionToggles[flag], i)
                    end
                end
            end
        })
    else
        tab:CreateDropdown({
            Name = name,
            Options = options,
            CurrentOption = {"None"},
            MultipleOptions = isMultiSelect,
            Flag = flag,
            Callback = function(selectedOptions)
                getgenv().v_settings.functionToggles[flag] = selectedOptions[1]
            end
        })
    end
end

local function createInput(tab, name, flag, placeholder)
    tab:CreateInput({
        Name = name,
        CurrentValue = "",
        PlaceholderText = placeholder,
        RemoveTextAfterFocusLost = false,
        Flag = flag,
        Callback = function(value)
            getgenv().v_settings.functionToggles[flag] = value
            Rayfield:Notify({
                Title = name .. " Updated!",
                Content = name .. " Updated!",
                Duration = 3,
                Image = 4483362458
            })
        end
    })
end

-- Create tabs and UI elements
local testingTab = Window:CreateTab("Testing", "box")
testingTab:CreateSection("Testing Section")
testingTab:CreateLabel("Discord: .gg/JwfXeX9gjw", "notepad-text", Color3.fromRGB(119, 133, 204), false)
testingTab:CreateLabel("Updated For Conveyor Event", "notepad-text", Color3.fromRGB(29, 219, 0), false)

testingTab:CreateSection("Webhook Section")
createInput(testingTab, "Discord Webhook (Ping On Huge/Titanic)", "DiscordWebhook", "Input Discord Webhook")
createInput(testingTab, "Discord UserId", "DiscordUserId", "Input Discord Account ID")
createFunctionToggle(testingTab, "Send Webhook on Huge/Titanic Pet", "SendWebhook", CheckPets, 15)

testingTab:CreateSection("Testing Functions Section")
ShinyRelicsParagraph = testingTab:CreateParagraph({
    Title = "Collected Relics",
    Content = "You Have Collected 0/0 Shiny Relics"
})

createFunctionToggle(testingTab, "Collect Relics", "AutoRelics", collectRelics, 5)
createFunctionToggle(testingTab, "Auto Claim Rank Rewards", "AutoClaimRankRewards", claimRankRewards, 5)
createAutoToggle(testingTab, "Buy Next Zone", "BuyNextZone", gameFunctions, gameFunctions.BuyNextZone, 0.05)
createAutoToggle(testingTab, "Teleport To Best Unlocked World", "TeleportToBestUnlockedWorld", gameFunctions, gameFunctions.TeleportToAnotherWorld, 1)
createAutoToggle(testingTab, "Buy Pet Slots", "BuyPetSlots", gameFunctions, gameFunctions.BuyPetSlots, 0.25)
createAutoToggle(testingTab, "Use Ultimate", "UseUltimate", gameFunctions, gameFunctions.ActivateUltimate, 0.25)

createDropdown(testingTab, "Select Flag to Use", "SelectedFlag", availableFlags.Flags, false)

testingTab:CreateSlider({
    Name = "Flag Amount to Use",
    Range = {1, 45},
    Increment = 1,
    Suffix = "Flags",
    CurrentValue = 1,
    Flag = "FlagAmount",
    Callback = function(value)
        getgenv().v_settings.functionToggles.FlagAmount = value
    end
})

createAutoToggle(testingTab, "Use Selected Flag", "UseSelectedFlag", gameFunctions, gameFunctions.ActivateFlag, 1)
createFunctionToggle(testingTab, "Auto Daycare (Claim and Enroll)", "AutoDayCare", PutPetsInDaycare, 2.5)
createAutoToggle(testingTab, "Auto Free Gifts", "AutoFreeGifts", gameFunctions, gameFunctions.ClaimFreeGifts, 1.5)
createButton(testingTab, "Debug Print", PrintDebugInfo)

-- Event Tab
local eventTab = Window:CreateTab("Event", "box")
eventTab:CreateSection("Event Section")
createFunctionToggle(eventTab, "Auto Enter Easter Event", "EnterEasterEvent", enterEasterEvent, 5)
createFunctionToggle(eventTab, "Farm Last Area", "FarmEasterLastArea", farmEasterLastArea, 1)
createFunctionToggle(eventTab, "Claim Easter Eggs", "EasterClaimEgg", claimEasterEggs, 2.5)
createDropdown(eventTab, "Select Chest Upgrades you Want to Upgrade", "SelectedChestsUpgrades", upgradeList, true)
createFunctionToggle(eventTab, "Buy Selected Chest Upgrades", "BuySelectedChestUpgrades", buyEasterUpgrades, 1.5)
createFunctionToggle(eventTab, "Make Chest Heroic", "ChestHeroicMode", makeChestHeroic, 1)
createFunctionToggle(eventTab, "Auto Make Egg Roulette", "AutoEggRoulette", unlockSecretEgg, 1)
createFunctionToggle(eventTab, "Auto Boost Easter Basket", "BoostGiantBasket", boostGiantBasket, 5)

-- Mailbox Tab
local mailboxTab = Window:CreateTab("Mailbox", "box")
mailboxTab:CreateSection("Mailbox Section")

local mailboxParagraph = mailboxTab:CreateParagraph({
    Title = "Selected Items To Mailbox",
    Content = "<font color='#4bc0ff'>" .. formatTableAsString(getgenv().v_settings.functionToggles.MailboxItems) .. "</font>"
})

mailboxTab:CreateInput({
    Name = "Input Username you want to mailbox items to",
    CurrentValue = "",
    PlaceholderText = "Input Username",
    RemoveTextAfterFocusLost = false,
    Flag = "MailboxUsername",
    Callback = function(value)
        getgenv().v_settings.functionToggles.MailboxUsername = value
    end
})

createDropdown(mailboxTab, "Send Huges Mode", "MailboxSendHugesType", {"All", "New"}, false)

mailboxTab:CreateInput({
    Name = "Input Item name you want to mailbox",
    CurrentValue = "",
    PlaceholderText = "Input Item name",
    RemoveTextAfterFocusLost = false,
    Flag = "InputedMailboxItem",
    Callback = function(value)
        getgenv().v_settings.functionToggles.InputedMailboxItem = value
    end
})

mailboxTab:CreateInput({
    Name = "Send if Item Amount is higher than (amount)",
    CurrentValue = "",
    PlaceholderText = "Send if Higher Than",
    RemoveTextAfterFocusLost = false,
    Flag = "InputedMailboxAmount",
    Callback = function(value)
        if value:match("%d+") then
            getgenv().v_settings.functionToggles.InputedMailboxAmount = tonumber(value)
        else
            Rayfield:Notify({
                Title = "Item Amount is not number",
                Content = "Item Amount need to be a number",
                Duration = 5,
                Image = 4483362458
            })
        end
    end
})

createButton(mailboxTab, "Add Inputed Item To List", function()
    if not addMailboxItem() then
        Rayfield:Notify({
            Title = "Wrong Item Name",
            Content = "Inputed Wrong Item Name Try With Capitalized Letters",
            Duration = 5,
            Image = 4483362458
        })
    end
    mailboxParagraph:Set({
        Title = "Selected Items To Mailbox",
        Content = "<font color='#4bc0ff'>" .. formatTableAsString(getgenv().v_settings.functionToggles.MailboxItems) .. "</font>"
    })
    writefile("VRT/Config/MailboxItems.txt", formatTableForFile(getgenv().v_settings.functionToggles.MailboxItems))
end)

createButton(mailboxTab, "Remove Inputed Item To List", function()
    removeMailboxItem()
    mailboxParagraph:Set({
        Title = "Selected Items To Mailbox",
        Content = "<font color='#4bc0ff'>" .. formatTableAsString(getgenv().v_settings.functionToggles.MailboxItems) .. "</font>"
    })
    writefile("VRT/Config/MailboxItems.txt", formatTableForFile(getgenv().v_settings.functionToggles.MailboxItems))
end)

mailboxTab:CreateToggle({
    Name = "Send Selected Items",
    CurrentValue = false,
    Flag = "SendSelectedItemsMailbox",
    Callback = function(value)
        getgenv().v_settings.functionToggles.MailboxEnabled = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.MailboxEnabled do
                sendMailboxItems()
                task.wait(5)
            end
        end)
    end
})

mailboxTab:CreateToggle({
    Name = "Send Huges By Mode",
    CurrentValue = false,
    Flag = "HugeMailboxEnabled",
    Callback = function(value)
        getgenv().v_settings.functionToggles.HugeMailboxEnabled = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.HugeMailboxEnabled do
                sendHugePet()
                task.wait(5)
            end
        end)
    end
})

mailboxTab:CreateToggle({
    Name = "Auto Claim Mailbox",
    CurrentValue = false,
    Flag = "MailboxClaimAll",
    Callback = function(value)
        getgenv().v_settings.functionToggles.MailboxClaimAll = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.MailboxClaimAll do
                claimAllMailbox()
                task.wait(5)
            end
        end)
    end
})

-- Auto-Farm Tab
local autoFarmTab = Window:CreateTab("Auto-Farm", "dollar-sign")
autoFarmTab:CreateSection("Farming Section")

autoFarmTab:CreateToggle({
    Name = "Fast Farm",
    CurrentValue = false,
    Flag = "FastFarm",
    Callback = function(value)
        getgenv().v_settings.functionToggles.FastFarm = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.FastFarm do
                getgenv().v_settings.functions.FastFarm()
                task.wait(0.15)
            end
        end)
    end
})

autoFarmTab:CreateToggle({
    Name = "(Old test which works better for you) Fast Farm",
    CurrentValue = false,
    Flag = "FastFarm2",
    Callback = function(value)
        getgenv().v_settings.functionToggles.FastFarm2 = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.FastFarm2 do
                getgenv().v_settings.functions.FastFarm2()
                task.wait(0.2)
            end
        end)
    end
})

autoFarmTab:CreateToggle({
    Name = "Auto Collect Orbs",
    CurrentValue = false,
    Flag = "AutoOrbs",
    Callback = function(value)
        getgenv().v_settings.functionToggles.AutoOrbs = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.AutoOrbs do
                getgenv().v_settings.functions.CollectOrbs()
                task.wait(0.01)
            end
        end)
    end
})

autoFarmTab:CreateToggle({
    Name = "Inf Pet Speed",
    CurrentValue = false,
    Flag = "InfPetSpeed",
    Callback = function(value)
        getgenv().v_settings.functionToggles.HugePetSpeed = value
        if value then
            getgenv().v_settings.functions.HugePetSpeed()
        else
            playerPetModule.CalculateSpeedMultiplier = getgenv().v_settings.functionsValues.PetSpeed
        end
    end
})

autoFarmTab:CreateSection("Egg Opening")

local hideAnimationToggle = autoFarmTab:CreateToggle({
    Name = "Hide Egg Animation",
    CurrentValue = false,
    Flag = "HideEggAnimation",
    Callback = function(value)
        getgenv().v_settings.functionToggles.HideEggAnimation = value
        if value then
            HookEggAnimationToggle:Set(false)
            task.spawn(function()
                while getgenv().v_settings.functionToggles.HideEggAnimation do
                    getgenv().v_settings.functions.HideEggAnimation()
                    wait(5)
                end
            end)
        else
            eggOpeningModule.PlayEggAnimation = getgenv().v_settings.functionsValues.EggAnimation
        end
    end
})

HookEggAnimationToggle = autoFarmTab:CreateToggle({
    Name = "Hook Egg Animation",
    CurrentValue = false,
    Flag = "HookEggAnimation",
    Callback = function(value)
        getgenv().v_settings.functionToggles.HookEggAnimation = value
        if value then
            hideAnimationToggle:Set(false)
            task.spawn(function()
                while getgenv().v_settings.functionToggles.HookEggAnimation do
                    getgenv().v_settings.functions.HookEggAnimation()
                    wait(5)
                end
            end)
        else
            eggOpeningModule.PlayEggAnimation = getgenv().v_settings.functionsValues.EggAnimation
        end
    end
})

autoFarmTab:CreateToggle({
    Name = "Auto Open Closest Egg",
    CurrentValue = false,
    Flag = "AutoOpenClosestEgg",
    Callback = function(value)
        getgenv().v_settings.functionToggles.OpenClosestEgg = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.OpenClosestEgg do
                getgenv().v_settings.functions.OpenClosestEgg()
                task.wait(0.01)
            end
        end)
    end
})

autoFarmTab:CreateSection("Click Aura")
autoFarmTab:CreateSlider({
    Name = "Click Aura Slider",
    Range = {0, 150},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 75,
    Flag = "ClickAuraSlider",
    Callback = function(value)
        getgenv().v_settings.functionsValues.ClickAuraValue = value
    end
})

autoFarmTab:CreateToggle({
    Name = "Click Aura Visualizer",
    CurrentValue = false,
    Flag = "ClickAuraVisualizer",
    Callback = function(value)
        if not value and workspace:FindFirstChild("ClickAuraVisualizer") then
            workspace:FindFirstChild("ClickAuraVisualizer"):Destroy()
        end
        
        getgenv().v_settings.functionToggles.ClickAuraVisualizer = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.ClickAuraVisualizer do
                getgenv().v_settings.functions.VisualizeClickAura(getgenv().v_settings.functionsValues.ClickAuraValue).Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                task.wait(0.01)
            end
        end)
    end
})

autoFarmTab:CreateToggle({
    Name = "Click Aura",
    CurrentValue = false,
    Flag = "ClickAura",
    Callback = function(value)
        getgenv().v_settings.functionToggles.ClickAura = value
        task.spawn(function()
            while getgenv().v_settings.functionToggles.ClickAura do
                getgenv().v_settings.functions.ClickAura()
                task.wait(0.01)
            end
        end)
    end
})

autoFarmTab:CreateSection("Optimize")
autoFarmTab:CreateToggle({
    Name = "Optimize Breakables",
    CurrentValue = false,
    Flag = "OptimizeBreakables",
    Callback = function(value)
        getgenv().v_settings.functionToggles.OptimizeBreakables = value
        if value then
            pcall(function()
                return getgenv().v_settings.functions.OptimizeBreakables()
            end)
        elseif getgenv().v_settings.OptimizeBreakables then
            getgenv().v_settings.OptimizeBreakables:Disconnect()
            getgenv().v_settings.OptimizeBreakables = nil
        end
    end
})

autoFarmTab:CreateToggle({
    Name = "Optimize Pets",
    CurrentValue = false,
    Flag = "OptimizePets",
    Callback = function(value)
        getgenv().v_settings.functionToggles.OptimizePets = value
        while getgenv().v_settings.functionToggles.OptimizePets do
            getgenv().v_settings.functions.OptimizePets()
            task.wait(5)
        end
    end
})

-- Consume/Open Tab
local fruitsDirectory = require(game:GetService("ReplicatedStorage").Library.Directory.Fruits)
local lootboxesDirectory = require(game:GetService("ReplicatedStorage").Library.Directory.Lootboxes)
local giftsDirectory = game:GetService("ReplicatedStorage").__DIRECTORY.MiscItems.Categorized.Gifts

local fruitOptions = {}
local lootboxOptions = {}
local giftOptions = {}

for fruitName, _ in pairs(fruitsDirectory) do
    table.insert(fruitOptions, fruitName)
    table.insert(fruitOptions, "Shiny " .. fruitName)
end

for lootboxName, _ in pairs(lootboxesDirectory) do
    table.insert(lootboxOptions, lootboxName)
end

for _, giftModule in pairs(giftsDirectory:GetChildren()) do
    table.insert(giftOptions, giftModule.Name)
end

local consumeTab = Window:CreateTab("Auto Consume/Open", "dollar-sign")
consumeTab:CreateSection("Fruits Section")
createDropdown(consumeTab, "Select Fruits to Use", "SelectedFruits", fruitOptions, true)
createFunctionToggle(consumeTab, "Use Selected Fruits", "UseSelectedFruits", useSelectedFruits, 5)

consumeTab:CreateSection("LootBoxes Section")
createDropdown(consumeTab, "Select Lootboxes to Open", "SelectedLootboxes", lootboxOptions, true)
createFunctionToggle(consumeTab, "Open Selected Lootboxes", "OpenSelectedLootboxes", openSelectedLootboxes, 1)

createDropdown(consumeTab, "Select Gift Bags to Open", "SelectedGifts", giftOptions, true)
createFunctionToggle(consumeTab, "Open Selected GiftBags", "OpenSelectedGifts", openSelectedGifts, 1)

-- Auto-Rank Tab
local autoRankTab = Window:CreateTab("Auto-Rank", "dollar-sign")
autoRankTab:CreateSection("Ranking Section")

local autoRankModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Verteniasty/Pet-rbx/refs/heads/main/AutoRank.lua"))()
local hasCreatedAutoRankToggle = false
local shouldCheckKey = true

function CreateAutoRankToggle()
    if not hasCreatedAutoRankToggle then
        if isfile("VRT_KEYSYSTEM.txt") then
            if keySystemValid(readfile("VRT_KEYSYSTEM.txt")) then
                print("CREATE TOGGLE")
                hasCreatedAutoRankToggle = true
                createFunctionToggle(autoRankTab, "Auto Rank", "AutoRank", autoRankModule, 1)
            else
                if shouldCheckKey then
                    shouldCheckKey = false
                    return
                end
                print("KEY EXPIRED")
                keySystemFunction()
            end
        else
            if shouldCheckKey then
                shouldCheckKey = false
                return
            end
            print("NO FILE")
            keySystemFunction()
        end
    end
end

setthreadidentity(8)
autoRankTab:CreateLabel("To Access Auto Rank You Need To Do A Key", "notepad-text", Color3.fromRGB(119, 133, 204), false)
createFunctionToggle(autoRankTab, "Auto Claim Rank Rewards", "AutoClaimRankRewards", claimRankRewards, 3)
createButton(autoRankTab, "Access Auto Rank", CreateAutoRankToggle)
CreateAutoRankToggle()

-- Load configuration and start anti-afk
Rayfield:LoadConfiguration()
task.spawn(antiafk)