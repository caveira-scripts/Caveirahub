-- ts file was generated at discord.gg/25ms


task.spawn(function()
    local function v2()
        local v1 = game:GetService("CoreGui"):WaitForChild("RobloxPromptGui", 60):WaitForChild("promptOverlay", 60):WaitForChild("ErrorPrompt", 999999)
        print("Found:", v1)
        if v1 then
            game["Teleport Service"]:Teleport(game.PlaceId)
        end
    end
    while true do
        v2()
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
        local v3 = require(game.ReplicatedStorage.Library.Client.Network)
        local vu4 = v3.Fire
        setreadonly(v3, false)
        function v3.Fire(...)
            if ({
                ...
            })[1] ~= "Idle Tracking: Update Timer" then
                return vu4(...)
            end
        end
        setreadonly(v3, true)
        local v5, v6, v7 = pairs(getconnections(game.UserInputService.WindowFocusReleased))
        while true do
            local v8
            v7, v8 = v5(v6, v7)
            if v7 == nil then
                break
            end
            if v8.Disable then
                v8:Disable()
            end
        end
        local v9, v10, v11 = pairs(getconnections(game.UserInputService.WindowFocused))
        while true do
            local v12
            v11, v12 = v9(v10, v11)
            if v11 == nil then
                break
            end
            if v12.Disable then
                v12:Disable()
            end
        end
        getgenv().AA = true
        while true do
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Unknown, false, nil)
            wait(math.random(15, 120))
        end
    end
