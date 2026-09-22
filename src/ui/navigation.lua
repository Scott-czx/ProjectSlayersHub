local NavigationUI = {}

local function NormalizeDropdownValue(option)
    if type(option) == "table" then
        return option[1]
    end

    return option
end

function NavigationUI.Init(Tab, State)

    if Tab == nil then
        error("[NavigationUI] Tab inválida.")
    end

    if type(State) ~= "table" then
        error("[NavigationUI] State inválido.")
    end

    print("[UI] Navigation inicializado.")

    -- =========================
    -- COORDINATES
    -- =========================

    Tab:CreateText({
        name = "Coordinates",
        text = "Ferramentas para visualizar e trabalhar com coordenadas."
    })

    Tab:CreateText({
        name = "Current Position",
        text = "X: 0 | Y: 0 | Z: 0"
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
        value = State.ClickTP or false,

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

    Tab:CreateText({
        name = "Teleport Settings",
        text = "Configurações relacionadas ao destino."
    })

    Tab:CreateSlider({
        name = "Tween Speed",
        range = {10, 500},
        increment = 10,
        value = State.TweenSpeed or 100,
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
        value = State.TweenBypass or false,

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

    Tab:CreateText({
        name = "Place",
        text = "Selecione um destino predefinido."
    })

    local SelectPlace = Tab:CreateDropdown({
        name = "Select Place",

        options = {
            "Nenhum lugar encontrado"
        },

        value = State.SelectedPlace or "Nenhum lugar encontrado",

        callback = function(option)

            local value = NormalizeDropdownValue(option)

            if value == "Nenhum lugar encontrado" then
                State.SelectedPlace = nil
            else
                State.SelectedPlace = value
            end

            print(
                "[Navigation] Select Place:",
                State.SelectedPlace
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

    Tab:CreateText({
        name = "Teleports",
        text = "Teletransportes para NPCs, jogadores, mobs e regiões."
    })

    -- NPC Teleport

    local SelectNPC = Tab:CreateDropdown({
        name = "NPC Teleport",

        options = {
            "Nenhum NPC encontrado"
        },

        value = State.SelectedNPC or "Nenhum NPC encontrado",

        callback = function(option)

            local value = NormalizeDropdownValue(option)

            if value == "Nenhum NPC encontrado" then
                State.SelectedNPC = nil
            else
                State.SelectedNPC = value
            end

            print(
                "[Navigation] NPC selecionado:",
                State.SelectedNPC
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

        value = State.SelectedTeleportPlayer or "Nenhum jogador encontrado",

        callback = function(option)

            local value = NormalizeDropdownValue(option)

            if value == "Nenhum jogador encontrado" then
                State.SelectedTeleportPlayer = nil
            else
                State.SelectedTeleportPlayer = value
            end

            print(
                "[Navigation] Player selecionado:",
                State.SelectedTeleportPlayer
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

        value = State.SelectedTeleportMob or "Nenhum mob encontrado",

        callback = function(option)

            local value = NormalizeDropdownValue(option)

            if value == "Nenhum mob encontrado" then
                State.SelectedTeleportMob = nil
            else
                State.SelectedTeleportMob = value
            end

            print(
                "[Navigation] Mob selecionado:",
                State.SelectedTeleportMob
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

        value = State.SelectedRegion or "Nenhuma região encontrada",

        callback = function(option)

            local value = NormalizeDropdownValue(option)

            if value == "Nenhuma região encontrada" then
                State.SelectedRegion = nil
            else
                State.SelectedRegion = value
            end

            print(
                "[Navigation] Região selecionada:",
                State.SelectedRegion
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

    Tab:CreateText({
        name = "Special Teleports",
        text = "Teletransportes especiais e recursos de movimentação."
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
        value = State.SpiderLilyFarm or false,

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

    Tab:CreateText({
        name = "Attach",
        text = "Configurações para selecionar e acompanhar um alvo."
    })

    local AttachTarget = Tab:CreateDropdown({
        name = "Attach Target",

        options = {
            "Nenhum alvo encontrado"
        },

        value = State.AttachTarget or "Nenhum alvo encontrado",

        callback = function(option)

            local value = NormalizeDropdownValue(option)

            if value == "Nenhum alvo encontrado" then
                State.AttachTarget = nil
            else
                State.AttachTarget = value
            end

            print(
                "[Navigation] Attach Target:",
                State.AttachTarget
            )
        end,
    })

    local AttachPlayer = Tab:CreateDropdown({
        name = "Attach Player",

        options = {
            "Nenhum jogador encontrado"
        },

        value = State.AttachPlayer or "Nenhum jogador encontrado",

        callback = function(option)

            local value = NormalizeDropdownValue(option)

            if value == "Nenhum jogador encontrado" then
                State.AttachPlayer = nil
            else
                State.AttachPlayer = value
            end

            print(
                "[Navigation] Attach Player:",
                State.AttachPlayer
            )
        end,
    })

    Tab:CreateSlider({
        name = "Attach Range",
        range = {1, 100},
        increment = 1,
        value = State.AttachRange or 25,
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
        value = State.AttachDistance or 5,
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
        value = State.AttachHeight or 0,
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
        value = State.AttachTargetEnabled or false,

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
        value = State.AttachPlayerEnabled or false,

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

    Tab:CreateText({
        name = "Fling",
        text = "Controles de teste relacionados ao alvo selecionado."
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
        value = State.AntiFling or false,

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

    print("[UI] Navigation UI carregada com sucesso.")

    return NavigationUI
end

return NavigationUI