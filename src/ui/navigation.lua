local NavigationUI = {}

function NavigationUI.Init(Tab, State)

    print("[UI] Navigation inicializado.")

    -- =========================
    -- COORDINATES
    -- =========================

    Tab:CreateParagraph({
        name = "Coordinates",
        content = "Ferramentas para visualizar e trabalhar com coordenadas."
    })

    Tab:CreateParagraph({
        name = "Current Position",
        content = "X: 0 | Y: 0 | Z: 0"
    })

    Tab:CreateButton({
        name = "Tween To",
        callback = function()
            State.TweenToRequested = true

            print(
                "[Navigation] Tween To solicitado."
            )
        end,
    })

    Tab:CreateButton({
        name = "Copy Position",
        callback = function()
            State.CopyPositionRequested = true

            print(
                "[Navigation] Copy Position solicitado."
            )
        end,
    })

    Tab:CreateToggle({
        name = "Click TP",
        currentValue = false,

        callback = function(value)
            State.ClickTP = value

            print(
                "[Navigation] Click TP:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- TELEPORT SETTINGS
    -- =========================

    Tab:CreateParagraph({
        name = "Teleport Settings",
        content = "Configurações relacionadas ao destino."
    })

    Tab:CreateSlider({
        name = "Tween Speed",
        range = {10, 500},
        increment = 10,
        currentValue = 100,
        suffix = " studs/s",

        callback = function(value)
            State.TweenSpeed = value

            print(
                "[Navigation] Tween Speed:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Tween Bypass",
        currentValue = false,

        callback = function(value)
            State.TweenBypass = value

            print(
                "[Navigation] Tween Bypass:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- PLACE
    -- =========================

    Tab:CreateParagraph({
        name = "Place",
        content = "Selecione um destino predefinido."
    })

    local SelectPlace = Tab:CreateDropdown({
        name = "Select Place",
        options = {
            "Nenhum lugar encontrado"
        },

        currentOption = {
            "Nenhum lugar encontrado"
        },

        callback = function(option)
            State.SelectedPlace = option

            print(
                "[Navigation] Select Place:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh Places",
        callback = function()
            State.RefreshPlacesRequested = true

            print(
                "[Navigation] Refresh Places solicitado."
            )
        end,
    })

    Tab:CreateButton({
        name = "Teleport To Place",
        callback = function()
            State.TeleportToPlaceRequested = true

            print(
                "[Navigation] Teleport To Place solicitado."
            )
        end,
    })

    -- =========================
    -- TELEPORTS
    -- =========================

    Tab:CreateParagraph({
        name = "Teleports",
        content = "Teletransportes para NPCs, jogadores, mobs e regiões."
    })

    -- NPC Teleport

    local SelectNPC = Tab:CreateDropdown({
        name = "NPC Teleport",
        options = {
            "Nenhum NPC encontrado"
        },

        currentOption = {
            "Nenhum NPC encontrado"
        },

        callback = function(option)
            State.SelectedNPC = option

            print(
                "[Navigation] NPC selecionado:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Teleport To NPC",
        callback = function()
            State.TeleportToNPCRequested = true

            print(
                "[Navigation] Teleport To NPC solicitado."
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh NPCs",
        callback = function()
            State.RefreshNPCsRequested = true

            print(
                "[Navigation] Refresh NPCs solicitado."
            )
        end,
    })

    -- Player Teleport

    local SelectTeleportPlayer = Tab:CreateDropdown({
        name = "Player Teleport",
        options = {
            "Nenhum jogador encontrado"
        },

        currentOption = {
            "Nenhum jogador encontrado"
        },

        callback = function(option)
            State.SelectedTeleportPlayer = option

            print(
                "[Navigation] Player selecionado:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Teleport To Player",
        callback = function()
            State.TeleportToPlayerRequested = true

            print(
                "[Navigation] Teleport To Player solicitado."
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh Players",
        callback = function()
            State.RefreshTeleportPlayersRequested = true

            print(
                "[Navigation] Refresh Players solicitado."
            )
        end,
    })

    -- Mob Teleport

    local SelectMob = Tab:CreateDropdown({
        name = "Mob Teleport",
        options = {
            "Nenhum mob encontrado"
        },

        currentOption = {
            "Nenhum mob encontrado"
        },

        callback = function(option)
            State.SelectedTeleportMob = option

            print(
                "[Navigation] Mob selecionado:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Teleport To Mob",
        callback = function()
            State.TeleportToMobRequested = true

            print(
                "[Navigation] Teleport To Mob solicitado."
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh Mobs",
        callback = function()
            State.RefreshTeleportMobsRequested = true

            print(
                "[Navigation] Refresh Mobs solicitado."
            )
        end,
    })

    -- Region Teleport

    local SelectRegion = Tab:CreateDropdown({
        name = "Region Teleport",
        options = {
            "Nenhuma região encontrada"
        },

        currentOption = {
            "Nenhuma região encontrada"
        },

        callback = function(option)
            State.SelectedRegion = option

            print(
                "[Navigation] Região selecionada:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Teleport To Region",
        callback = function()
            State.TeleportToRegionRequested = true

            print(
                "[Navigation] Teleport To Region solicitado."
            )
        end,
    })

    -- =========================
    -- SPECIAL TELEPORTS
    -- =========================

    Tab:CreateParagraph({
        name = "Special Teleports",
        content = "Teletransportes especiais e recursos de movimentação."
    })

    Tab:CreateButton({
        name = "Teleport to Spawn Crystal",
        callback = function()
            State.TeleportSpawnCrystalRequested = true

            print(
                "[Navigation] Teleport to Spawn Crystal solicitado."
            )
        end,
    })

    Tab:CreateToggle({
        name = "Spider Lily Farm",
        currentValue = false,

        callback = function(value)
            State.SpiderLilyFarm = value

            print(
                "[Navigation] Spider Lily Farm:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateButton({
        name = "TP to Nearest Lily",
        callback = function()
            State.TeleportNearestLilyRequested = true

            print(
                "[Navigation] TP to Nearest Lily solicitado."
            )
        end,
    })

    -- =========================
    -- ATTACH
    -- =========================

    Tab:CreateParagraph({
        name = "Attach",
        content = "Configurações para selecionar e acompanhar um alvo."
    })

    local AttachTarget = Tab:CreateDropdown({
        name = "Attach Target",
        options = {
            "Nenhum alvo encontrado"
        },

        currentOption = {
            "Nenhum alvo encontrado"
        },

        callback = function(option)
            State.AttachTarget = option

            print(
                "[Navigation] Attach Target:",
                option
            )
        end,
    })

    local AttachPlayer = Tab:CreateDropdown({
        name = "Attach Player",
        options = {
            "Nenhum jogador encontrado"
        },

        currentOption = {
            "Nenhum jogador encontrado"
        },

        callback = function(option)
            State.AttachPlayer = option

            print(
                "[Navigation] Attach Player:",
                option
            )
        end,
    })

    Tab:CreateSlider({
        name = "Attach Range",
        range = {1, 100},
        increment = 1,
        currentValue = 25,
        suffix = " studs",

        callback = function(value)
            State.AttachRange = value

            print(
                "[Navigation] Attach Range:",
                value
            )
        end,
    })

    Tab:CreateSlider({
        name = "Attach Distance",
        range = {1, 100},
        increment = 1,
        currentValue = 5,
        suffix = " studs",

        callback = function(value)
            State.AttachDistance = value

            print(
                "[Navigation] Attach Distance:",
                value
            )
        end,
    })

    Tab:CreateSlider({
        name = "Attach Height",
        range = {-50, 50},
        increment = 1,
        currentValue = 0,
        suffix = " studs",

        callback = function(value)
            State.AttachHeight = value

            print(
                "[Navigation] Attach Height:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Attach Target Enabled",
        currentValue = false,

        callback = function(value)
            State.AttachTargetEnabled = value

            print(
                "[Navigation] Attach Target:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Attach Player Enabled",
        currentValue = false,

        callback = function(value)
            State.AttachPlayerEnabled = value

            print(
                "[Navigation] Attach Player:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- FLING
    -- =========================

    Tab:CreateParagraph({
        name = "Fling",
        content = "Controles de teste relacionados ao alvo selecionado."
    })

    Tab:CreateButton({
        name = "Fling Target",
        callback = function()
            State.FlingTargetRequested = true

            print(
                "[Navigation] Fling Target solicitado."
            )
        end,
    })

    Tab:CreateButton({
        name = "Fling Player",
        callback = function()
            State.FlingPlayerRequested = true

            print(
                "[Navigation] Fling Player solicitado."
            )
        end,
    })

    Tab:CreateToggle({
        name = "Anti Fling",
        currentValue = false,

        callback = function(value)
            State.AntiFling = value

            print(
                "[Navigation] Anti Fling:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh Attach Targets",
        callback = function()
            State.RefreshAttachTargetsRequested = true

            print(
                "[Navigation] Refresh Attach Targets solicitado."
            )
        end,
    })

    -- =========================
    -- ELEMENT REFERENCES
    -- =========================

    State.NavigationElements = {
        SelectPlace = SelectPlace,
        SelectNPC = SelectNPC,
        SelectTeleportPlayer = SelectTeleportPlayer,
        SelectMob = SelectMob,
        SelectRegion = SelectRegion,
        AttachTarget = AttachTarget,
        AttachPlayer = AttachPlayer,
    }

    print("[UI] Navigation carregado.")

end

return NavigationUI