end
local vu13 = nil
local vu14 = nil
local vu15 = nil
task.spawn(function()
    local v16, v17, v18 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Verteniasty/Pet-rbx/refs/heads/main/KeySystemMain.lua"))()
    vu15 = v18
    vu14 = v17
    vu13 = v16
end)
local v19 = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0"
}
local vu20 = {
    {
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z"
    },
    v19
}
local function vu24(p21)
    local v22 = ""
    for _ = 1, p21 do
        local v23 = vu20[math.random(1, # vu20)]
        v22 = v22 .. v23[math.random(1, # v23)]
    end
    return v22
end
local vu25 = identifyexecutor()
local v26 = require(game.ReplicatedStorage.Blunder.BlunderMessage)
local vu27 = v26.key
setreadonly(v26, false)
function v26.key(...)
    local v28 = ...
    if v28.message == "PING" or v28.message == "Anti Cheat fetched error in console" then
        return vu27(...)
    end
    warn("Anti Cheat fetched error in console")
    print("BLUNDER")
    print(v28.messageType)
    print(v28.message, "\n")
    local v29 = {}
    local v30 = {
        color = 16711680,
        fields = {
            {
                name = "Error Message",
                value = v28.message
            },
            {
                name = "Error Traceback",
                value = v28.stackTrace
            }
        },
        thumbnail = {
            url = "https://cdn.discordapp.com/attachments/1350493793803042816/1350494850935422986/warning.png?ex=67d6f1d7&is=67d5a057&hm=9fdca4551b0bddf817f164960286b4f800fb592287218c66ae273e3e9330c71c&"
        },
        footer = {
            text = game.Players.LocalPlayer.Name .. vu25
        }
    }
    __set_list(v29, 1, {
        v30
    });
    ({
        content = "Hook Fetched error in console!"
    }).embeds = v29
end
setreadonly(v26, true)
getgenv().VRT = {
    Lib = {}
}
local v31, v32, v33 = pairs(game:GetService("ReplicatedStorage").Library.Client:GetDescendants())
local vu34 = vu13
local vu35 = vu15
local vu36 = {
    [8737899170] = "World 1",
    [16498369169] = "World 2",
    [17503543197] = "World 3"
}
while true do
    local v37, vu38 = v31(v32, v33)
    if v37 == nil then
        break
    end
    v33 = v37
    if vu38:IsA("ModuleScript") then
        local _, v39 = pcall(function()
            return require(vu38)
        end)
        getgenv().VRT.Lib[tostring(vu38)] = v39
        getgenv().VRT.Lib[1] = "Inited"
    end
end
local function vu41()
    local v40 = {}
    if debug.getinfo(getgenv().request).what == "Lua" then
        table.insert(v40, "WHAT")
    end
    if isfunctionhooked(request) then
        table.insert(v40, "FH1")
    end
    if isfunctionhooked(getgenv().request) then
        table.insert(v40, "FH2")
    end
    return # v40 > 0 and true or false, v40
end
function SendWebhook(p42, p43)
    local v44, _ = vu41()
    if not v44 then
        local v45 = request
        local v46 = {
            Url = p42,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game.HttpService:JSONEncode(p43)
        }
        v45(v46)
    end
end
local vu47 = nil
task.spawn(function()
    vu47 = request({
        Url = "https://raw.githubusercontent.com/Verteniasty/Pets-Go/refs/heads/main/Version",
        Method = "GET"
    }).Body
    local v48 = identifyexecutor() or "Unknown"
    local v49 = game.MarketplaceService:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
    local v50 = {
        username = "Execution Logs",
        footer = {
            text = "Vrt Execution Log",
            icon_url = "https://cdn.discordapp.com/icons/1103035026930671656/724be00a3c4c6abaa52dc3d0dfff8991.webp?size=128"
        },
        embeds = {
            {
                title = "\239\191\189\239\191\189\239\184\143New Execution.",
                color = 4962791,
                fields = {
                    {
                        name = "",
                        value = "**`Player Name: " .. game.Players.LocalPlayer.Name .. "`\n" .. "`Placeid: " .. game.PlaceId .. "`\n" .. "`Game Name: " .. v49.Name .. "`\n" .. "`Execution Time: " .. os.date("%c") .. "`\n" .. "`Executor: " .. v48 .. "`**\n" .. "-# script version: " .. vu47
                    }
                }
            }
        }
    }
    SendWebhook("https://discord.com/api/webhooks/1360241802187112569/Xy16q8-7oTrrnVed2iRNKssVXy24oAtVqstyX47AL1VAQ3CTIeSEvtJlrw8yOgRo4g7t", v50)
end)
game:GetService("RunService")
local vu51 = require(game:WaitForChild("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Network"))
local vu52 = require(game:GetService("ReplicatedStorage").Library.Items)
local vu53 = {}
local vu54 = {}
local vu55 = {}
local vu56 = require(game.ReplicatedStorage.Library.Client.PlayerPet)
local vu57 = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game["Egg Opening Frontend"])
local vu58 = require(game:GetService("ReplicatedStorage").Library.Client.NotificationCmds)
local vu59 = require(game:GetService("ReplicatedStorage").Library.Client.InstancingCmds)
local vu60 = require(game:GetService("ReplicatedStorage").Library.Client.InstanceZoneCmds)
require(game:GetService("ReplicatedStorage").Library.Client.CustomEggsCmds)
local vu61 = require(game:GetService("ReplicatedStorage").Library.Client.EggCmds)
require(game:GetService("ReplicatedStorage").Library.Types.Quests)
require(game.ReplicatedStorage.Library.Client.Save)
local vu62 = nil
local vu63 = nil
local vu64 = nil
local vu65 = nil
local vu66 = {}
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
        EggAnimation = vu57.PlayEggAnimation,
        PetSpeed = vu56.CalculateSpeedMultiplier
    },
    functions = {
        CollectOrbs = function()
            local v67, v68, v69 = pairs(game:GetService("Workspace").__THINGS:FindFirstChild("Orbs"):GetChildren())
            while true do
                local v70
                v69, v70 = v67(v68, v69)
                if v69 == nil then
                    break
                end
                vu51.Fire("Orbs: Collect", {
                    tonumber(v70.Name)
                })
                v70:Destroy()
            end
        end,
        ClickAura = function()
            if not game.Players.LocalPlayer.Character then
                return
            end
            local v71 = game.Players.LocalPlayer.Character.HumanoidRootPart
            local v72, v73, v74 = pairs(workspace.__THINGS:WaitForChild("Breakables"):GetChildren())
            while true do
                local v75
                v74, v75 = v72(v73, v74)
                if v74 == nil then
                    break
                end
                if (v71.Position - v75.WorldPivot.Position).Magnitude < getgenv().v_settings.functionsValues.ClickAuraValue and v75:IsA("Model") then
                    vu51.UnreliableFire("Breakables_PlayerDealDamage", v75.Name)
                    break
                end
            end
        end,
        VisualizeClickAura = function(p76)
            if workspace:FindFirstChild("M") and getgenv().v_settings.functionToggles.ClickAuraVisualizer then
                local v77 = workspace:FindFirstChild("M")
                v77.Size = Vector3.new(0.2, p76 * 2, p76 * 2)
                v77.Rotation = Vector3.new(0, 0, 90)
                return v77
            end
            if getgenv().v_settings.functionToggles.ClickAuraVisualizer then
                local v78 = Instance.new("Part", workspace)
                v78.Name = "M"
                v78.CanCollide = false
                v78.Anchored = true
                v78.Shape = "Cylinder"
                v78.Size = Vector3.new(0.2, p76 * 2, p76 * 2)
                v78.Transparency = 0.5
                v78.BrickColor = BrickColor.new("Light green (Mint)")
                v78.Rotation = Vector3.new(0, 0, 90)
                return v78
            end
        end,
        OptimizeBreakables = function()
            getgenv().v_settings.OptimizeBreakables = workspace.__DEBRIS.ChildAdded:Connect(function(pu79)
                xpcall(function()
                    game.Debris:AddItem(pu79, 0)
                end, function(_)
                end)
            end)
        end,
        OptimizePets = function()
            local v80, v81, v82 = pairs(workspace.__THINGS.Pets:GetChildren())
            while true do
                local v83
                v82, v83 = v80(v81, v82)
                if v82 == nil then
                    break
                end
                local v84, v85, v86 = pairs(v83:GetDescendants())
                while true do
                    local v87
                    v86, v87 = v84(v85, v86)
                    if v86 == nil then
                        break
                    end
                    if v87:IsA("Part") then
                        v87.Color = Color3.fromRGB(255, 255, 255)
                        v87.Size = Vector3.new(2.5, 2.5, 2.5)
                        v87.Material = Enum.Material.SmoothPlastic
                    end
                    if v87:IsA("SpecialMesh") or (v87:IsA("ParticleEmitter") or (v87:IsA("MeshPart") or v87:IsA("Decal"))) then
                        v87:Destroy()
                    end
                end
            end
        end,
        FastFarm = function()
            table.clear(vu55)
            local v88 = GetClosestBreakables()
            local v89 = PlayerPets()
            local v90 = math.floor(# v89 / # v88)
            local v91 = # v89 % # v88
            local v92, v93, v94 = pairs(v88)
            local v95 = 1
            while true do
                local v96
                v94, v96 = v92(v93, v94)
                if v94 == nil then
                    break
                end
                local v97
                if v94 <= v91 then
                    v97 = v90 + 1
                else
                    v97 = v90
                end
                for _ = 1, v97 do
                    vu55[v89[v95].euid] = v96
                    v95 = v95 + 1
                end
            end
            local v98 = {
                vu55
            }
            vu51.Fire("Breakables_JoinPetBulk", unpack(v98))
        end,
        FastFarm2 = function()
            table.clear(vu55)
            local v99 = GetClosestBreakables()
            local v100 = PlayerPets()
            local v101, v102, v103 = pairs(v100)
            while true do
                local v104
                v103, v104 = v101(v102, v103)
                if v103 == nil then
                    break
                end
                local v105 = RandomCoinNumber(v99)
                vu55[v104.Name] = v105
            end
            local v106 = {
                vu55
            }
            vu51.Fire("Breakables_JoinPetBulk", unpack(v106))
        end,
        OpenClosestEgg = function()
            local v107 = require(game:GetService("ReplicatedStorage").Library.Client.EggCmds).GetMaxHatch()
            local v108, v109 = FindClosestCustomEgg()
            local v110, v111 = FindClosestEgg()
            if v111 and v109 then
                if v109 < v111 then
                    local v112 = {
                        tostring(v108),
                        v107
                    }
                    vu51.Invoke("CustomEggs_Hatch", unpack(v112))
                elseif v111 < v109 then
                    vu51.Invoke("Eggs_RequestPurchase", unpack({
                        v110,
                        v107
                    }))
                end
            end
        end,
        HugePetSpeed = function()
            function vu56.CalculateSpeedMultiplier()
                return math.huge
            end
        end,
        HideEggAnimation = function()
            function vu57.PlayEggAnimation()
            end
        end,
        HookEggAnimation = function()
            vu57.PlayEggAnimation = getgenv().v_settings.functionsValues.EggAnimation
            function vu57.PlayEggAnimation(p113)
                local v114 = require(game:GetService("ReplicatedStorage").Library.Client.EggCmds)
                vu58.Message.Bottom({
                    Message = "Still Openin " .. p113 .. " " .. tostring(v114.GetMaxHatch()),
                    Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                })
            end
        end,
        CombinePetCards = function(_)
            local v115 = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory
            if not v115.Card then
                print("Don\'t have any cards")
                return "Don\'t have any cards"
            end
            local v116 = v115.Card
            local function vu119(p117)
                local v118 = p117 / 3
                if v118 % 1 ~= 0 then
                    local _ = p117 - 1
                end
                return v118
            end
            local v120, v121, v122 = pairs(v116)
            local v123 = vu119
            local v124 = {}
            while true do
                local v125
                v122, v125 = v120(v121, v122)
                if v122 == nil then
                    break
                end
                local v126 = v125._am or 1
                if v126 >= 3 then
                    v124[v122] = v123(v126)
                end
            end
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CardCombinationMachine_ActivateBulk"):InvokeServer(unpack({
                v124
            }))
        end
    }
}
local vu127 = require(game:GetService("ReplicatedStorage").Library.Directory).Zones
local vu128 = require(game:GetService("ReplicatedStorage").Library.Types.Quests).Goals
local vu129 = {}
local _ = getgenv().VRT.Lib.RaidCmds
local _ = getgenv().VRT.Lib.RaidInstance
local _ = getgenv().VRT.Lib.InstancingCmds
local vu342 = {
    BuyNextZone = function(p130)
        local v131 = getgenv().VRT.Lib.Save.Get().ZoneGateQuest
        local v132 = getcurrency()
        local _, v133 = p130.ZoneUtil:GetMaxOwnedZone()
        local v134 = p130.ZoneUtil:GetMaxZoneNumber()
        local v135, v136 = getgenv().VRT.Lib.ZoneCmds.GetNextZone()
        if v133.ZoneNumber ~= v134 then
            if require(game:GetService("ReplicatedStorage").Library.Balancing.CalcGatePrice)(v136) <= v132 then
                getgenv().VRT.Lib.Network.Invoke("Zones_RequestPurchase", v135)
            else
                p130:TeleportToBestZone()
            end
            if v133.ZoneNumber == v134 or not v131 then
                p130:TeleportToBestZone()
            else
                setthreadidentity(4)
                p130:MakeGateQuest()
            end
            if p130:CanRebirth() then
                local _ = p130.Rebirth
            end
        else
            p130:TeleportToBestZone()
        end
    end,
    BuyPetSlots = function(_)
        local v137 = getgenv().VRT.Lib.Save.Get().PetSlotsPurchased
        local v138 = require(game:GetService("ReplicatedStorage").Library.Client.PetEquipCmds).GetStatus(v137 + 1)
        if v138 == "UNLOCKED" or v138 == "NEXT" then
            local _ = getgenv().VRT.Lib.Network.Invoke
            local _ = v137 + 1
        end
    end,
    ActivateFlag = function(p139)
        local v140 = getgenv().v_settings.functionToggles.SelectedFlag
        if v140 then
            local v141 = getgenv().v_settings.functionToggles.FlagAmount or 1
            local v142 = getgenv().VRT.Lib.FlexibleFlagCmds
            local v143 = getupvalue(v142.GetActiveFlag, 3)
            local v144 = getgenv().VRT.Lib.MapCmds
            local v145 = v144.GetCurrentInstanceInfo()
            if v145 then
                local v146, v147 = p139.FlagUtil:getFlag(v140)
                if not v146 then
                    print("No Flag in Inventory")
                    return "No Flag in Inventory"
                end
                local v148 = v147._am or 1
                if v148 < v141 then
                    v141 = v148
                end
                p139.FlagUtil:computeMaxFlags()
                local v149 = not v143["2!" .. v145.InstanceId .. "!" .. v145.AreaId] and 0 or p139.FlagUtil:flagPlaced(v143["2!" .. v145.InstanceId .. "!" .. v145.AreaId].Model)
                if tonumber(v149) < v141 then
                    local v150 = tonumber(v141 - v149)
                    getgenv().VRT.Lib.FlexibleFlagCmds.Consume(v140, v146, v150)
                end
            else
                local v151 = v144.GetCurrentZone()
                local v152, v153 = p139.FlagUtil:getFlag(v140)
                if not v152 then
                    print("No Flag in Inventory")
                    return "No Flag in Inventory"
                end
                local v154 = v153._am or 1
                if v154 < v141 then
                    v141 = v154
                end
                p139.FlagUtil:computeMaxFlags()
                local v155 = not v143["1!" .. v151 .. "!Main"] and 0 or p139.FlagUtil:flagPlaced(v143["1!" .. v151 .. "!Main"].Model)
                if tonumber(v155) < v141 then
                    local v156 = tonumber(v141 - v155)
                    getgenv().VRT.Lib.FlexibleFlagCmds.Consume(v140, v152, v156)
                end
            end
        end
    end,
    PutPetsInDaycare = function(p157)
        local v158, _, _ = p157.DaycareUtil:FetchPetsForDaycare()
        if v158 then
            local v159 = getgenv().VRT.Lib.DaycareCmds
            local v160 = 0
            local v161, v162, v163 = pairs(v158)
            local v164, _ = v161(v162, v163)
            if v164 ~= nil then
                v160 = v160 + 1
            end
            if v160 > 0 then
                v159.Enroll(v158)
            end
        end
    end,
    ClaimFreeGifts = function(_)
        local v165 = require(game.ReplicatedStorage.Library.Directory.FreeGifts)
        local v166 = getgenv().VRT.Lib.Save.Get()
        local v167 = v166.FreeGiftsRedeemed
        local v168 = v166.FreeGiftsTime
        local v169, v170, v171 = pairs(v165)
        while true do
            local v172
            v171, v172 = v169(v170, v171)
            if v171 == nil then
                break
            end
            if v172.WaitTime >= v168 then
                return
            end
            if not table.find(v167, v172._id) then
                return getgenv().VRT.Lib.Network.Invoke("Redeem Free Gift", v172._id) and true or false
            end
        end
    end,
    ActivateUltimate = function(_)
        local v173 = getgenv().VRT.Lib.UltimateCmds.GetEquippedItem()
        if v173 then
            return getgenv().VRT.Lib.UltimateCmds.Activate(v173._data.id)
        end
    end,
    TeleportToBestZone = function(p174)
        local _, v175 = p174.ZoneUtil:GetMaxOwnedZone()
        local v176 = v175.ZoneFolder
        if not (v176 and v176:FindFirstChild("PERSISTENT")) then
            local _, v177 = p174.ZoneUtil:GetZoneFromNumber(v175.ZoneNumber - 1)
            v176 = v177.ZoneFolder
        end
        local v178 = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v176.PERSISTENT.Teleport.Position).Magnitude
        if v176:FindFirstChild("INTERACT") then
            if v176.INTERACT.BREAKABLE_SPAWNS:FindFirstChild("Main") then
                v178 = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v176.INTERACT.BREAKABLE_SPAWNS.Main.Position).Magnitude
            else
                v178 = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v176.INTERACT.BREAKABLE_SPAWNS:GetChildren()[1].Position).Magnitude
            end
        end
        if v178 >= 20 then
            while not v176:FindFirstChild("INTERACT") do
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v176.PERSISTENT.Teleport.CFrame
                wait(0.05)
            end
            local v179
            if v176.INTERACT.BREAKABLE_SPAWNS:FindFirstChild("Main") then
                v179 = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v176.INTERACT.BREAKABLE_SPAWNS.Main.Position).Magnitude
            else
                v179 = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v176.INTERACT.BREAKABLE_SPAWNS:GetChildren()[1].Position).Magnitude
            end
            if v179 >= 20 then
                if v176.INTERACT.BREAKABLE_SPAWNS:FindFirstChild("Main") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v176:FindFirstChild("INTERACT"):FindFirstChild("BREAKABLE_SPAWNS"):FindFirstChild("Main").CFrame
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v176:FindFirstChild("INTERACT"):FindFirstChild("BREAKABLE_SPAWNS"):GetChildren()[1].CFrame
                end
            end
        end
    end,
    TeleportToAnotherWorld = function(p180)
        local _, v181 = getgenv().VRT.Lib.ZoneCmds.GetNextZone()
        local v182 = p180.WorldUtil:GetWorld()
        if v181.WorldNumber ~= v182.WorldNumber then
            local _ = getgenv().VRT.Lib.Network.Invoke
            local _ = "World" .. v181.WorldNumber .. "Teleport"
        end
    end,
    CanRebirth = function(p183)
        local _, v184 = p183.ZoneUtil:GetMaxOwnedZone()
        local v185 = getgenv().VRT.Lib.RebirthCmds.GetNextRebirth()
        if v185 then
            return v184.ZoneNumber >= v185.ZoneNumberRequired
        else
            return false
        end
    end,
    Rebirth = function(_)
        return getgenv().VRT.Lib.RebirthCmds.Rebirth(tostring(getgenv().VRT.Lib.RebirthCmds.GetNextRebirth().RebirthNumber))
    end,
    QuestName = function(_, p186)
        local v187, v188, v189 = pairs(vu128)
        while true do
            local v190
            v189, v190 = v187(v188, v189)
            if v189 == nil then
                break
            end
            if p186 == v190 then
                return v189
            end
        end
        return nil
    end,
    MakeGateQuest = function(p191)
        require(game:GetService("ReplicatedStorage").Library.Items.MiscItem)("Supercomputer Radio"):HasAny()
        local v192 = getgenv().VRT.Lib.Save.Get()
        local v193 = p191.WorldUtil:GetWorld()
        local _ = v193.MapName
        local v194 = v193.WorldNumber
        local v195 = v192.ZoneGateQuest
        local v196 = v195.Progress
        local v197 = v195.Type
        local v198 = v195.Amount
        local v199 = p191:QuestName(v197)
        print(v199, v197, v196, v198)
        if v199 == "BEST_EGG" and v196 < v198 then
            local v200 = getgenv().VRT.Lib.EggCmds.GetMaxHatch()
            local v201 = v192.MaximumAvailableEgg
            local v202 = workspace:FindFirstChild("__THINGS"):FindFirstChild("Eggs"):FindFirstChild("World" .. v194)
            local v203, v204, v205 = pairs(require(game:GetService("ReplicatedStorage").Library.Directory.Eggs))
            local v206 = nil
            local v207 = nil
            while true do
                local v208
                v205, v208 = v203(v204, v205)
                if v205 == nil then
                    break
                end
                if v208.eggNumber == v201 then
                    v206 = v208
                end
            end
            local v209 = getcurrency()
            local v210 = require(game:GetService("ReplicatedStorage").Library.Balancing.CalcEggPricePlayer)(v206) * v200
            print(v209, v210, v210 * math.round((v198 - v196) / v200))
            if v209 < v210 * math.round((v198 - v196) / v200) then
                p191:TeleportToBestZone()
                return
            end
            local v211, v212, v213 = pairs(v202:GetChildren())
            while true do
                local v214
                v213, v214 = v211(v212, v213)
                if v213 == nil then
                    break
                end
                if v214.Name:split(" ")[1] == tostring(v201) then
                    v207 = v214
                end
            end
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v207.Tier.Position).Magnitude >= 25 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v207.Tier.CFrame
            end
            getgenv().VRT.Lib.Network.Invoke("Eggs_RequestPurchase", v206._id, v200)
        elseif v199 == "BREAKABLE" and v196 < v198 then
            p191:TeleportToBestZone()
        elseif v199 == "BEST_COIN_JAR" and v196 < v198 then
            p191:TeleportToBestZone()
            local v215 = v192.Inventory.Misc
            local v216, v217, v218 = pairs(v215)
            while true do
                local v219
                v218, v219 = v216(v217, v218)
                if v218 == nil then
                    break
                end
                if v219.id == "Basic Coin Jar" then
                    local _ = v219._am
                    getgenv().VRT.Lib.Network.Invoke("CoinJar_Spawn", v218)
                end
            end
        elseif v199 == "BEST_COMET" and v196 < v198 then
            p191:TeleportToBestZone()
            local v220 = v192.Inventory.Misc
            local v221, v222, v223 = pairs(v220)
            while true do
                local v224
                v223, v224 = v221(v222, v223)
                if v223 == nil then
                    break
                end
                if v224.id == "Comet" then
                    local _ = v224._am
                    getgenv().VRT.Lib.Network.Invoke("Comet_Spawn", v223)
                end
            end
        elseif v199 == "BEST_GOLD_PET" and v196 < v198 then
            local v225 = getcurrency()
            local v226 = getgenv().VRT.Lib.EggCmds.GetMaxHatch()
            local v227 = getgenv().VRT.Lib.MasteryCmds
            local v228 = v192.Inventory.Pet
            local v229 = v192.MaximumAvailableEgg
            local v230 = 0
            if v227.HasPerk("Pets", "GoldReduction") then
                v230 = v230 + v227.GetPerkPower("Pets", "GoldReduction")
            end
            local v231 = v198 - v196
            local v232 = v231 + 1
            local v233 = (v231 + 1) * (10 - v230)
            local v234 = workspace:FindFirstChild("__THINGS"):FindFirstChild("Eggs"):FindFirstChild("World" .. v194)
            local v235, v236, v237 = pairs(require(game:GetService("ReplicatedStorage").Library.Directory.Eggs))
            local v238 = nil
            local v239 = nil
            while true do
                local v240
                v237, v240 = v235(v236, v237)
                if v237 == nil then
                    break
                end
                if v240.eggNumber == v229 then
                    v238 = v240
                end
            end
            local v241, v242, v243 = pairs(v234:GetChildren())
            while true do
                local v244
                v243, v244 = v241(v242, v243)
                if v243 == nil then
                    break
                end
                if v244.Name:split(" ")[1] == tostring(v229) then
                    v239 = v244
                end
            end
            local v245 = require(game:GetService("ReplicatedStorage").Library.Balancing.CalcEggPricePlayer)(v238) * v226
            local v246, v247, v248 = pairs(v238.pets)
            local v249 = {}
            while true do
                local v250
                v248, v250 = v246(v247, v248)
                if v248 == nil then
                    break
                end
                table.insert(v249, v250[1])
            end
            local v251, v252, v253 = pairs(v228)
            local v254 = false
            while true do
                local v255
                v253, v255 = v251(v252, v253)
                if v253 == nil then
                    break
                end
                if table.find(v249, v255.id) then
                    local v256 = v255._am or 1
                    local v257 = v255.pt or 0
                    if v233 <= v256 and v257 == 0 then
                        print(v255.id, v256, v233, v257)
                        local v258, v259 = getgenv().VRT.Lib.Network.Invoke("GoldMachine_Activate", unpack({
                            v253,
                            v232
                        }))
                        print("Should Convert", v258, v259)
                        v254 = true
                    end
                end
            end
            if not v254 then
                if v225 <= v245 then
                    p191:TeleportToBestZone()
                    return
                end
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v239.Tier.Position).Magnitude >= 25 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v239.Tier.CFrame
                end
                getgenv().VRT.Lib.Network.Invoke("Eggs_RequestPurchase", v238._id, v226)
            end
        elseif v199 == "BEST_RAINBOW_PET" and v196 < v198 then
            local v260 = getcurrency()
            local v261 = getgenv().VRT.Lib.EggCmds.GetMaxHatch()
            local v262 = getgenv().VRT.Lib.MasteryCmds
            local v263 = v192.Inventory.Pet
            local v264 = v192.MaximumAvailableEgg
            local v265 = 0
            if v262.HasPerk("Pets", "GoldReduction") then
                v265 = v265 + v262.GetPerkPower("Pets", "GoldReduction")
            end
            local v266 = v198 - v196
            local v267 = v266 + 1
            local _ = v266 * 10 + 1
            local v268 = (v266 + 1) * (10 - v265)
            local v269 = workspace:FindFirstChild("__THINGS"):FindFirstChild("Eggs"):FindFirstChild("World" .. v194)
            local v270, v271, v272 = pairs(require(game:GetService("ReplicatedStorage").Library.Directory.Eggs))
            local v273 = nil
            local v274 = nil
            while true do
                local v275
                v272, v275 = v270(v271, v272)
                if v272 == nil then
                    break
                end
                if v275.eggNumber == v264 then
                    v273 = v275
                end
            end
            local v276, v277, v278 = pairs(v269:GetChildren())
            while true do
                local v279
                v278, v279 = v276(v277, v278)
                if v278 == nil then
                    break
                end
                if v279.Name:split(" ")[1] == tostring(v264) then
                    v274 = v279
                end
            end
            local v280 = require(game:GetService("ReplicatedStorage").Library.Balancing.CalcEggPricePlayer)(v273) * v261
            local v281, v282, v283 = pairs(v273.pets)
            local v284 = {}
            while true do
                local v285
                v283, v285 = v281(v282, v283)
                if v283 == nil then
                    break
                end
                table.insert(v284, v285[1])
            end
            local v286, v287, v288 = pairs(v263)
            local v289 = 0
            local v290 = false
            local v291 = false
            while true do
                local v292
                v288, v292 = v286(v287, v288)
                if v288 == nil then
                    break
                end
                if table.find(v284, v292.id) then
                    local v293 = v292._am or 1
                    local v294 = v292.pt or 0
                    if v289 <= v293 and v294 == 1 then
                        v289 = v266 * 10 - v293 + 10
                    end
                    if v268 <= v293 and v294 == 1 then
                        print(v292.id, v293, v268, v294)
                        local v295, v296 = getgenv().VRT.Lib.Network.Invoke("RainbowMachine_Activate", unpack({
                            v288,
                            v267
                        }))
                        print("Should Convert", v295, v296)
                        v290 = true
                    end
                end
            end
            if v289 == 0 then
                v289 = v266 * 10 + 10
            end
            print("Goldens:", v289, "Normals:", v289 * (10 - v265))
            if not v290 then
                local v297, v298, v299 = pairs(v263)
                while true do
                    local v300
                    v299, v300 = v297(v298, v299)
                    if v299 == nil then
                        break
                    end
                    if table.find(v284, v300.id) then
                        local v301 = v300._am or 1
                        local v302 = v300.pt or 0
                        if v289 * (10 - v265) <= v301 and v302 == 0 then
                            print(v300.id, v301, v289 * 10, v302)
                            local v303, v304 = getgenv().VRT.Lib.Network.Invoke("GoldMachine_Activate", unpack({
                                v299,
                                v289
                            }))
                            print("Should Convert", v303, v304)
                            v291 = true
                        end
                    end
                end
            end
            if not (v290 or v291) then
                if v260 <= v280 then
                    p191:TeleportToBestZone()
                    return
                end
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v274.Tier.Position).Magnitude >= 25 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v274.Tier.CFrame
                end
                getgenv().VRT.Lib.Network.Invoke("Eggs_RequestPurchase", v273._id, v261)
            end
        end
    end,
    GetMachines = function(p305)
        table.clear(vu129)
        local v306 = p305.WorldUtil:GetWorld()
        if workspace:FindFirstChild(v306.MapName) then
            local v307, v308, v309 = pairs(workspace:FindFirstChild(v306.MapName):GetDescendants())
            while true do
                local v310
                v309, v310 = v307(v308, v309)
                if v309 == nil then
                    break
                end
                if v310.Name:match("Machines") and v310.Name:match("Machine") then
                    print(v309, v310)
                    vu129[v310.Name] = v310.Arrow.CFrame
                end
            end
        end
    end,
    WorldUtil = {
        GetWorld = function(_)
            local v311 = vu36[game.PlaceId]
            return require(game.ReplicatedStorage.Library.Directory.Worlds)[v311]
        end,
        GetWorldByNumber = function(_, p312)
            return require(game.ReplicatedStorage.Library.Directory.Worlds)["World " .. p312]
        end
    },
    FlagUtil = {
        computeMaxFlags = function(_)
            local v313 = getgenv().VRT.Lib.MasteryCmds
            return not v313.HasPerk("Breakables", "FlagSlots") and 24 or 24 + v313.GetPerkPower("Breakables", "FlagSlots")
        end,
        computeDuration = function(_, p314)
            local v315 = getgenv().VRT.Lib.MasteryCmds
            if not v315.HasPerk("Breakables", "FlagDuration") then
                return p314.Duration
            end
            local v316 = p314.Duration * v315.GetPerkPower("Breakables", "FlagDuration")
            return math.ceil(v316)
        end,
        flagPlaced = function(_, p317)
            return p317 and ((not p317:FindFirstChild("FlagPole"):FindFirstChild("Attachment"):FindFirstChild("ZoneFlag"):FindFirstChild("Title") and "" or p317:FindFirstChild("FlagPole"):FindFirstChild("Attachment"):FindFirstChild("ZoneFlag"):FindFirstChild("Title").Text):match("%d+") or 1) or 0
        end,
        getFlag = function(_, p318)
            local v319 = getgenv().VRT.Lib.Save.Get().Inventory.Misc
            local v320, v321, v322 = pairs(v319)
            while true do
                local v323
                v322, v323 = v320(v321, v322)
                if v322 == nil then
                    break
                end
                if v323.id == p318 then
                    return v322, v323
                end
            end
            return nil
        end
    },
    DaycareUtil = {},
    ZoneUtil = {
        GetZoneFromNumber = function(_, p324)
            local v325, v326, v327 = pairs(vu127)
            while true do
                local v328
                v327, v328 = v325(v326, v327)
                if v327 == nil then
                    break
                end
                if v328.ZoneNumber == p324 then
                    return v327, v328
                end
            end
        end,
        GetMaxZoneNumber = function(_)
            local v329, v330, v331 = pairs(require(game:GetService("ReplicatedStorage").Library.Directory.Zones))
            local v332 = 0
            while true do
                local v333
                v331, v333 = v329(v330, v331)
                if v331 == nil then
                    break
                end
                if v332 <= v333.ZoneNumber then
                    v332 = v333.ZoneNumber
                end
            end
            return v332
        end,
        GetMaxOwnedZone = function(p334)
            local v335, v336 = p334:GetZoneFromNumber(1)
            local v337 = getgenv().VRT.Lib.Save.Get().UnlockedZones
            if not v337 then
                return v335, v336
            end
            local v338, v339, v340 = pairs(v337)
            while true do
                v340 = v338(v339, v340)
                if v340 == nil then
                    break
                end
                local v341 = vu127[v340]
                if v341.ZoneNumber > v336.ZoneNumber then
                    v335 = v340
                    v336 = v341
                end
            end
            return v335, v336
        end
    }
}
tick()
local v343, v344, v345 = pairs(game:GetService("ReplicatedStorage").Library.Directory:GetChildren())
local vu346 = vu57
local vu347 = vu128
local vu348 = vu47
local vu349 = vu56
local vu350 = vu51
local vu351 = {}
while true do
    local v352, v353 = v343(v344, v345)
    if v352 == nil then
        break
    end
    v345 = v352
    if v353:IsA("ModuleScript") and v353.Name ~= "DropTables" then
        local v354, v355, v356 = pairs(require(v353))
        while true do
            local v357
            v356, v357 = v354(v355, v356)
            if v356 == nil then
                break
            end
            table.insert(vu351, v357)
        end
    end
