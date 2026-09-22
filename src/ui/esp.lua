local ESPUI = {}

function ESPUI.Init(Tab, State)

    print("[UI] ESP inicializado.")

    -- =========================
    -- PLAYER ESP
    -- =========================

    Tab:CreateParagraph({
        name = "Player ESP",
        content = "Configurações de ESP para jogadores."
    })

    Tab:CreateToggle({
        name = "Player ESP",
        currentValue = false,

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
        color = Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.PlayerESPColor = value

            print("[ESP] Player ESP Color alterada.")
        end,
    })

    Tab:CreateToggle({
        name = "Show Local Player",
        currentValue = false,

        callback = function(value)
            State.ShowLocalPlayer = value

            print(
                "[ESP] Show Local Player:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- MOB ESP
    -- =========================

    Tab:CreateParagraph({
        name = "Mob ESP",
        content = "Configurações de ESP para mobs."
    })

    Tab:CreateToggle({
        name = "Mob ESP",
        currentValue = false,

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
        color = Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.MobESPColor = value

            print("[ESP] Mob ESP Color alterada.")
        end,
    })

    -- =========================
    -- NPC ESP
    -- =========================

    Tab:CreateParagraph({
        name = "NPC ESP",
        content = "Configurações de ESP para NPCs."
    })

    Tab:CreateToggle({
        name = "NPC ESP",
        currentValue = false,

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
        color = Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.NPCESPColor = value

            print("[ESP] NPC ESP Color alterada.")
        end,
    })

    -- =========================
    -- ESP TARGET
    -- =========================

    Tab:CreateParagraph({
        name = "ESP Target",
        content = "Configurações para selecionar um jogador específico."
    })

    local ESPTarget = Tab:CreateDropdown({
        name = "ESP Target",
        options = {
            "Nenhum jogador encontrado"
        },

        currentOption = {
            "Nenhum jogador encontrado"
        },

        callback = function(option)
            State.ESPTarget = option

            print(
                "[ESP] Target:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh",
        callback = function()
            State.ESPRefreshRequested = true

            print("[ESP] Atualização de jogadores solicitada.")
        end,
    })

    Tab:CreateToggle({
        name = "ESP Single Player",
        currentValue = false,

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
        currentValue = false,

        callback = function(value)
            State.ESPNearestOnly = value

            print(
                "[ESP] ESP Nearest Only:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- ESP CONFIG
    -- =========================

    Tab:CreateParagraph({
        name = "ESP Config",
        content = "Configurações visuais dos elementos de ESP."
    })

    Tab:CreateToggle({
        name = "Boxes",
        currentValue = false,

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
        currentValue = false,

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
        currentValue = false,

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
        currentValue = true,

        callback = function(value)
            State.ESPName = value
        end,
    })

    Tab:CreateToggle({
        name = "Distance",
        currentValue = true,

        callback = function(value)
            State.ESPDistance = value
        end,
    })

    Tab:CreateToggle({
        name = "Health Bar",
        currentValue = true,

        callback = function(value)
            State.ESPHealthBar = value
        end,
    })

    Tab:CreateToggle({
        name = "Weapon",
        currentValue = false,

        callback = function(value)
            State.ESPWeapon = value
        end,
    })

    Tab:CreateSlider({
        name = "Max Distance",
        range = {50, 2000},
        increment = 50,
        currentValue = 500,
        suffix = " studs",

        callback = function(value)
            State.ESPMaxDistance = value
        end,
    })

    Tab:CreateDropdown({
        name = "Box Type",
        options = {
            "Full",
            "Corner",
            "2D"
        },

        currentOption = {
            "Full"
        },

        callback = function(option)
            State.ESPBoxType = option

            print(
                "[ESP] Box Type:",
                option
            )
        end,
    })

    -- =========================
    -- GLOW
    -- =========================

    Tab:CreateParagraph({
        name = "Glow",
        content = "Configurações de transparência do Box Glow."
    })

    Tab:CreateSlider({
        name = "Glow Top Trans",
        range = {0, 100},
        increment = 1,
        currentValue = 50,
        suffix = "%",

        callback = function(value)
            State.GlowTopTransparency = value
        end,
    })

    Tab:CreateSlider({
        name = "Glow Bot Trans",
        range = {0, 100},
        increment = 1,
        currentValue = 50,
        suffix = "%",

        callback = function(value)
            State.GlowBottomTransparency = value
        end,
    })

    -- =========================
    -- CHAMS
    -- =========================

    Tab:CreateParagraph({
        name = "Chams",
        content = "Configurações visuais dos Chams."
    })

    Tab:CreateSlider({
        name = "Chams Fill Trans",
        range = {0, 100},
        increment = 1,
        currentValue = 50,
        suffix = "%",

        callback = function(value)
            State.ChamsFillTransparency = value
        end,
    })

    Tab:CreateColorPicker({
        name = "Chams Color",
        color = Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.ChamsColor = value
        end,
    })

    -- =========================
    -- BOX COLORS
    -- =========================

    Tab:CreateParagraph({
        name = "Box Colors",
        content = "Configurações das cores superior e inferior dos boxes."
    })

    Tab:CreateColorPicker({
        name = "Box Top",
        color = Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.BoxTopColor = value
        end,
    })

    Tab:CreateColorPicker({
        name = "Box Bottom",
        color = Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.BoxBottomColor = value
        end,
    })

end

return ESPUI