local FarmUI = {}

function FarmUI.Init(Tab, State)

    print("[UI] Farm inicializado.")

    -- ========================================================
    -- TESTE
    -- ========================================================

    Tab:CreateParagraph({
        name = "Farm",
        content = "Project Slayers 2 - Farm"
    })

    Tab:CreateButton({
        name = "Farm UI Test",
        callback = function()
            print("[Farm] UI funcionando corretamente.")
        end,
    })

    -- ========================================================
    -- FARM MOBS
    -- ========================================================

    Tab:CreateParagraph({
        name = "Farm Mobs",
        content = "Configurações para farm automático de mobs."
    })

    local TargetMob = Tab:CreateDropdown({
        name = "Target Mob",
        options = {
            "Nenhum mob encontrado"
        },
        currentOption = {
            "Nenhum mob encontrado"
        },
        callback = function(option)

            if type(option) == "table" then
                State.TargetMob = option[1]
            else
                State.TargetMob = option
            end

            print(
                "[Farm] Target Mob:",
                State.TargetMob
            )
        end,
    })

    State.TargetMobElement = TargetMob

    Tab:CreateButton({
        name = "Refresh Mobs",
        callback = function()

            print(
                "[Farm] Atualizando lista de mobs..."
            )

            -- Futuramente:
            -- detectar os mobs existentes
            -- e atualizar o dropdown

        end,
    })

    Tab:CreateToggle({
        name = "Farm Mobs",
        currentValue = false,

        callback = function(value)

            State.FarmMobs = value

            print(
                "[Farm] Farm Mobs:",
                value and "ON" or "OFF"
            )

        end,
    })

    Tab:CreateToggle({
        name = "Mob Kill Aura",
        currentValue = false,

        callback = function(value)

            State.MobKillAura = value

            print(
                "[Farm] Mob Kill Aura:",
                value and "ON" or "OFF"
            )

        end,
    })

    -- ========================================================
    -- FARM MOBS POSITION
    -- ========================================================

    Tab:CreateParagraph({
        name = "Mob Farm Position",
        content = "Define a posição relativa ao mob."
    })

    Tab:CreateSlider({
        name = "Mob X Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 0,

        callback = function(value)
            State.FarmOffsetX = value
        end,
    })

    Tab:CreateSlider({
        name = "Mob Y Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.FarmOffsetY = value
        end,
    })

    Tab:CreateSlider({
        name = "Mob Z Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.FarmOffsetZ = value
        end,
    })

    Tab:CreateSlider({
        name = "Mob Distance",
        range = {1, 50},
        increment = 1,
        currentValue = 10,

        callback = function(value)
            State.FarmDistance = value
        end,
    })

    -- ========================================================
    -- LOOT
    -- ========================================================

    Tab:CreateParagraph({
        name = "Loot",
        content = "Configurações de coleta."
    })

    Tab:CreateToggle({
        name = "Auto Loot Chests",
        currentValue = false,

        callback = function(value)

            State.AutoLootChests = value

            print(
                "[Farm] Auto Loot Chests:",
                value and "ON" or "OFF"
            )

        end,
    })

    Tab:CreateToggle({
        name = "Pickup Aura",
        currentValue = false,

        callback = function(value)

            State.PickupAura = value

            print(
                "[Farm] Pickup Aura:",
                value and "ON" or "OFF"
            )

        end,
    })

    -- ========================================================
    -- BOSS
    -- ========================================================

    Tab:CreateParagraph({
        name = "Boss Farm",
        content = "Configurações para farm automático de bosses."
    })

    local TargetBoss = Tab:CreateDropdown({
        name = "Target Boss",

        options = {
            "Nenhum boss encontrado"
        },

        currentOption = {
            "Nenhum boss encontrado"
        },

        callback = function(option)

            if type(option) == "table" then
                State.TargetBoss = option[1]
            else
                State.TargetBoss = option
            end

            print(
                "[Farm] Target Boss:",
                State.TargetBoss
            )

        end,
    })

    State.TargetBossElement = TargetBoss

    Tab:CreateButton({
        name = "Refresh Bosses",

        callback = function()

            print(
                "[Farm] Atualizando lista de bosses..."
            )

        end,
    })

    Tab:CreateToggle({
        name = "Boss Farm",
        currentValue = false,

        callback = function(value)

            State.BossFarm = value

            print(
                "[Farm] Boss Farm:",
                value and "ON" or "OFF"
            )

        end,
    })

    -- ========================================================
    -- AUTO QUEST
    -- ========================================================

    Tab:CreateParagraph({
        name = "Auto Quest",
        content = "Configurações para gerenciamento de quests."
    })

    local TargetQuest = Tab:CreateDropdown({
        name = "Target Quest",

        options = {
            "Nenhuma quest encontrada"
        },

        currentOption = {
            "Nenhuma quest encontrada"
        },

        callback = function(option)

            if type(option) == "table" then
                State.TargetQuest = option[1]
            else
                State.TargetQuest = option
            end

            print(
                "[Farm] Quest selecionada:",
                State.TargetQuest
            )

        end,
    })

    State.TargetQuestElement = TargetQuest

    Tab:CreateButton({
        name = "Refresh Quests",

        callback = function()

            print(
                "[Farm] Atualizando lista de quests..."
            )

        end,
    })

    Tab:CreateToggle({
        name = "Auto Quest",
        currentValue = false,

        callback = function(value)

            State.AutoQuest = value

            print(
                "[Farm] Auto Quest:",
                value and "ON" or "OFF"
            )

        end,
    })

    -- ========================================================
    -- FARM PLAYERS
    -- ========================================================

    Tab:CreateParagraph({
        name = "Farm Players",
        content = "Configurações para interação com jogadores."
    })

    local TargetPlayer = Tab:CreateDropdown({
        name = "Target Player",

        options = {
            "Nenhum jogador encontrado"
        },

        currentOption = {
            "Nenhum jogador encontrado"
        },

        callback = function(option)

            if type(option) == "table" then
                State.TargetPlayer = option[1]
            else
                State.TargetPlayer = option
            end

            print(
                "[Farm] Target Player:",
                State.TargetPlayer
            )

        end,
    })

    State.TargetPlayerElement = TargetPlayer

    Tab:CreateButton({
        name = "Refresh Players",

        callback = function()

            print(
                "[Farm] Atualizando lista de jogadores..."
            )

        end,
    })

    Tab:CreateToggle({
        name = "Farm Player",
        currentValue = false,

        callback = function(value)

            State.FarmPlayer = value

            print(
                "[Farm] Farm Player:",
                value and "ON" or "OFF"
            )

        end,
    })

    Tab:CreateToggle({
        name = "Player Kill Aura",
        currentValue = false,

        callback = function(value)

            State.PlayerKillAura = value

            print(
                "[Farm] Player Kill Aura:",
                value and "ON" or "OFF"
            )

        end,
    })

    -- ========================================================
    -- PLAYER FARM POSITION
    -- ========================================================

    Tab:CreateParagraph({
        name = "Player Farm Position",
        content = "Define a posição relativa ao jogador alvo."
    })

    Tab:CreateSlider({
        name = "Player X Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 0,

        callback = function(value)
            State.PlayerFarmOffsetX = value
        end,
    })

    Tab:CreateSlider({
        name = "Player Y Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.PlayerFarmOffsetY = value
        end,
    })

    Tab:CreateSlider({
        name = "Player Z Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.PlayerFarmOffsetZ = value
        end,
    })

    Tab:CreateSlider({
        name = "Player Distance",
        range = {1, 50},
        increment = 1,
        currentValue = 10,

        callback = function(value)
            State.PlayerFarmDistance = value
        end,
    })

    -- ========================================================
    -- DEBUG
    -- ========================================================

    Tab:CreateParagraph({
        name = "Debug",
        content = "Ferramentas de diagnóstico do Project Slayers 2."
    })

    Tab:CreateButton({
        name = "Farm Debug Test",

        callback = function()

            print("================================")
            print("[Farm] DEBUG")
            print("================================")
            print("State:", State ~= nil)
            print("TargetMob:", State.TargetMob)
            print("TargetBoss:", State.TargetBoss)
            print("TargetQuest:", State.TargetQuest)
            print("TargetPlayer:", State.TargetPlayer)
            print("================================")

        end,
    })

    print("[UI] Farm finalizado.")

end

return FarmUI