end
local function vu364(pu358)
    local v359, v360, vu361 = pairs(getmetatable(vu52).__index)
    while true do
        local v362
        vu361, v362 = v359(v360, vu361)
        if vu361 == nil then
            break
        end
        local v363, _ = pcall(function()
            return vu52[vu361](pu358)
        end)
        if v363 then
            return vu361
        end
    end
    return nil
end
local function vu370(p365)
    local v366, v367, v368 = pairs(vu351)
    while true do
        local v369
        v368, v369 = v366(v367, v368)
        if v368 == nil then
            break
        end
        if v369._id == p365 then
            return p365
        end
    end
    return nil
end
local function vu380(p371)
    local v372, v373, v374 = pairs(require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory)
    while true do
        local v375
        v374, v375 = v372(v373, v374)
        if v374 == nil then
            break
        end
        local v376, v377, v378 = pairs(v375)
        while true do
            local v379
            v378, v379 = v376(v377, v378)
            if v378 == nil then
                break
            end
            if v379.id == p371 then
                return v378, v379
            end
        end
    end
    return nil
end
local function vu390()
    if getgenv().v_settings.functionToggles.MailboxUsername ~= "" then
        local v381, v382, v383 = pairs(getgenv().v_settings.functionToggles.MailboxItems)
        while true do
            local v384
            v383, v384 = v381(v382, v383)
            if v383 == nil then
                break
            end
            if not vu370(v383) then
                warn("CheckIfExists Error Send screenshot")
                return
            end
            local v385, v386 = vu380(v383)
            if v385 and v386 then
                local v387 = vu364(v383)
                if not v387 then
                    warn("GetItemType Error Send screenshot")
                    return
                end
                local v388 = vu52[v387]:From(v386)
                if v384 <= (v388._data._am or 0) then
                    local v389 = "VRT " .. vu24(8)
                    warn("Sending Mailbox to:", getgenv().v_settings.functionToggles.MailboxUsername:lower(), "\n", "With Description:", v389, "\n", "Item:", v383, "\n", "Amount:", v388._data._am, "\n")
                    vu350.Invoke("Mailbox: Send", getgenv().v_settings.functionToggles.MailboxUsername:lower(), v389, v387, v385, v388._data._am or 1)
                end
            end
        end
    end
