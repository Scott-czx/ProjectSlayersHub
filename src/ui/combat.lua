local CombatUI = {}

function CombatUI.Init(Tab, State)

    print("[UI] Combat inicializado.")

    ------------------------------------------------------------
    -- COMBAT
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Combat",
        text = "Configurações gerais de combate."
    })

    ------------------------------------------------------------
    -- KILL AURA
    ------------------------------------------------------------

    Tab:CreateToggle({
        name = "Kill Aura",
        value = false,

        callback = function(value)
            State.CombatKillAura = value

            print(
                "[Combat] Kill Aura:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- KILL AURA SPEED
    ------------------------------------------------------------

    Tab:CreateSlider({
        name = "Kill Aura Speed",
        range = {1, 100},
        increment = 1,
        value = State.KillAuraSpeed or 10,

        callback = function(value)
            State.KillAuraSpeed = value

            print(
                "[Combat] Kill Aura Speed:",
                value
            )
        end,
    })

    ------------------------------------------------------------
    -- INSTA KILL
    ------------------------------------------------------------

    Tab:CreateToggle({
        name = "Insta Kill",
        value = false,

        callback = function(value)
            State.InstaKill = value

            print(
                "[Combat] Insta Kill:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- HP THRESHOLD
    ------------------------------------------------------------

    Tab:CreateSlider({
        name = "HP Threshold",
        range = {1, 100},
        increment = 1,
        suffix = "%",
        value = State.HPThreshold or 100,

        callback = function(value)
            State.HPThreshold = value

            print(
                "[Combat] HP Threshold:",
                value .. "%"
            )
        end,
    })

    ------------------------------------------------------------
    -- RANGE
    ------------------------------------------------------------

    Tab:CreateSlider({
        name = "Range",
        range = {1, 100},
        increment = 1,
        value = State.CombatRange or 25,

        callback = function(value)
            State.CombatRange = value

            print(
                "[Combat] Range:",
                value
            )
        end,
    })

    ------------------------------------------------------------
    -- NETWORK
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Network",
        text = "Informações relacionadas à rede e ownership."
    })

    Tab:CreateToggle({
        name = "Show Ownership",
        value = false,

        callback = function(value)
            State.ShowOwnership = value

            print(
                "[Combat] Show Ownership:",
                value and "ON" or "OFF"
            )
        end,
    })

    print("[UI] Combat UI carregada com sucesso.")

end

return CombatUI