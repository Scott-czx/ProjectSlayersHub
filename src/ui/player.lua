local PlayerUI = {}

function PlayerUI.Init(Tab, State)

    print("[UI] Player inicializado.")

    -- =========================
    -- MOVEMENT
    -- =========================

    Tab:CreateParagraph({
        name = "Movement",
        content = "Configurações de movimentação do jogador."
    })

    -- Fly
    Tab:CreateToggle({
        name = "Fly",
        currentValue = false,

        callback = function(value)
            State.Fly = value

            print(
                "[Player] Fly:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Fly Speed
    Tab:CreateSlider({
        name = "Fly Speed",
        range = {1, 200},
        increment = 1,
        currentValue = 50,

        callback = function(value)
            State.FlySpeed = value
        end,
    })

    -- Speedhack
    Tab:CreateToggle({
        name = "Speedhack",
        currentValue = false,

        callback = function(value)
            State.Speedhack = value

            print(
                "[Player] Speedhack:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Speed
    Tab:CreateSlider({
        name = "Speed",
        range = {1, 200},
        increment = 1,
        currentValue = 16,

        callback = function(value)
            State.WalkSpeed = value
        end,
    })

    -- Infinite Jump
    Tab:CreateToggle({
        name = "Infinite Jump",
        currentValue = false,

        callback = function(value)
            State.InfiniteJump = value

            print(
                "[Player] Infinite Jump:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Jump Height
    Tab:CreateSlider({
        name = "Jump Height",
        range = {1, 200},
        increment = 1,
        currentValue = 50,

        callback = function(value)
            State.JumpHeight = value
        end,
    })

    -- Ignore Jump Lock
    Tab:CreateToggle({
        name = "Ignore Jump Lock",
        currentValue = false,

        callback = function(value)
            State.IgnoreJumpLock = value

            print(
                "[Player] Ignore Jump Lock:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Bunny Hop
    Tab:CreateToggle({
        name = "Bunny Hop",
        currentValue = false,

        callback = function(value)
            State.BunnyHop = value

            print(
                "[Player] Bunny Hop:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Noclip
    Tab:CreateToggle({
        name = "Noclip",
        currentValue = false,

        callback = function(value)
            State.Noclip = value

            print(
                "[Player] Noclip:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- UTILITY
    -- =========================

    Tab:CreateParagraph({
        name = "Utility",
        content = "Utilidades do jogador."
    })

    -- No Anims
    Tab:CreateToggle({
        name = "No Anims",
        currentValue = false,

        callback = function(value)
            State.NoAnims = value

            print(
                "[Player] No Anims:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Anim Speed
    Tab:CreateSlider({
        name = "Anim Speed",
        range = {0, 5},
        increment = 0.1,
        currentValue = 1,

        callback = function(value)
            State.AnimSpeed = value
        end,
    })

    -- Speed
    Tab:CreateSlider({
        name = "Utility Speed",
        range = {0, 200},
        increment = 1,
        currentValue = 16,

        callback = function(value)
            State.UtilitySpeed = value
        end,
    })

    -- Anti AFK
    Tab:CreateToggle({
        name = "Anti AFK",
        currentValue = false,

        callback = function(value)
            State.AntiAFK = value

            print(
                "[Player] Anti AFK:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Kill Self
    Tab:CreateButton({
        name = "Kill Self",

        callback = function()
            print("[Player] Kill Self acionado.")

            State.KillSelfRequested = true
        end,
    })

    -- TP Back on Death
    Tab:CreateToggle({
        name = "TP Back on Death",
        currentValue = false,

        callback = function(value)
            State.TPBackOnDeath = value

            print(
                "[Player] TP Back on Death:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- No Killbricks
    Tab:CreateToggle({
        name = "No Killbricks",
        currentValue = false,

        callback = function(value)
            State.NoKillbricks = value

            print(
                "[Player] No Killbricks:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- Anti Void
    Tab:CreateToggle({
        name = "Anti Void",
        currentValue = false,

        callback = function(value)
            State.AntiVoid = value

            print(
                "[Player] Anti Void:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- No Slow
    Tab:CreateToggle({
        name = "No Slow",
        currentValue = false,

        callback = function(value)
            State.NoSlow = value

            print(
                "[Player] No Slow:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- MISC
    -- =========================

    Tab:CreateParagraph({
        name = "Misc",
        content = "Configurações diversas do jogador e servidor."
    })

    Tab:CreateToggle({
        name = "Infinite Yield",
        currentValue = false,
        callback = function(value)
            State.InfiniteYield = value
            print("[Player] Infinite Yield:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "Auto Rejoin",
        currentValue = false,
        callback = function(value)
            State.AutoRejoin = value
            print("[Player] Auto Rejoin:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "Kick Timer",
        currentValue = false,
        callback = function(value)
            State.KickTimer = value
            print("[Player] Kick Timer:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateSlider({
        name = "Minutes",
        range = {1, 120},
        increment = 1,
        currentValue = 10,
        suffix = " min",
        callback = function(value)
            State.KickMinutes = value
        end,
    })

    Tab:CreateToggle({
        name = "Join/Leave Logger",
        currentValue = false,
        callback = function(value)
            State.JoinLeaveLogger = value
            print(
                "[Player] Join/Leave Logger:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateButton({
        name = "Server Hop",
        callback = function()
            State.ServerHopRequested = true
            print("[Player] Server Hop solicitado.")
        end,
    })

    Tab:CreateButton({
        name = "Rejoin Server",
        callback = function()
            State.RejoinServerRequested = true
            print("[Player] Rejoin Server solicitado.")
        end,
    })

    Tab:CreateParagraph({
        name = "Server Age",
        content = "Aguardando dados do servidor..."
    })

    Tab:CreateToggle({
        name = "Chat Logger",
        currentValue = false,
        callback = function(value)
            State.ChatLogger = value
            print("[Player] Chat Logger:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateInput({
        name = "Spam Message",
        placeholderText = "Digite a mensagem...",
        currentValue = "",
        removeTextAfterFocusLost = false,
        callback = function(text)
            State.SpamMessage = text
            print("[Player] Mensagem definida:", text)
        end,
    })

    Tab:CreateSlider({
        name = "Delay",
        range = {0.1, 10},
        increment = 0.1,
        currentValue = 1,
        suffix = " s",
        callback = function(value)
            State.ChatDelay = value
        end,
    })

    Tab:CreateToggle({
        name = "Chat Spammer",
        currentValue = false,
        callback = function(value)
            State.ChatSpammer = value
            print("[Player] Chat Spammer:", value and "ON" or "OFF")
        end,
    })

    -- =========================
    -- IDENTITY
    -- =========================

    Tab:CreateParagraph({
        name = "Identity",
        content = "Configurações de identidade e visibilidade do jogador."
    })

    Tab:CreateInput({
        name = "Display Name",
        placeholderText = "Novo Display Name...",
        currentValue = "",

        callback = function(value)
            State.DisplayName = value

            print(
                "[Player] Display Name:",
                value
            )
        end,
    })

    Tab:CreateInput({
        name = "Username",
        placeholderText = "Novo Username...",
        currentValue = "",

        callback = function(value)
            State.Username = value

            print(
                "[Player] Username:",
                value
            )
        end,
    })

    Tab:CreateButton({
        name = "Apply",
        callback = function()
            State.IdentityApplyRequested = true

            print("[Player] Apply Identity solicitado.")
        end,
    })

    Tab:CreateButton({
        name = "Reset",
        callback = function()
            State.IdentityResetRequested = true

            print("[Player] Reset Identity solicitado.")
        end,
    })

    Tab:CreateParagraph({
        name = "Player",
        content = "Selecione o jogador para as opções de identidade."
    })

    local IdentityPlayer = Tab:CreateDropdown({
        name = "Player",
        options = {
            "Nenhum jogador encontrado"
        },

        currentOption = {
            "Nenhum jogador encontrado"
        },

        callback = function(option)
            State.IdentityPlayer = option

            print(
                "[Player] Identity Player:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh",
        callback = function()
            State.IdentityRefreshRequested = true

            print("[Player] Atualizando jogadores...")
        end,
    })

    Tab:CreateToggle({
        name = "Hide Character",
        currentValue = false,

        callback = function(value)
            State.HideCharacter = value

            print(
                "[Player] Hide Character:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Hide Other Players",
        currentValue = false,

        callback = function(value)
            State.HideOtherPlayers = value

            print(
                "[Player] Hide Other Players:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Hide All Players",
        currentValue = false,

        callback = function(value)
            State.HideAllPlayers = value

            print(
                "[Player] Hide All Players:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Hide All Names",
        currentValue = false,

        callback = function(value)
            State.HideAllNames = value

            print(
                "[Player] Hide All Names:",
                value and "ON" or "OFF"
            )
        end,
    })

end

return PlayerUI