end
local function vu405(p391, p392)
    if getgenv().v_settings.functionToggles.MailboxUsername ~= "" then
        local v393 = require(game.ReplicatedStorage.Library.Client.Save).Get()
        local v394 = getgenv().v_settings.functionToggles.MailboxSendHugesType or ""
        if v394 == "" then
            return
        elseif not p391 or (not p392 or v394 == "New") then
            if v394 == "All" then
                local v395, v396, v397 = pairs(v393.Inventory.Pet)
                while true do
                    local v398
                    v397, v398 = v395(v396, v397)
                    if v397 == nil then
                        break
                    end
                    if v398.id:match("Huge") then
                        if not vu370(v398.id) then
                            warn("CheckIfExists Error Send screenshot")
                            return
                        end
                        local v399, v400 = vu380(v398.id)
                        if v399 and v400 then
                            local v401 = vu364(v398.id)
                            if not v401 then
                                warn("GetItemType Error Send screenshot")
                                return
                            end
                            local v402 = vu52[v401]:From(v398)
                            local v403 = "VRT " .. vu24(8)
                            warn("Sending Mailbox to:", getgenv().v_settings.functionToggles.MailboxUsername:lower(), "\n", "With Description:", v403, "\n", "Item:", v398.id, "\n", "Amount:", v402._data._am or 1, "\n")
                            vu350.Invoke("Mailbox: Send", getgenv().v_settings.functionToggles.MailboxUsername:lower(), v403, v401, v399, v402._data._am or 1)
                        end
                    end
                end
            elseif v394 == "New" then
                local v404 = "VRT " .. vu24(8)
                warn("Sending Mailbox to:", getgenv().v_settings.functionToggles.MailboxUsername:lower(), "\n", "With Description:", v404, "\n", "Item:", p392.id, "\n", "Amount:", p392._am or 1, "\n")
                vu350.Invoke("Mailbox: Send", getgenv().v_settings.functionToggles.MailboxUsername:lower(), v404, "Pet", p391, p392._am or 1)
            end
        end
    else
        return
    end
end
local function vu409()
    local v406 = getgenv().v_settings.functionToggles.InputedMailboxItem
    local v407 = getgenv().v_settings.functionToggles.InputedMailboxAmount
    local v408 = getgenv().v_settings.functionToggles.MailboxItems
    if v406 ~= "" and (v407 ~= 0 and v408) then
        if not vu370(v406) then
            return false
        end
        getgenv().v_settings.functionToggles.MailboxItems[v406] = v407
        return true
    end
end
local function vu413(_)
    local v410 = getgenv().v_settings.functionToggles.InputedMailboxItem
    local v411 = getgenv().v_settings.functionToggles.InputedMailboxAmount
    local v412 = getgenv().v_settings.functionToggles.MailboxItems
    if v410 ~= "" and (v411 ~= 0 and v412) then
        if not vu370(v410) then
            return nil
        end
        getgenv().v_settings.functionToggles.MailboxItems[v410] = nil
    end
end
local function vu414()
    vu350.Invoke("Mailbox: Claim All")
end
local vu415 = require(game.ReplicatedStorage.Library.Client.DaycareCmds)
local vu416 = require(game:GetService("ReplicatedStorage").Library.Modules.DaycareLoot)
require(game.ReplicatedStorage.Library.Client.Save).Get()
local vu417 = require(game.ReplicatedStorage.Library.Items.PetItem)
local vu418 = require(game.ReplicatedStorage.Library.Client.Save)
function FetchPetsForDaycare()
    local v419 = vu418.Get()
    if v419 then
        local v420 = v419.Inventory.Pet
        local v421 = vu415.GetMaxSlots() - vu415.GetUsedSlots()
        if v421 <= 0 then
            local v422 = v419.DaycareActive
            local v423, v424, v425 = pairs(v422)
            while true do
                local v426
                v425, v426 = v423(v424, v425)
                if v425 == nil then
                    break
                end
                if vu415.ComputeRemainingTime(v425, workspace:GetServerTimeNow()) == 0 then
                    local v427 = vu415.Claim(v425)
                    if v427 then
                        return nil, "Successfully claimed daycare pet: " .. v426.Pet.id, v427
                    else
                        return nil, "Failed To claim daycare pet: " .. v426.Pet.id, v427
                    end
                end
            end
            return nil, "All Daycare Slots taken"
        end
        local v428 = v421 * 10
        local v429, v430, v431 = pairs(v420)
        local v432 = 0
        local v433 = {}
        while true do
            local v434
            v431, v434 = v429(v430, v431)
            if v431 == nil then
                break
            end
            local v435 = vu417(v434.id)
            if v435:GetExclusiveLevel() < 4 and (v434._am or 1) >= 10 then
                if v432 >= v428 then
                    return v433
                end
                setthreadidentity(4)
                local _, v436 = vu416.ComputePetLootPool(game.Players.LocalPlayer, v435)
                if v436 * 10 == 10 and v428 <= v434._am then
                    local v437 = math.min(v434._am, v428 - v428 % 10)
                    if v437 > 0 then
                        v433[v431] = v437 / 10
                        v432 = v432 + v437
                    end
                end
            end
        end
        return v433
    end
end
function PutPetsInDaycare()
    local v438, _, _ = FetchPetsForDaycare()
    if v438 then
        local v439 = 0
        local v440, v441, v442 = pairs(v438)
        local v443, _ = v440(v441, v442)
        if v443 ~= nil then
            v439 = v439 + 1
        end
        if v439 > 0 then
            local v444, v445 = vu415.Enroll(v438)
            if v444 then
                print("Successfully Enrolled Pet Table:", v445, v438)
            else
                print("Failed to Enroll Pet Table:", v445, v438)
            end
        end
    end
end
local vu446 = {}
local vu447 = false
local vu448 = {}
function GetThumbnailUrl(p449)
    local v450 = {
        Url = "https://thumbnails.roblox.com/v1/assets?assetIds=" .. tostring(p449) .. "&size=700x700&format=Png&isCircular=false",
        Method = "GET"
    }
    local v451 = request(v450)
    return game:GetService("HttpService"):JSONDecode(v451.Body).data[1].imageUrl
end
local function vu455(p452)
    local v453 = tostring(p452)
    repeat
        local v454
        v453, v454 = v453:gsub("^(%-?%d+)(%d%d%d)", "%1,%2")
        count = v454
    until count == 0
    return v453
end
function SendPublicHatch(_)
end
function SendHatch(p456)
    if table.find(vu448, game.Players.LocalPlayer.Name) then
        return
    else
        local v457 = getgenv().v_settings.functionToggles.DiscordWebhook
        local v458 = getgenv().v_settings.functionToggles.DiscordUserId or "1"
        local v459 = require(game.ReplicatedStorage.Library.Directory.Pets)
        local v460 = require(game.ReplicatedStorage.Library.Items).Pet:From(p456)
        local v461 = v460._data.id
        local _ = v460._data._am
        local v462 = v460._data.pt or 0
        local v463 = getgenv().VRT.Lib.RAPCmds.Get(v460) or "No Rap"
        local v464 = getgenv().VRT.Lib.ExistCountCmds.Get(v460) or "No Exist Count"
        local v465 = v462 == 1 and "Golden" or (v462 == 2 and "Rainbow" or "Normal")
        local v466
        if v465 == "Golden" then
            v466 = v459[v460._data.id].goldenThumbnail
        else
            v466 = v459[v460._data.id].thumbnail
        end
        local v467 = GetThumbnailUrl(v466:match("%d+"))
        local v468 = vu455(v463)
        local v469 = vu455(v464)
        local v470 = v465 == "Rainbow" and 16737996 or 30893
        local v471 = {
            username = "VRT Hatch Notifier",
            content = "<@" .. v458 .. ">",
            embeds = {
                {
                    color = v470,
                    thumbnail = {
                        url = v467
                    },
                    fields = {
                        {
                            name = "Hatched a " .. v465 .. " " .. v461 .. "!",
                            value = utf8.char(128160) .. " **Rap Value: `" .. v468 .. "`**\n" .. utf8.char(127757) .. " **Exist Count: `" .. v469 .. "`**"
                        },
                        {
                            name = "**Account Info:**",
                            value = "**Account Name:** ||" .. game.Players.LocalPlayer.Name .. "||"
                        }
                    }
                }
            }
        }
        if getgenv().v_settings.functionToggles.SendWebhook then
            if v457 then
                request({
                    Url = v457,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game.HttpService:JSONEncode(v471)
                })
            end
        else
            return
        end
    end
end
local vu472 = 0
local vu473 = 0
function CheckPets()
    local v474 = getgenv().VRT.Lib.Save.Get()
    local v475, v476, v477 = pairs(v474.Inventory.Pet)
    local v478 = {}
    while true do
        local v479
        v477, v479 = v475(v476, v477)
        if v477 == nil then
            break
        end
        if v479.id:match("Huge") or v479.id:match("Titanic") then
            v478[v477] = v479
        end
    end
    local v480, v481, v482 = pairs(v478)
    while true do
        local v483
        v482, v483 = v480(v481, v482)
        if v482 == nil then
            break
        end
        if not vu446[v482] and vu447 then
            if v483.id:match("Huge") then
                vu472 = vu472 + 1
            elseif v483.id:match("Titanic") then
                vu473 = vu473 + 1
            end
            SendHatch(v483)
            vu405(v482, v483)
        end
    end
    vu447 = true
    vu446 = v478
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
local vu484 = require(game:GetService("ReplicatedStorage").Library.Client.FruitCmds)
local vu485 = require(game.ReplicatedStorage.Library.Client.Save)
local function vu490(p486, p487)
    local v488 = p487 and "Shiny" or "Normal"
    if not vu484.GetActiveFruits()[p486] then
        return vu484.ComputeFruitQueueLimit()
    end
    local v489 = vu484.GetActiveFruits()[p486][v488]
    return vu484.ComputeFruitQueueLimit() - # v489
end
local function vu498(p491, p492)
    local v493 = vu485.Get().Inventory.Fruit
    local v494, v495, v496 = pairs(v493)
    while true do
        local v497
        v496, v497 = v494(v495, v496)
        if v496 == nil then
            break
        end
        if v497.id == p491 and (p492 and v497.sh or not p492) then
            return v496, v497
        end
    end
    return nil
end
local function v509()
    local v499 = getgenv().v_settings.functionToggles.SelectedFruits
    if v499 then
        local v500, v501, v502 = pairs(v499)
        while true do
            local v503
            v502, v503 = v500(v501, v502)
            if v502 == nil then
                break
            end
            local v504 = v503:split(" ")[1] == "Shiny" and true or false
            local v505, v506 = vu498(v503, v504)
            local v507 = vu490(v503, v504)
            local v508 = (v506._am or 1) < v507 and (v506._am or 1) or v507
            vu350.Fire("Fruits: Consume", v505, v508)
            wait(1)
        end
    end
end
local vu510 = require(game:GetService("ReplicatedStorage").Library.Client.LootboxCmds)
local function v520()
    local v511 = getgenv().v_settings.functionToggles.SelectedLootboxes
    if # v511 ~= 0 then
        local v512, v513, v514 = pairs(v511)
        while true do
            local v515
            v514, v515 = v512(v513, v514)
            if v514 == nil then
                break
            end
            local v516, v517 = vu380(v515)
            if v516 and v517 then
                local v518 = (v517._am or 1) > 8 and 8 or (v517._am or 1)
                local v519 = vu52.Lootbox(v515)
                v519._uid = v516
                vu510.Open(v519, v518)
            end
        end
    end
end
local function v529()
    local v521 = getgenv().v_settings.functionToggles.SelectedGifts
    if # v521 ~= 0 then
        local v522, v523, v524 = pairs(v521)
        while true do
            local v525
            v524, v525 = v522(v523, v524)
            if v524 == nil then
                break
            end
            local v526, v527 = vu380(v525)
            if v526 and v527 then
                local v528 = (v527._am or 1) > 100 and 100 or (v527._am or 1)
                vu350.Invoke("GiftBag_Open", v525, v528)
            end
        end
    end
end
local vu530 = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("Scripts"):WaitForChild("Game"):WaitForChild("Misc"):WaitForChild("Shiny Relics"))
local vu531 = require(game.ReplicatedStorage.Library.Client.NotificationCmds)
local function vu532()
    return # getgenv().VRT.Lib.Save.Get().ShinyRelics
