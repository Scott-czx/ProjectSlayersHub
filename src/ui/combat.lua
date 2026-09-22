local CombatUI = {}

function CombatUI.Init(Tab, State)

    print("[UI] Combat inicializado.")

    -- =========================
    -- COMBAT
    -- =========================

    Tab:CreateParagraph({
        name = "Combat",
        content = "Configurações gerais de combate."
    })

    -- Kill Aura
    Tab:CreateToggle({
        name = "Kill Aura",
        currentValue = false,

        callback = function(value)
            State.CombatKillAura = value

            print(
                "[Combat] Kill Aura:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Velocidade da Kill Aura
    Tab:CreateSlider({
        name = "Kill Aura Speed",
        range = {1, 100},
        increment = 1,
        currentValue = 10,

        callback = function(value)
            State.KillAuraSpeed = value

            print(
                "[Combat] Kill Aura Speed:",
                value
            )
        end,
    })

    -- Insta Kill
    Tab:CreateToggle({
        name = "Insta Kill",
        currentValue = false,

        callback = function(value)
            State.InstaKill = value

            print(
                "[Combat] Insta Kill:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- HP Threshold
    Tab:CreateSlider({
        name = "HP Threshold",
        range = {1, 100},
        increment = 1,
        suffix = "%",
        currentValue = 100,

        callback = function(value)
            State.HPThreshold = value

            print(
                "[Combat] HP Threshold:",
                value .. "%"
            )
        end,
    })

    -- Range
    Tab:CreateSlider({
        name = "Range",
        range = {1, 100},
        increment = 1,
        currentValue = 25,

        callback = function(value)
            State.CombatRange = value

            print(
                "[Combat] Range:",
                value
            )
        end,
    })

    -- =========================
    -- NETWORK
    -- =========================

    Tab:CreateParagraph({
        name = "Network",
        content = "Informações relacionadas à rede e ownership."
    })

    Tab:CreateToggle({
        name = "Show Ownership",
        currentValue = false,

        callback = function(value)
            State.ShowOwnership = value

            print(
                "[Combat] Show Ownership:",
                value and "ON" or "OFF"
            )
        end,
    })

end

return CombatUI