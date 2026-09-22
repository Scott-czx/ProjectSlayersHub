local FarmUI = {}

function FarmUI.Init(Tab, State)

    print("[UI] Farm inicializado.")

    -- =========================
    -- FARM MOBS
    -- =========================

    Tab:CreateParagraph({
        name = "Farm Mobs",
        content = "Configurações para farm automático de mobs."
    })

    -- Mob selecionado
    local TargetMob = Tab:CreateDropdown({
        name = "Target Mob",
        options = {
            "Nenhum mob encontrado"
        },
        currentOption = {
            "Nenhum mob encontrado"
        },
        callback = function(option)
            State.TargetMob = option

            print("[Farm] Target Mob:", option)
        end,
    })

    -- Atualizar lista de mobs
    Tab:CreateButton({
        name = "Refresh Mobs",

        callback = function()
            print("[Farm] Atualizando lista de mobs...")

            -- Futuramente:
            -- detectar os mobs existentes no mapa
            -- e atualizar o dropdown
        end,
    })

    -- Farm automático
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

    -- Kill Aura
    Tab:CreateToggle({
        name = "Kill Aura",
        currentValue = false,

        callback = function(value)
            State.MobKillAura = value

            print(
                "[Farm] Mob Kill Aura:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- POSIÇÃO DO FARM
    -- =========================

    Tab:CreateParagraph({
        name = "Farm Position",
        content = "Define a posição relativa ao mob."
    })

    Tab:CreateSlider({
        name = "X Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 0,

        callback = function(value)
            State.FarmOffsetX = value
        end,
    })

    Tab:CreateSlider({
        name = "Y Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.FarmOffsetY = value
        end,
    })

    Tab:CreateSlider({
        name = "Z Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.FarmOffsetZ = value
        end,
    })

    Tab:CreateSlider({
        name = "Distance",
        range = {1, 50},
        increment = 1,
        currentValue = 10,

        callback = function(value)
            State.FarmDistance = value
        end,
    })

    -- =========================
    -- LOOT
    -- =========================

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

    -- =========================
    -- BOSS
    -- =========================

    Tab:CreateParagraph({
        name = "Boss",
        content = "Configurações para farm automático de bosses."
    })

    -- Boss selecionado
    local TargetBoss = Tab:CreateDropdown({
        name = "Target Boss",

        options = {
            "Nenhum boss encontrado"
        },

        currentOption = {
            "Nenhum boss encontrado"
        },

        callback = function(option)
            State.TargetBoss = option

            print("[Farm] Target Boss:", option)
        end,
    })

    -- Atualizar lista de bosses
    Tab:CreateButton({
        name = "Refresh Bosses",

        callback = function()
            print("[Farm] Atualizando lista de bosses...")

            -- Futuramente:
            -- procurar bosses existentes no jogo
            -- atualizar TargetBoss
        end,
    })

    -- Farm automático de boss
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

    -- =========================
    -- AUTO QUEST
    -- =========================

    Tab:CreateParagraph({
        name = "Auto Quest",
        content = "Configurações para gerenciamento automático de quests."
    })

    -- Quest selecionada
    local TargetQuest = Tab:CreateDropdown({
        name = "Quest",

        options = {
            "Nenhuma quest encontrada"
        },

        currentOption = {
            "Nenhuma quest encontrada"
        },

        callback = function(option)
            State.TargetQuest = option

            print("[Farm] Quest selecionada:", option)
        end,
    })

    -- Atualizar quests
    Tab:CreateButton({
        name = "Refresh Quests",

        callback = function()
            print("[Farm] Atualizando lista de quests...")

            -- Futuramente:
            -- localizar quests disponíveis
            -- montar a lista
            -- atualizar TargetQuest
        end,
    })

    -- Auto Quest
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

    -- =========================
    -- FARM PLAYERS
    -- =========================

    Tab:CreateParagraph({
        name = "Farm Players",
        content = "Configurações para interação com jogadores."
    })

    -- Jogador selecionado
    local TargetPlayer = Tab:CreateDropdown({
        name = "Target Player",

        options = {
            "Nenhum jogador encontrado"
        },

        currentOption = {
            "Nenhum jogador encontrado"
        },

        callback = function(option)
            State.TargetPlayer = option

            print("[Farm] Target Player:", option)
        end,
    })

    -- Atualizar jogadores
    Tab:CreateButton({
        name = "Refresh Players",

        callback = function()
            print("[Farm] Atualizando lista de jogadores...")

            -- Futuramente:
            -- pegar os jogadores atuais
            -- atualizar o dropdown
        end,
    })

    -- Farm Player
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

    -- Kill Aura
    Tab:CreateToggle({
        name = "Kill Aura",
        currentValue = false,

        callback = function(value)
            State.PlayerKillAura = value

            print(
                "[Farm] Player Kill Aura:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- PLAYER FARM POSITION
    -- =========================

    Tab:CreateParagraph({
        name = "Farm Position",
        content = "Define a posição relativa ao jogador alvo."
    })

    Tab:CreateSlider({
        name = "X Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 0,

        callback = function(value)
            State.PlayerFarmOffsetX = value
        end,
    })

    Tab:CreateSlider({
        name = "Y Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.PlayerFarmOffsetY = value
        end,
    })

    Tab:CreateSlider({
        name = "Z Offset",
        range = {-50, 50},
        increment = 1,
        currentValue = 5,

        callback = function(value)
            State.PlayerFarmOffsetZ = value
        end,
    })

    Tab:CreateSlider({
        name = "Distance",
        range = {1, 50},
        increment = 1,
        currentValue = 10,

        callback = function(value)
            State.PlayerFarmDistance = value
        end,
    })

end

return FarmUI