end
local function vu535()
    local vu533 = 0
    local v534 = getupvalue(vu530.SetupRelics, 7)
    table.foreach(v534, function()
        vu533 = vu533 + 1
    end)
    return vu533
end
local function vu538()
    repeat
        wait(0.5)
    until ShinyRelicsParagraph
    local v536 = vu532()
    local v537 = vu535()
    setthreadidentity(8)
    return ShinyRelicsParagraph:Set({
        Title = "Collected Relics",
        Content = "You Have Collected <font color=\'#2b94d4\'>" .. v536 .. "/" .. v537 .. "</font> Shiny Relics"
    })
end
task.spawn(function()
    while true do
        vu538()
        wait(5)
    end
end)
local function v544()
    local v539 = getupvalue(vu530.SetupRelics, 7)
    local v540, v541, v542 = pairs(v539)
    while true do
        local v543
        v542, v543 = v540(v541, v542)
        if v542 == nil then
            break
        end
        if not v543.Found and vu350.Invoke("Relic_Found", v543.Id) then
            v543.Found = true
            vu531.Message.Bottom({
                Message = string.format("Shiny Relic Discovered!   <font color=\"rgb(255,255,255)\">Collected %s/%s</font>", tostring(vu532()), tostring(vu535())),
                Color = Color3.fromRGB(255, 255, 0)
            })
        end
    end
    wait(2.5)
end
require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("UpgradeCmds"))
local vu545 = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Directory"):WaitForChild("Ranks"))
local function vu551()
    local v546 = getgenv().VRT.Lib.Save.Get().Rank
    local v547, v548, v549 = pairs(vu545)
    while true do
        local v550
        v549, v550 = v547(v548, v549)
        if v549 == nil then
            break
        end
        if v550.RankNumber == v546 then
            return v550
        end
    end
end
local function vu560()
    local v552 = getgenv().VRT.Lib.Save.Get()
    local v553 = vu551()
    local v554 = v552.RedeemedRankRewards
    local v555 = v553.Rewards
    local v556, v557, v558 = pairs(v555)
    while true do
        local v559
        v558, v559 = v556(v557, v558)
        if v558 == nil then
            break
        end
        if not v554[tostring(v558)] then
            return false
        end
    end
    return true
end
local function v569()
    if not vu560() then
        local v561 = getgenv().VRT.Lib.Save.Get()
        local v562 = v561.RankStars
        local v563 = v561.RedeemedRankRewards
        local v564 = vu551().Rewards
        local v565, v566, v567 = pairs(v564)
        while true do
            local v568
            v567, v568 = v565(v566, v567)
            if v567 == nil then
                break
            end
            if v568.StarsRequired > v562 then
                return "Can\'t afford"
            end
            v562 = v562 - v568.StarsRequired
            if not v563[tostring(v567)] then
                vu350.Fire("Ranks_ClaimReward", v567)
                wait(1)
            end
        end
    end
end
local vu570 = require(game:GetService("ReplicatedStorage").Library.Util.WorldsUtil)
local vu571 = game:GetService("ReplicatedStorage").__DIRECTORY.Eggs["Zone Eggs"][vu570.GetWorld()._id]
function FindClosestCustomEgg()
    if game.Players.LocalPlayer.Character then
        local v572 = game.Players.LocalPlayer.Character.HumanoidRootPart
        local v573 = workspace.__THINGS.CustomEggs
        local v574 = math.huge
        local v575, v576, v577 = pairs(v573:GetChildren())
        local v578 = nil
        while true do
            local v579
            v577, v579 = v575(v576, v577)
            if v577 == nil then
                break
            end
            if v579:IsA("Model") then
                local v580 = (v572.Position - v579.WorldPivot.Position).Magnitude
                if v580 < v574 then
                    v578 = v579
                    v574 = v580
                end
            end
        end
        return v578, v574
    end
end
function FindClosestEgg()
    local v581 = game.Players.LocalPlayer.Character.HumanoidRootPart
    local v582 = workspace.__THINGS.Eggs[vu570.GetEggsModelName()]
    local v583 = math.huge
    local v584, v585, v586 = pairs(v582:GetChildren())
    local v587 = nil
    while true do
        local v588
        v586, v588 = v584(v585, v586)
        if v586 == nil then
            break
        end
        if v588:IsA("Model") then
            local v589 = (v581.Position - v588:FindFirstChild("Light").CFrame.Position).Magnitude
            if v589 < v583 then
                v587 = v588
                v583 = v589
            end
        end
    end
    if not v587 then
        return
    end
    local v590 = string.split(v587.Name, " ")
    local v591 = vu571
    local v592, v593, v594 = pairs(v591:GetDescendants())
    local v595 = nil
    while true do
        local v596
        v594, v596 = v592(v593, v594)
        if v594 == nil then
            v596 = v595
            break
        end
        if v596.Name:match(v590[1]) then
            local v597 = string.split(v596.Name, " ")
            if v597[6] then
                v587 = v597[3] .. " " .. v597[4] .. " " .. v597[5] .. " " .. v597[6]
            elseif v597[5] then
                v587 = v597[3] .. " " .. v597[4] .. " " .. v597[5]
            else
                v587 = v597[3] .. " " .. v597[4]
            end
            break
        end
    end
    return v587, v583, v596
end
local function vu604()
    local v598 = require(game:GetService("ReplicatedStorage").Library.Client.EggCmds).GetMaxHatch()
    local v599, v600 = FindClosestCustomEgg()
    local v601, v602 = FindClosestEgg()
    if v602 and v600 then
        if v600 < v602 then
            local v603 = {
                tostring(v599),
                v598
            }
            vu350.Invoke("CustomEggs_Hatch", unpack(v603))
        elseif v602 < v600 then
            vu350.Invoke("Eggs_RequestPurchase", unpack({
                v601,
                v598
            }))
        end
    end
end
local vu605 = require(game:GetService("ReplicatedStorage").Library.Client.InstanceZoneCmds)
local vu606 = require(game.ReplicatedStorage.Library.Client.Network)
local function v610()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        return
    else
        local v607 = workspace.__THINGS.Instances:FindFirstChild("EasterEvent")
        if v607 then
            local v608 = v607:FindFirstChild("Teleports")
            if v608 then
                local v609 = v608:FindFirstChild("Enter")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v609.CFrame
            end
        else
            return
        end
    end
end
local function vu611()
    return vu605.GetMaximumOwnedZoneNumber()
end
local vu612 = require(game:GetService("ReplicatedStorage").Library.Types.Quests)
local function vu618(p613)
    local v614, v615, v616 = pairs(vu612.Goals)
    while true do
        local v617
        v616, v617 = v614(v615, v616)
        if v616 == nil then
            break
        end
        if v617 == p613 then
            return v616, v617
        end
    end
end
local function vu625(p619)
    local v620 = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Pet
    local v621, v622, v623 = pairs(v620)
    while true do
        local v624
        v623, v624 = v621(v622, v623)
        if v623 == nil then
            break
        end
        if (v624.pt or 0) == 0 and not v624.sh and (v624._am or 1) >= p619 * 11 then
            return v623, v624
        end
    end
    return nil
end
local function vu632(p626)
    local v627 = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Pet
    local v628, v629, v630 = pairs(v627)
    while true do
        local v631
        v630, v631 = v628(v629, v630)
        if v630 == nil then
            break
        end
        if (v631.pt or 0) == 1 and not v631.sh and (v631._am or 1) >= p626 * 11 then
            return v630, v631
        end
    end
    return nil
end
local function vu639()
    local v633 = game:GetService("ReplicatedStorage").__DIRECTORY.Eggs.Events.Easter
    local v634, v635, v636 = pairs(v633:GetChildren())
    local v637 = 1
    while true do
        local v638
        v636, v638 = v634(v635, v636)
        if v636 == nil then
            break
        end
        if v637 == tonumber(v638.Name:split(" ")[1]) then
            return v638
        end
    end
    return nil
end
local function vu646(p640)
    local v641 = require(game:GetService("ReplicatedStorage").Library.Client.CustomEggsCmds)
    local v642, v643, v644 = pairs(v641.All())
    while true do
        local v645
        v644, v645 = v642(v643, v644)
        if v644 == nil then
            break
        end
        if v645._id == p640._id then
            return v645._model
        end
    end
end
local function vu649()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local v647 = vu646(require(vu639())).PriceHUD
        local v648 = 30
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v647.Position).Magnitude >= 35 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v647.CFrame + v647.CFrame.LookVector * v648
        end
    end
end
local function vu651()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local v650 = vu611() + 1
        vu606.Invoke("InstanceZones_RequestPurchase", "EasterEvent", v650)
    end
end
local function vu652()
    return require(game.ReplicatedStorage.Library.Client.CurrencyCmds).Get("EasterCoins")
end
local function v659()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local v653 = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game.Events.Easter["Egg Hunt"])
        local v654 = getupvalue(v653.isSpawned, 2)
        if v654 then
            local v655, v656, v657 = pairs(v654.EggData)
            while true do
                local v658
                v657, v658 = v655(v656, v657)
                if v657 == nil then
                    break
                end
                local _, _ = vu606.Invoke("Easter Egg Hunt: Claim", v658.ClaimId)
            end
        end
    end
end
local vu660 = require(game.ReplicatedStorage.Library.Types.Easter)
local vu661 = require(game:GetService("ReplicatedStorage").Library.Client.GiantEasterBasketCmds)
local function vu668(p662)
    local v663 = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Misc
    local v664, v665, v666 = pairs(v663)
    while true do
        local v667
        v666, v667 = v664(v665, v666)
        if v666 == nil then
            break
        end
        if v667.id == p662 then
            return v667, v666
        end
    end
    return nil
end
local function v678()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local v669, v670, v671 = pairs(vu660.EasterBoostDirectory)
        while true do
            local v672
            v671, v672 = v669(v670, v671)
            if v671 == nil then
                break
            end
            local v673 = vu661.GetBoostTime(v671)
            local v674 = math.round(vu660.FuelToTimeConversion)
            local v675 = vu660.FuelMachineMaxTime
            if math.floor((v675 - v673) / v674) > 15 then
                local v676 = vu668(v671)
                if v676 then
                    local _ = v676.id
                    local v677 = v676._am or 1
                    vu606.Invoke("GiantEasterBasket_AddTime", v671, v677)
                end
            end
        end
    end
end
local function vu684()
    local v679 = require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Misc
    local v680, v681, v682 = pairs(v679)
    while true do
        local v683
        v682, v683 = v680(v681, v682)
        if v682 == nil then
            break
        end
        if v683.id == "Easter Secret Key" then
            return true
        end
    end
    return false
end
local function v689()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        if vu611() >= 5 then
            if vu684() then
                vu606.Invoke("Easter_SecretUnlock")
                vu606.Fire("Instancing_PlayerLeaveInstance", "EasterEvent")
                wait(0.5)
                vu606.Invoke("Instancing_PlayerEnterInstance", "EasterEggRoulette")
                wait(0.5)
                vu606.Invoke("Instancing_InvokeCustomFromClient", "EasterEggRoulette", "ClaimSecretEgg", 7)
                vu606.Fire("Instancing_PlayerLeaveInstance", "EasterEggRoulette")
                wait(0.5)
                vu606.Invoke("Instancing_PlayerEnterInstance", "EasterEvent")
                wait(1)
                local v685, v686, v687 = pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren())
                while true do
                    local v688
                    v687, v688 = v685(v686, v687)
                    if v687 == nil then
                        break
                    end
                    if v688:IsA("Model") then
                        v688:Destroy()
                    end
                end
            end
        end
    else
        return
    end
