local ESPUI = {}

local function NormalizeDropdownValue(option)
    if type(option) == "table" then
        return option[1]
    end

    return option
end

function ESPUI.Init(Tab, State)

    print("[UI] ESP inicializado.")

    ------------------------------------------------------------
    -- PLAYER ESP
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Player ESP",
        text = "Configurações de ESP para jogadores."
    })

    Tab:CreateToggle({
        name = "Player ESP",
        value = false,

        callback = function(value)
            State.PlayerESP = value

            print(
                "[ESP] Player ESP:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateColorPicker({
        name = "Player ESP Color",
        color = State.PlayerESPColor or Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.PlayerESPColor = value

            print("[ESP] Player ESP Color alterada.")
        end,
    })

    Tab:CreateToggle({
        name = "Show Local Player",
        value = false,

        callback = function(value)
            State.ShowLocalPlayer = value

            print(
                "[ESP] Show Local Player:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- MOB ESP
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Mob ESP",
        text = "Configurações de ESP para mobs."
    })

    Tab:CreateToggle({
        name = "Mob ESP",
        value = false,

        callback = function(value)
            State.MobESP = value

            print(
                "[ESP] Mob ESP:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateColorPicker({
        name = "Mob ESP Color",
        color = State.MobESPColor or Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.MobESPColor = value

            print("[ESP] Mob ESP Color alterada.")
        end,
    })

    ------------------------------------------------------------
    -- NPC ESP
    ------------------------------------------------------------

    Tab:CreateText({
        name = "NPC ESP",
        text = "Configurações de ESP para NPCs."
    })

    Tab:CreateToggle({
        name = "NPC ESP",
        value = false,

        callback = function(value)
            State.NPCESP = value

            print(
                "[ESP] NPC ESP:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateColorPicker({
        name = "NPC ESP Color",
        color = State.NPCESPColor or Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.NPCESPColor = value

            print("[ESP] NPC ESP Color alterada.")
        end,
    })

    ------------------------------------------------------------
    -- ESP TARGET
    ------------------------------------------------------------

    Tab:CreateText({
        name = "ESP Target",
        text = "Configurações para selecionar um jogador específico."
    })

    local ESPTargetElement = Tab:CreateDropdown({
        name = "ESP Target",
        description = "Selecione o jogador que será armazenado como alvo.",
        options = {
            "Nenhum jogador encontrado"
        },
        value = "Nenhum jogador encontrado",

        callback = function(option)
            local value = NormalizeDropdownValue(option)

            if value == "Nenhum jogador encontrado" then
                State.ESPTarget = nil
            else
                State.ESPTarget = value
            end

            print(
                "[ESP] Target:",
                State.ESPTarget
            )
        end,
    })

    State.ESPTargetElement = ESPTargetElement

    Tab:CreateButton({
        name = "Refresh",
        description = "Solicita atualização da lista de jogadores.",

        callback = function()
            State.ESPRefreshRequested = true

            print(
                "[ESP] Atualização de jogadores solicitada."
            )
        end,
    })

    Tab:CreateToggle({
        name = "ESP Single Player",
        value = false,

        callback = function(value)
            State.ESPSinglePlayer = value

            print(
                "[ESP] ESP Single Player:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "ESP Nearest Only",
        value = false,

        callback = function(value)
            State.ESPNearestOnly = value

            print(
                "[ESP] ESP Nearest Only:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- ESP CONFIG
    ------------------------------------------------------------

    Tab:CreateText({
        name = "ESP Config",
        text = "Configurações visuais dos elementos de ESP."
    })

    Tab:CreateToggle({
        name = "Boxes",
        value = false,

        callback = function(value)
            State.ESPBoxes = value

            print(
                "[ESP] Boxes:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Box Glow",
        value = false,

        callback = function(value)
            State.ESPBoxGlow = value

            print(
                "[ESP] Box Glow:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Chams",
        value = false,

        callback = function(value)
            State.ESPChams = value

            print(
                "[ESP] Chams:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Name",
        value = true,

        callback = function(value)
            State.ESPName = value
        end,
    })

    Tab:CreateToggle({
        name = "Distance",
        value = true,

        callback = function(value)
            State.ESPDistance = value
        end,
    })

    Tab:CreateToggle({
        name = "Health Bar",
        value = true,

        callback = function(value)
            State.ESPHealthBar = value
        end,
    })

    Tab:CreateToggle({
        name = "Weapon",
        value = false,

        callback = function(value)
            State.ESPWeapon = value
        end,
    })

    Tab:CreateSlider({
        name = "Max Distance",
        range = {50, 2000},
        increment = 50,
        value = State.ESPMaxDistance or 500,
        suffix = " studs",

        callback = function(value)
            State.ESPMaxDistance = value
        end,
    })

    Tab:CreateDropdown({
        name = "Box Type",
        description = "Escolha o formato visual do box.",
        options = {
            "Full",
            "Corner",
            "2D"
        },
        value = State.ESPBoxType or "Full",

        callback = function(option)
            local value = NormalizeDropdownValue(option)

            State.ESPBoxType = value

            print(
                "[ESP] Box Type:",
                value
            )
        end,
    })

    ------------------------------------------------------------
    -- GLOW
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Glow",
        text = "Configurações de transparência do Box Glow."
    })

    Tab:CreateSlider({
        name = "Glow Top Trans",
        range = {0, 100},
        increment = 1,
        value = State.GlowTopTransparency or 50,
        suffix = "%",

        callback = function(value)
            State.GlowTopTransparency = value
        end,
    })

    Tab:CreateSlider({
        name = "Glow Bot Trans",
        range = {0, 100},
        increment = 1,
        value = State.GlowBottomTransparency or 50,
        suffix = "%",

        callback = function(value)
            State.GlowBottomTransparency = value
        end,
    })

    ------------------------------------------------------------
    -- CHAMS
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Chams",
        text = "Configurações visuais dos Chams."
    })

    Tab:CreateSlider({
        name = "Chams Fill Trans",
        range = {0, 100},
        increment = 1,
        value = State.ChamsFillTransparency or 50,
        suffix = "%",

        callback = function(value)
            State.ChamsFillTransparency = value
        end,
    })

    Tab:CreateColorPicker({
        name = "Chams Color",
        color = State.ChamsColor or Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.ChamsColor = value
        end,
    })

    ------------------------------------------------------------
    -- BOX COLORS
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Box Colors",
        text = "Configurações das cores superior e inferior dos boxes."
    })

    Tab:CreateColorPicker({
        name = "Box Top",
        color = State.BoxTopColor or Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.BoxTopColor = value
        end,
    })

    Tab:CreateColorPicker({
        name = "Box Bottom",
        color = State.BoxBottomColor or Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.BoxBottomColor = value
        end,
    })

    ------------------------------------------------------------
    -- DEBUG
    ------------------------------------------------------------

    Tab:CreateText({
        name = "ESP Debug",
        text = "Ferramentas de diagnóstico da configuração de ESP."
    })

    Tab:CreateButton({
        name = "ESP Debug Test",
        description = "Mostra os valores atuais do State.",

        callback = function()

            print("================================")
            print("[ESPUI] DEBUG")
            print("================================")

            print("PlayerESP:", State.PlayerESP)
            print("MobESP:", State.MobESP)
            print("NPCESP:", State.NPCESP)
            print("ESPTarget:", State.ESPTarget)
            print("ESPSinglePlayer:", State.ESPSinglePlayer)
            print("ESPNearestOnly:", State.ESPNearestOnly)

            print("ESPBoxes:", State.ESPBoxes)
            print("ESPBoxGlow:", State.ESPBoxGlow)
            print("ESPChams:", State.ESPChams)
            print("ESPName:", State.ESPName)
            print("ESPDistance:", State.ESPDistance)
            print("ESPHealthBar:", State.ESPHealthBar)
            print("ESPWeapon:", State.ESPWeapon)

            print("ESPMaxDistance:", State.ESPMaxDistance)
            print("ESPBoxType:", State.ESPBoxType)

            print("GlowTopTransparency:", State.GlowTopTransparency)
            print("GlowBottomTransparency:", State.GlowBottomTransparency)
            print("ChamsFillTransparency:", State.ChamsFillTransparency)

            print("================================")

        end,
    })

    print("[UI] ESP UI carregada com sucesso.")

    return ESPUI
end

return ESPUI