end
local vu690 = tick()
local function v718()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        local v691 = require(game:GetService("ReplicatedStorage").Library.Client.InstancingCmds)
        local v692 = require(game.ReplicatedStorage.Library.Client.Save).Get()
        if v692 then
            local v693 = v691.Get()
            if v693 then
                local v694 = v692.InstanceVars
                local _ = v694.EasterEvent.QuestActive
                local _ = v693.instanceZones
                vu652()
                local v695 = vu611() + 1
                local v696 = v691.Get().instanceZones[v695]
                if v696 then
                    local v697 = v694.EasterEvent.QuestActive
                    if v697 then
                        local v698 = vu618(v697.Type)
                        local v699 = v697.Amount - v697.Progress
                        print("[DEBUG] \n " .. "Current Quest: " .. v698 .. " \n " .. "Amount Needed: " .. v697.Progress .. "/" .. v697.Amount)
                        if v698 == "GOLD_PET" and 0 < v699 then
                            local v700 = vu625(v699)
                            if v700 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.__THINGS.__INSTANCE_CONTAINER.Active.EasterEvent.Teleports["1"].CFrame
                                wait(1)
                                vu606.Invoke("GoldMachine_Activate", v700, v699)
                            else
                                vu649()
                                getgenv().v_settings.functions.OpenClosestEgg()
                            end
                        elseif v698 == "EGG" and 0 < v699 then
                            vu649()
                            vu604()
                        elseif v698 == "RAINBOW_PET" and 0 < v699 then
                            local v701 = vu632(v699)
                            if v701 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.__THINGS.__INSTANCE_CONTAINER.Active.EasterEvent.Teleports["1"].CFrame
                                wait(1)
                                vu606.Invoke("RainbowMachine_Activate", v701, v699)
                            else
                                vu649()
                                getgenv().v_settings.functions.OpenClosestEgg()
                            end
                        elseif v698 == "BREAKABLE" and 0 < v699 then
                            vu611()
                            local v702 = 1
                            local v703 = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent")
                            if not v703 then
                                return
                            end
                            local v704, v705, v706 = pairs(v703.Teleports:GetChildren())
                            while true do
                                local v707
                                v706, v707 = v704(v705, v706)
                                if v706 == nil then
                                    break
                                end
                                if tonumber(v707.Name) == v702 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (v707.Position + Vector3.new(55, 0, - 25))).Magnitude >= 35 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v707.CFrame + Vector3.new(55, 0, - 25)
                                end
                            end
                        elseif v699 < 0 then
                            if vu652() < v696.CurrencyCost then
                                if tick() - vu690 >= 60 then
                                    vu690 = tick()
                                    vu604()
                                end
                                local v708 = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent")
                                local v709 = vu611()
                                local v710 = v708:FindFirstChild("Teleports")
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (v710[tostring(v709)].Position + Vector3.new(55, 0, - 25))).Magnitude >= 35 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v710[tostring(v709)].CFrame + Vector3.new(55, 0, - 25)
                                end
                            else
                                vu651()
                            end
                        end
                    elseif vu652() < v696.CurrencyCost then
                        local v711 = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent"):FindFirstChild("Teleports")
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (v711["1"].Position + Vector3.new(55, 0, - 25))).Magnitude >= 35 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v711["1"].CFrame + Vector3.new(55, 0, - 25)
                        end
                    else
                        vu651()
                    end
                    return
                else
                    local v712 = vu611()
                    local v713 = workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent")
                    if v713 then
                        local v714, v715, v716 = pairs(v713.Teleports:GetChildren())
                        while true do
                            local v717
                            v716, v717 = v714(v715, v716)
                            if v716 == nil then
                                break
                            end
                            if tonumber(v717.Name) == v712 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (v717.Position + Vector3.new(55, 0, - 25))).Magnitude >= 35 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v717.CFrame + Vector3.new(55, 0, - 25)
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
local vu719 = game:GetService("ReplicatedStorage").__DIRECTORY.EventUpgrades.Event.EasterUpgrades
local v720, v721, v722 = pairs(vu719:GetChildren())
local vu723 = vu485
local vu724 = vu405
local vu725 = vu606
local v726 = {}
while true do
    local v727
    v722, v727 = v720(v721, v722)
    if v722 == nil then
        break
    end
    local v728 = require(v727)
    table.insert(v726, v728._id)
end
local function vu735()
    local v729 = require(game.ReplicatedStorage.Library.Client.Save).Get()
    if v729 then
        local v730 = v729.Inventory.Misc
        local v731, v732, v733 = pairs(v730)
        while true do
            local v734
            v733, v734 = v731(v732, v733)
            if v733 == nil then
                break
            end
            if v734.id == "Easter Token" then
                return v734._am or 1
            end
        end
        return nil
    end
end
local function v746()
    local v736 = getgenv().v_settings.functionToggles.SelectedChestsUpgrades
    if # v736 ~= 0 then
        local v737 = require(game.ReplicatedStorage.Library.Client.Save).Get().EventUpgrades
        local v738 = vu719
        local v739, v740, v741 = pairs(v738:GetChildren())
        while true do
            local v742
            v741, v742 = v739(v740, v741)
            if v741 == nil then
                break
            end
            local v743 = require(v742)
            if table.find(v736, v743._id) then
                local v744 = (v737[v743._id] or 0) + 1
                local v745 = v743.TierCosts[v744]
                if not v745 then
                    return
                end
                if v745._data._am <= vu735() and (vu725.Invoke("EventUpgrades: Purchase", v743._id) and math.random(1, 3) == 3) then
                    vu725.Fire("EventLog_Once", "CloseTab", "EasterUpgradeMachine")
                end
            end
        end
    end
end
local function v747()
    if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("EasterEvent") then
        if require(game.ReplicatedStorage.Library.Client.Save).Get().EasterHeroicActivations >= 1 then
            vu725.Fire("Instancing_FireCustomFromClient", "EasterEvent", "SpawnHeroicChest")
        end
    else
        return
    end
end
function getcurrency()
    local v748 = vu342.WorldUtil:GetWorld()
    local _ = v748.MapName
    local v749 = v748.WorldNumber
    local v750 = nil
    if v749 == 1 then
        v750 = getgenv().VRT.Lib.CurrencyCmds.Get("Coins")
    elseif v749 == 2 then
        v750 = getgenv().VRT.Lib.CurrencyCmds.Get("TechCoins")
    elseif v749 == 3 then
        v750 = getgenv().VRT.Lib.CurrencyCmds.Get("VoidCoins")
    end
    return v750
end
function RandomCoinNumber(p751)
    if p751 == nil then
        return nil
    elseif # p751 ~= 0 then
        return p751[math.random(1, # p751)]
    else
        return nil
    end
end
local vu752 = require(game:GetService("ReplicatedStorage").Library.Client.PlayerPet)
function PlayerPets()
    table.clear(vu54)
    local v753, v754, v755 = pairs(vu752.GetAll())
    while true do
        local v756
        v755, v756 = v753(v754, v755)
        if v755 == nil then
            break
        end
        if v756.owner == game.Players.LocalPlayer then
            table.insert(vu54, v756)
        end
    end
    return vu54
end
function partunderplayer()
    local v757 = nil
    local v758 = nil
    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
        local v759 = game.Players.LocalPlayer.Character
        local v760 = v759:FindFirstChild("HumanoidRootPart")
        if v760 then
            local v761 = Vector3.new(0, - 500, 0)
            local v762 = Ray.new(v760.Position, v761)
            v757, v758 = game.Workspace:FindPartOnRay(v762, v759)
        end
    end
    return v757, v758
end
function GetClosestBreakables()
    if game.Players.LocalPlayer.Character then
        table.clear(vu53)
        local v763 = workspace.__THINGS:WaitForChild("Breakables"):GetChildren()
        local v764 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local v765 = getgenv().VRT.Lib.InstancingCmds.Get()
        local v766 = v765 and v765.instanceID or nil
        local v767, v768, v769 = pairs(v763)
        while true do
            local v770
            v769, v770 = v767(v768, v769)
            if v769 == nil then
                break
            end
            if (v770:IsA("Model") and v770:GetAttribute("ParentID") == getgenv().VRT.Lib.MapCmds.GetCurrentZone() or v770:GetAttribute("ParentID") == v766) and (v770.WorldPivot.Position - v764).Magnitude < 85 then
                table.insert(vu53, v770.Name)
            end
        end
        return vu53
    end
end
local vu771 = require(game:GetService("ReplicatedStorage").Library.Util.WorldsUtil)
local vu772 = game:GetService("ReplicatedStorage").__DIRECTORY.Eggs["Zone Eggs"][vu771.GetWorld()._id]
function FindClosestCustomEgg()
    if game.Players.LocalPlayer.Character then
        local v773 = game.Players.LocalPlayer.Character.HumanoidRootPart
        local v774 = workspace.__THINGS.CustomEggs
        local v775 = math.huge
        local v776, v777, v778 = pairs(v774:GetChildren())
        local v779 = nil
        while true do
            local v780
            v778, v780 = v776(v777, v778)
            if v778 == nil then
                break
            end
            if v780:IsA("Model") then
                local v781 = (v773.Position - v780.WorldPivot.Position).Magnitude
                if v781 < v775 then
                    v779 = v780
                    v775 = v781
                end
            end
        end
        return v779, v775
    end
end
function FindClosestEgg()
    local v782 = game.Players.LocalPlayer.Character.HumanoidRootPart
    local v783 = workspace.__THINGS.Eggs[vu771.GetEggsModelName()]
    local v784 = math.huge
    local v785, v786, v787 = pairs(v783:GetChildren())
    local v788 = nil
    while true do
        local v789
        v787, v789 = v785(v786, v787)
        if v787 == nil then
            break
        end
        if v789:IsA("Model") then
            local v790 = (v782.Position - v789:FindFirstChild("Light").CFrame.Position).Magnitude
            if v790 < v784 then
                v788 = v789
                v784 = v790
            end
        end
    end
    if not v788 then
        return
    end
    local v791 = string.split(v788.Name, " ")
    local v792 = vu772
    local v793, v794, v795 = pairs(v792:GetDescendants())
    local v796 = nil
    while true do
        local v797
        v795, v797 = v793(v794, v795)
        if v795 == nil then
            v797 = v796
            break
        end
        if v797.Name:match(v791[1]) then
            local v798 = string.split(v797.Name, " ")
            if v798[6] then
                v788 = v798[3] .. " " .. v798[4] .. " " .. v798[5] .. " " .. v798[6]
            elseif v798[5] then
                v788 = v798[3] .. " " .. v798[4] .. " " .. v798[5]
            else
                v788 = v798[3] .. " " .. v798[4]
            end
            break
        end
    end
    return v788, v784, v797
end
if workspace.__THINGS:WaitForChild("Breakables"):FindFirstChild("Highlight") then
    workspace.__THINGS.Breakables:FindFirstChild("Highlight"):Destroy()
end
function MaxEventZone()
    if vu59.Get() then
        return # vu59.Get().instanceZones
    end
end
function GetCurrentEvent()
    local v799 = vu59.All()
    local v800, v801, v802 = pairs(v799)
    while true do
        local v803
        v802, v803 = v800(v801, v802)
        if v802 == nil then
            break
        end
        if v803:match("Event") then
            vu65 = v803
        end
    end
end
function GetCurrentEventInstance()
    local v804 = vu59.Get()
    if not v804 then
        return false
    end
    vu62 = v804
    vu63 = v804.instanceID
    return true
end
function GetCurrentEventInstanceZones()
    return vu62.instanceZones
end
function GetCurrentEventInstanceFolder()
    vu64 = workspace.__THINGS.Instances:FindFirstChild(vu63)
    return vu64
end
function GetEventMaximumZoneNumber()
    return vu60.GetMaximumOwnedZoneNumber()
end
function GetMaxHatchCount()
    return vu61.GetMaxHatch()
end
function GetEventZoneToBuy()
    local v805 = GetCurrentEventInstanceZones()
    local v806 = GetEventMaximumZoneNumber()
    if v805[v806] and v805[v806 + 1] then
        return v805[v806], v805[v806 + 1]
    else
        return nil
    end
end
function BuyZone()
    local v807 = GetCurrentCoins()
    local v808 = GetEventZoneToBuy()
    local v809 = v808.CurrencyCost
    local _ = v808.DisplayName
    if v809 > v807 then
        return false
    end
    local v810 = {
        vu63,
        GetEventMaximumZoneNumber() + 1
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("InstanceZones_RequestPurchase"):InvokeServer(unpack(v810))
    return true
end
function GetQuestFromId(p811)
    local v812, v813, v814 = pairs(vu347.Goals)
    while true do
        local v815
        v814, v815 = v812(v813, v814)
        if v814 == nil then
            break
        end
        if p811 == v815 then
            return v814
        end
    end
end
function GetIdFromQuest(p816)
    local v817, v818, v819 = pairs(vu347.Goals)
    while true do
        local v820
        v819, v820 = v817(v818, v819)
        if v819 == nil then
            break
        end
        if p816 == v819 then
            return v820
        end
    end
end
function CurrentZoneQuest()
    table.clear(vu66)
    local v821 = vu723.InstanceVars[vu63].QuestActive
    vu66.progress = v821.Progress
    vu66.type = v821.Type
    vu66.amount = v821.Amount
    return vu66
end
function MakeQuest()
    local v822 = CurrentZoneQuest()
    local v823 = GetQuestFromId(v822.type)
    if v822.progress >= v822.amount then
        BuyZone()
    end
    warn(v823)
    if v823 == "RAINBOW_PET" then
        local v824 = vu723.Inventory.Pet
        local v825, v826, v827 = pairs(v824)
        while true do
            local v828
            v827, v828 = v825(v826, v827)
            if v827 == nil then
                break
            end
            local v829 = v828._am or 1
            local v830 = v828.pt
            if not v828.sh and (v830 == 1 and v822.amount * 10 < v829) then
                local v831 = {
                    v827,
                    v822.amount + 2
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("RainbowMachine_Activate"):InvokeServer(unpack(v831))
            end
        end
    elseif v823 == "BREAKABLE" then
        local v832 = GetCurrentEventInstanceFolder()
        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v832.BREAKABLE_SPAWNS.Main_1.Position).Magnitude >= 40 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v832.BREAKABLE_SPAWNS.Main_1.CFrame
        end
    elseif v823 == "EGG" then
        TeleportToEventZone(1)
    elseif v823 == "GOLD_PET" then
        local v833 = vu723.Inventory.Pet
        local v834, v835, v836 = pairs(v833)
        while true do
            local v837
            v836, v837 = v834(v835, v836)
            if v836 == nil then
                break
            end
            local v838 = v837._am or 1
            local v839 = v837.pt or 0
            if not v837.sh and (v839 == 0 and v822.amount * 10 < v838) then
                local v840 = {
                    v836,
                    v822.amount + 2
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("RainbowMachine_Activate"):InvokeServer(unpack(v840))
            end
        end
    end
end
function TeleportToEventZone(p841)
    local v842 = game.Players.LocalPlayer.Character.HumanoidRootPart
    local v843 = GetCurrentEventInstanceFolder().BREAKABLE_SPAWNS
    local v844 = workspace.__THINGS.__INSTANCE_CONTAINER.Active.PetGamesEvent.Teleports
    if v843:FindFirstChild("Main_" .. tostring(p841)) and (v842.Position - v843:FindFirstChild("Main_" .. tostring(p841)).Position).Magnitude <= 90 then
        local v845 = GetClosestEventEgg()
        if (v842.Position - v845.Center.Position).Magnitude >= 50 then
            v842.CFrame = v845.Center.CFrame + Vector3.new(0, 0, - 30)
        end
    else
        v842.CFrame = v844[tostring(p841)].CFrame
        task.wait(1)
    end
end
function PrintDebugInfo()
    print("Debug Info:")
    print(" - ScriptVersion: ", vu348)
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
local v846, v847, v848 = pairs(require(game:GetService("ReplicatedStorage").Library.Directory.ZoneFlags))
local v849 = {}
while true do
    local v850, _ = v846(v847, v848)
    if v850 == nil then
        break
    end
    v848 = v850
    if not v849.Flags then
        v849.Flags = {}
    end
    table.insert(v849.Flags, v850)
end
setthreadidentity(8)
local function vu857(p851)
    local v852, v853, v854 = pairs(p851)
    local v855 = ""
    while true do
        local v856
        v854, v856 = v852(v853, v854)
        if v854 == nil then
            break
        end
        v855 = v855 .. v854 .. " " .. v856 .. "\n"
    end
    return v855
end
local function vu865(p858)
    local v859, v860, v861 = pairs(p858)
    local v862 = true
    local v863 = ""
    while true do
        local v864
        v861, v864 = v859(v860, v861)
        if v861 == nil then
            break
        end
        if v862 then
            v863 = v863 .. v861 .. " " .. v864
            v862 = false
        else
            v863 = v863 .. "," .. v861 .. " " .. v864
        end
    end
    return v863
end;
(function()
    if isfile("VRT/Config/MailboxItems.txt") then
        local v866 = readfile("VRT/Config/MailboxItems.txt")
        local v867, v868, v869 = string.gmatch(v866, "([^,]+)")
        local v870 = {}
        while true do
            v869 = v867(v868, v869)
            if v869 == nil then
                break
            end
            local v871, v872 = string.match(v869, "^(.-)%s*(%d+)$")
            if v871 and v872 then
                table.insert(v870, {
                    name = v871,
                    amount = tonumber(v872)
                })
            end
        end
        local v873, v874, v875 = pairs(v870)
        while true do
            local v876
            v875, v876 = v873(v874, v875)
            if v875 == nil then
                break
            end
            getgenv().v_settings.functionToggles.MailboxItems[v876.name] = v876.amount
        end
    end
end)()
local vu877 = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local v878 = vu877
local v879 = vu877.CreateWindow(v878, {
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
    KeySystem = false,
    [v19] = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {
            "Hello"
        }
    }
})
local function v890(p880, p881, pu882, pu883, pu884, pu885, pu886)
    p880:CreateToggle({
        Name = p881,
        CurrentValue = false,
        Flag = pu882,
        Callback = function(p887)
            getgenv().v_settings.functionToggles[pu882] = p887
            task.spawn(function()
                while getgenv().v_settings.functionToggles[pu882] do
                    if not getgenv().v_settings.functionToggles[pu886] then
                        local v888, v889 = pcall(function()
                            return pu884(pu883)
                        end)
                        if not v888 then
                            warn("[ERROR]", pu882, v889)
                        end
                    end
                    task.wait(pu885)
                end
            end)
        end
    })
end
local function vu908(p891, p892, pu893, pu894, pu895, pu896, pu897, pu898)
    return p891:CreateToggle({
        Name = p892,
        CurrentValue = false,
        Flag = pu893,
        Callback = function(p899)
            if pu893 == "StatiscticsUI" and not p899 then
                local v900, v901, v902 = pairs(game.CoreGui:GetChildren())
                while true do
                    local v903
                    v902, v903 = v900(v901, v902)
                    if v902 == nil then
                        break
                    end
                    if v903.Name == "MainScreen" then
                        v903:Destroy()
                    end
                end
            end
            if pu896 == "FarmRaid" then
                shouldcreatenewraid = true
            end
            print("Setting:", pu893, "To:", p899)
            getgenv().v_settings.functionToggles[pu893] = p899
            local vu904 = 0
            task.spawn(function()
                while getgenv().v_settings.functionToggles[pu893] do
                    if not getgenv().v_settings.functionToggles[pu897] then
                        local v906, v907 = xpcall(pu894, function(p905)
                            return debug.traceback(p905, 2)
                        end)
                        if not v906 then
                            warn("[ERROR]", pu893, v907)
                        end
                    end
                    if pu898 ~= "MineEvery" then
                        vu904 = pu895
                    else
                        vu904 = getgenv().v_settings.functionToggles[pu898] or pu895
                    end
                    task.wait(vu904)
                end
            end)
        end
    })
end
local function v912(p909, p910, pu911)
    p909:CreateButton({
        Name = p910,
        Callback = function()
            pu911()
        end
    })
end
local function v928(p913, p914, pu915, pu916, p917)
    if p917 then
        if not getgenv().v_settings.functionToggles[pu915] then
            getgenv().v_settings.functionToggles[pu915] = {}
        end
        p913:CreateDropdown({
            Name = p914,
            Options = pu916,
            CurrentOption = {},
            MultipleOptions = p917,
            Flag = pu915,
            Callback = function(p918)
                local v919, v920, v921 = pairs(p918)
                while true do
                    local v922
                    v921, v922 = v919(v920, v921)
                    if v921 == nil then
                        break
                    end
                    if table.find(pu916, v922) and not table.find(getgenv().v_settings.functionToggles[pu915], v922) then
                        table.insert(getgenv().v_settings.functionToggles[pu915], v922)
                    end
                end
                local v923, v924, v925 = pairs(getgenv().v_settings.functionToggles[pu915])
                while true do
                    local v926
                    v925, v926 = v923(v924, v925)
                    if v925 == nil then
                        break
                    end
                    if not table.find(p918, v926) then
                        table.remove(getgenv().v_settings.functionToggles[pu915], v925)
                    end
                end
            end
        })
    else
        p913:CreateDropdown({
            Name = p914,
            Options = pu916,
            CurrentOption = {
                "None"
            },
            MultipleOptions = p917,
            Flag = pu915,
            Callback = function(p927)
                getgenv().v_settings.functionToggles[pu915] = p927[1]
            end
        })
    end
end
local function v934(p929, pu930, pu931, p932)
    p929:CreateInput({
        Name = pu930,
        CurrentValue = "",
        PlaceholderText = p932,
        RemoveTextAfterFocusLost = false,
        Flag = pu931,
        Callback = function(p933)
            getgenv().v_settings.functionToggles[pu931] = p933
            vu877:Notify({
                Title = pu930 .. " Updated!",
                Content = pu930 .. " Updated!",
                Duration = 3,
                Image = 4483362458
            })
        end
    })
end
local v935 = v879:CreateTab("Testing", "box")
v935:CreateSection("Testing Section")
v935:CreateLabel("Discord: .gg/JwfXeX9gjw", "notepad-text", Color3.fromRGB(119, 133, 204), false)
v935:CreateLabel("Updated For Conveyor Event", "notepad-text", Color3.fromRGB(29, 219, 0), false)
v935:CreateSection("Webhook Section")
v934(v935, "Discord Webhook (Ping On Huge/Titanic)", "DiscordWebhook", "Input Discord Webhook")
v934(v935, "Discord UserId", "DiscordUserId", "Input Discord Account ID")
vu908(v935, "Send Webhook on Huge/Titanic Pet", "SendWebhook", CheckPets, 15)
v935:CreateSection("Testing Functions Section")
ShinyRelicsParagraph = v935:CreateParagraph({
    Title = "Collected Relics",
    Content = "You Have Collected 0/0 Shiny Relics"
})
vu908(v935, "Collect Relics", "AutoRelics", v544, 5)
vu908(v935, "Auto Claim Rank Rewards", "AutoClaimRankRewards", v569, 5)
v890(v935, "Buy Next Zone", "BuyNextZone", vu342, vu342.BuyNextZone, 0.05)
v890(v935, "Teleport To Best Unlocked World", "TeleportToBestUnlockedWorld", vu342, vu342.TeleportToAnotherWorld, 1)
v890(v935, "Buy Pet Slots", "BuyPetSlots", vu342, vu342.BuyPetSlots, 0.25)
v890(v935, "Use Ultimate", "UseUltimate", vu342, vu342.ActivateUltimate, 0.25)
v928(v935, "Select Flag to Use", "SelectedFlag", v849.Flags, false);
(function(p936, p937, pu938, p939, p940, p941)
    p936:CreateSlider({
        Name = p937,
        Range = p939,
        Increment = p940,
        Suffix = p941,
        CurrentValue = 1,
        Flag = pu938,
        Callback = function(p942)
            getgenv().v_settings.functionToggles[pu938] = p942
        end
    })
end)(v935, "Flag Amount to Use", "FlagAmount", {
    1,
    45
}, 1, "Flags")
v890(v935, "Use Selected Flag", "UseSelectedFlag", vu342, vu342.ActivateFlag, 1)
vu908(v935, "Auto Daycare (Claim and Enroll)", "AutoDayCare", PutPetsInDaycare, 2.5)
v890(v935, "Auto Free Gifts", "AutoFreeGifts", vu342, vu342.ClaimFreeGifts, 1.5)
v912(v935, "Debug Print", PrintDebugInfo)
local v943 = v879:CreateTab("Event", "box")
v943:CreateSection("Event Section")
vu908(v943, "Auto Enter Easter Event", "EnterEasterEvent", v610, 5)
vu908(v943, "Farm Last Area", "FarmEasterLastArea", v718, 1)
vu908(v943, "Claim Easter Eggs", "EasterClaimEgg", v659, 2.5)
v928(v943, "Select Chest Upgrades you Want to Upgrade", "SelectedChestsUpgrades", v726, true)
vu908(v943, "Buy Selected Chest Upgrades", "BuySelectedChestUpgrades", v746, 1.5)
vu908(v943, "Make Chest Heroic", "ChestHeroicMode", v747, 1)
vu908(v943, "Auto Make Egg Roulette", "AutoEggRoulette", v689, 1)
vu908(v943, "Auto Boost Easter Basket", "BoostGiantBasket", v678, 5)
local v944 = v879:CreateTab("Mailbox", "box")
v944:CreateSection("Mailbox Section")
local vu945 = v944:CreateParagraph({
    Title = "Selected Items To Mailbox",
    Content = "<font color=\'#4bc0ff\'>" .. vu857(getgenv().v_settings.functionToggles.MailboxItems) .. "</font>"
})
v944:CreateInput({
    Name = "Input Username you want to mailbox items to",
    CurrentValue = "",
    PlaceholderText = "Input Username",
    RemoveTextAfterFocusLost = false,
    Flag = "MailboxUsername",
    Callback = function(p946)
        getgenv().v_settings.functionToggles.MailboxUsername = p946
    end
})
v944:CreateDropdown({
    Name = "Send Huges Mode",
    Options = {
        "All",
        "New"
    },
    CurrentOption = {
        "None"
    },
    MultipleOptions = false,
    Flag = "MailboxSendHugesType",
    Callback = function(p947)
        getgenv().v_settings.functionToggles.MailboxSendHugesType = p947[1]
    end
})
v944:CreateInput({
    Name = "Input Item name you want to mailbox",
    CurrentValue = "",
    PlaceholderText = "Input Item name",
    RemoveTextAfterFocusLost = false,
    Flag = "InputedMailboxItem",
    Callback = function(p948)
        getgenv().v_settings.functionToggles.InputedMailboxItem = p948
    end
})
v944:CreateInput({
    Name = "Send if Item Amount is higher than (amount)",
    CurrentValue = "",
    PlaceholderText = "Send if Higher Than",
    RemoveTextAfterFocusLost = false,
    Flag = "InputedMailboxItem",
    Callback = function(p949)
        if p949:match("%d+") then
            getgenv().v_settings.functionToggles.InputedMailboxAmount = tonumber(p949)
        else
            vu877:Notify({
                Title = "Item Amount is not number",
                Content = "Item Amount need to be a number",
                Duration = 5,
                Image = 4483362458
            })
        end
    end
})
v944:CreateButton({
    Name = "Add Inputed Item To List",
    Callback = function()
        if not vu409() then
            vu877:Notify({
                Title = "Wrong Item Name",
                Content = "Inputed Wrong Item Name Try With Capitalized Letters",
                Duration = 5,
                Image = 4483362458
            })
        end
        vu945:Set({
            Title = "Selected Items To Mailbox",
            Content = "<font color=\'#4bc0ff\'>" .. vu857(getgenv().v_settings.functionToggles.MailboxItems) .. "</font>"
        })
        writefile("VRT/Config/MailboxItems.txt", vu865(getgenv().v_settings.functionToggles.MailboxItems))
    end
})
v944:CreateButton({
    Name = "Remove Inputed Item To List",
    Callback = function()
        vu413()
        vu945:Set({
            Title = "Selected Items To Mailbox",
            Content = "<font color=\'#4bc0ff\'>" .. vu857(getgenv().v_settings.functionToggles.MailboxItems) .. "</font>"
        })
        writefile("VRT/Config/MailboxItems.txt", vu865(getgenv().v_settings.functionToggles.MailboxItems))
    end
})
v944:CreateToggle({
    Name = "Send Selected Items",
    CurrentValue = false,
    Flag = "SendSelectedItemsMailbox",
    Callback = function(p950)
        getgenv().v_settings.functionToggles.MailboxEnabled = p950
        task.spawn(function()
            while getgenv().v_settings.functionToggles.MailboxEnabled do
                vu390()
                task.wait(5)
            end
        end)
    end
})
v944:CreateToggle({
    Name = "Send Huges By Mode",
    CurrentValue = false,
    Flag = "HugeMailboxEnabled",
    Callback = function(p951)
        getgenv().v_settings.functionToggles.HugeMailboxEnabled = p951
        task.spawn(function()
            while getgenv().v_settings.functionToggles.HugeMailboxEnabled do
                vu724()
                task.wait(5)
            end
        end)
    end
})
v944:CreateToggle({
    Name = "Auto Claim Mailbox",
    CurrentValue = false,
    Flag = "MailboxClaimAll",
    Callback = function(p952)
        getgenv().v_settings.functionToggles.MailboxClaimAll = p952
        task.spawn(function()
            while getgenv().v_settings.functionToggles.MailboxClaimAll do
                vu414()
                task.wait(5)
            end
        end)
    end
})
local v953 = v879:CreateTab("Auto-Farm", "dollar-sign")
v953:CreateSection("Farming Section")
v953:CreateToggle({
    Name = "Fast Farm",
    CurrentValue = false,
    Flag = "FastFarm",
    Callback = function(p954)
        getgenv().v_settings.functionToggles.FastFarm = p954
        task.spawn(function()
            while getgenv().v_settings.functionToggles.FastFarm do
                getgenv().v_settings.functions.FastFarm()
                task.wait(0.15)
            end
        end)
    end
})
v953:CreateToggle({
    Name = "(Old test which works better for you) Fast Farm",
    CurrentValue = false,
    Flag = "FastFarm2",
    Callback = function(p955)
        getgenv().v_settings.functionToggles.FastFarm2 = p955
        task.spawn(function()
            while getgenv().v_settings.functionToggles.FastFarm2 do
                getgenv().v_settings.functions.FastFarm2()
                task.wait(0.2)
            end
        end)
    end
})
v953:CreateToggle({
    Name = "Auto Collect Orbs",
    CurrentValue = false,
    Flag = "AutoOrbs",
    Callback = function(p956)
        getgenv().v_settings.functionToggles.AutoOrbs = p956
        task.spawn(function()
            while getgenv().v_settings.functionToggles.AutoOrbs do
                getgenv().v_settings.functions.CollectOrbs()
                task.wait(0.01)
            end
        end)
    end
})
v953:CreateToggle({
    Name = "Inf Pet Speed",
    CurrentValue = false,
    Flag = "InfPetSpeed",
    Callback = function(p957)
        getgenv().v_settings.functionToggles.HugePetSpeed = p957
        if p957 then
            getgenv().v_settings.functions.HugePetSpeed()
        else
            vu349.CalculateSpeedMultiplier = getgenv().v_settings.functionsValues.PetSpeed
        end
    end
})
v953:CreateSection("Egg Opening")
local vu959 = v953:CreateToggle({
    Name = "Hide Egg Animation",
    CurrentValue = false,
    Flag = "HideEggAnimation",
    Callback = function(p958)
        getgenv().v_settings.functionToggles.HideEggAnimation = p958
        if p958 then
            HookEggAnimationToggle:Set(false)
            task.spawn(function()
                while getgenv().v_settings.functionToggles.HideEggAnimation do
                    getgenv().v_settings.functions.HideEggAnimation()
                    wait(5)
                end
            end)
        else
            vu346.PlayEggAnimation = getgenv().v_settings.functionsValues.EggAnimation
        end
    end
})
HookEggAnimationToggle = v953:CreateToggle({
    Name = "Hook Egg Animation",
    CurrentValue = false,
    Flag = "HookEggAnimation",
    Callback = function(p960)
        getgenv().v_settings.functionToggles.HookEggAnimation = p960
        if p960 then
            vu959:Set(false)
            task.spawn(function()
                while getgenv().v_settings.functionToggles.HookEggAnimation do
                    getgenv().v_settings.functions.HookEggAnimation()
                    wait(5)
                end
            end)
        else
            vu346.PlayEggAnimation = getgenv().v_settings.functionsValues.EggAnimation
        end
    end
})
v953:CreateToggle({
    Name = "Auto Open Closest Egg",
    CurrentValue = false,
    Flag = "AutoOpenClosestEgg",
    Callback = function(p961)
        getgenv().v_settings.functionToggles.OpenClosestEgg = p961
        task.spawn(function()
            while getgenv().v_settings.functionToggles.OpenClosestEgg do
                getgenv().v_settings.functions.OpenClosestEgg()
                task.wait(0.01)
            end
        end)
    end
})
v953:CreateSection("Click Aura")
v953:CreateSlider({
    Name = "Click Aura Slider",
    Range = {
        0,
        150
    },
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 75,
    Flag = "ClickAuraSlider",
    Callback = function(p962)
        getgenv().v_settings.functionsValues.ClickAuraValue = p962
    end
})
v953:CreateToggle({
    Name = "Click Aura Visualizer",
    CurrentValue = false,
    Flag = "ClickAuraVisualizer",
    Callback = function(p963)
        if not p963 and workspace:FindFirstChild("M") then
            workspace:FindFirstChild("M"):Destroy()
        end
        getgenv().v_settings.functionToggles.ClickAuraVisualizer = p963
        task.spawn(function()
            while getgenv().v_settings.functionToggles.ClickAuraVisualizer do
                getgenv().v_settings.functions.VisualizeClickAura(getgenv().v_settings.functionsValues.ClickAuraValue).Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                task.wait(0.01)
            end
        end)
    end
})
v953:CreateToggle({
    Name = "Click Aura",
    CurrentValue = false,
    Flag = "ClickAura",
    Callback = function(p964)
        getgenv().v_settings.functionToggles.ClickAura = p964
        task.spawn(function()
            while getgenv().v_settings.functionToggles.ClickAura do
                getgenv().v_settings.functions.ClickAura()
                task.wait(0.01)
            end
        end)
    end
})
v953:CreateSection("Optimize")
v953:CreateToggle({
    Name = "Optimize Breakables",
    CurrentValue = false,
    Flag = "OptimizeBreakables",
    Callback = function(p965)
        getgenv().v_settings.functionToggles.OptimizeBreakables = p965
        if p965 then
            local _, _ = pcall(function()
                return getgenv().v_settings.functions.OptimizeBreakables()
            end)
        elseif getgenv().v_settings.OptimizeBreakables then
            getgenv().v_settings.OptimizeBreakables:Disconnect()
            getgenv().v_settings.OptimizeBreakables = nil
        end
    end
})
v953:CreateToggle({
    Name = "Optimize Pets",
    CurrentValue = false,
    Flag = "OptimizePets",
    Callback = function(p966)
        getgenv().v_settings.functionToggles.OptimizePets = p966
        while getgenv().v_settings.functionToggles.OptimizePets do
            getgenv().v_settings.functions.OptimizePets()
            task.wait(5)
        end
    end
})
local v967 = require(game:GetService("ReplicatedStorage").Library.Directory.Fruits)
local v968 = require(game:GetService("ReplicatedStorage").Library.Directory.Lootboxes)
local v969 = game:GetService("ReplicatedStorage").__DIRECTORY.MiscItems.Categorized.Gifts
local v970, v971, v972 = pairs(v967)
local v973 = vu877
local v974 = {}
local v975 = {}
local v976 = {}
while true do
    local v977
    v972, v977 = v970(v971, v972)
    if v972 == nil then
        break
    end
    table.insert(v974, v972)
    table.insert(v974, "Shiny " .. v972)
end
local v978, v979, v980 = pairs(v968)
while true do
    local v981
    v980, v981 = v978(v979, v980)
    if v980 == nil then
        break
    end
    table.insert(v975, v980)
end
local v982, v983, v984 = pairs(v969:GetChildren())
while true do
    local v985
    v984, v985 = v982(v983, v984)
    if v984 == nil then
        break
    end
    table.insert(v976, v985.Name)
end
local v986 = v879:CreateTab("Auto Consume/Open", "dollar-sign")
v986:CreateSection("Fruits Section")
v928(v986, "Select Fruits to Use", "SelectedFruits", v974, true)
vu908(v986, "Use Selected Fruits", "UseSelectedFruits", v509, 5)
v986:CreateSection("LootBoxes Section")
v928(v986, "Select Lootboxes to Open", "SelectedLootboxes", v975, true)
vu908(v986, "Open Selected Lootboxes", "OpenSelectedLootboxes", v520, 1)
v928(v986, "Select Gift Bags to Open", "SelectedGifts", v976, true)
vu908(v986, "Open Selected GiftBags", "OpenSelectedGifts", v529, 1)
local vu987 = v879:CreateTab("Auto-Rank", "dollar-sign")
local v988 = vu987
vu987.CreateSection(v988, "Ranking Section")
local vu989 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Verteniasty/Pet-rbx/refs/heads/main/AutoRank.lua"))()
local vu990 = false
local vu991 = true
function CreateAutoRankToggle()
    if not vu990 then
        if isfile("VRT_KEYSYSTEM.txt") then
            if vu35((readfile("VRT_KEYSYSTEM.txt"))) then
                print("CREATE TOGGLE")
                vu990 = true
                vu908(vu987, "Auto Rank", "AutoRank", vu989, 1)
            else
                if vu991 then
                    vu991 = false
                    return
                end
                print("KEY EXPIRED")
                vu34()
            end
        else
            if vu991 then
                vu991 = false
                return
            end
            print("NO FILE")
            vu34()
        end
    end
end
setthreadidentity(8)
local v992 = vu987
vu987.CreateLabel(v992, "To Access Auto Rank You Need To Do A Key", "notepad-text", Color3.fromRGB(119, 133, 204), false)
vu908(vu987, "Auto Claim Rank Rewards", "AutoClaimRankRewards", v569, 3)
v912(vu987, "Access Auto Rank", CreateAutoRankToggle)
CreateAutoRankToggle()
v973:LoadConfiguration()
task.spawn(antiafk)