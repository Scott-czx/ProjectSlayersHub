local PlayerUI = {}

function PlayerUI.Init(Tab, State)

    print("[UI] Player inicializado.")

    ------------------------------------------------------------
    -- MOVEMENT
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Movement",
        text = "Configurações de movimentação do jogador."
    })

    Tab:CreateToggle({
        name = "Fly",
        value = false,

        callback = function(value)
            State.Fly = value

            print(
                "[Player] Fly:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Fly Speed",
        range = {1, 200},
        increment = 1,
        value = State.FlySpeed or 50,

        callback = function(value)
            State.FlySpeed = value

            print(
                "[Player] FlySpeed:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Speedhack",
        value = false,

        callback = function(value)
            State.Speedhack = value

            print(
                "[Player] Speedhack:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Walk Speed",
        range = {1, 200},
        increment = 1,
        value = State.WalkSpeed or 16,

        callback = function(value)
            State.WalkSpeed = value

            print(
                "[Player] WalkSpeed:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Infinite Jump",
        value = false,

        callback = function(value)
            State.InfiniteJump = value

            print(
                "[Player] InfiniteJump:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Jump Height",
        range = {1, 200},
        increment = 1,
        value = State.JumpHeight or 50,

        callback = function(value)
            State.JumpHeight = value

            print(
                "[Player] JumpHeight:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Ignore Jump Lock",
        value = false,

        callback = function(value)
            State.IgnoreJumpLock = value

            print(
                "[Player] IgnoreJumpLock:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Bunny Hop",
        value = false,

        callback = function(value)
            State.BunnyHop = value

            print(
                "[Player] BunnyHop:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Noclip",
        value = false,

        callback = function(value)
            State.Noclip = value

            print(
                "[Player] Noclip:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- ANIMATION / UTILITY
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Animation & Utility",
        text = "Configurações de animação e utilidades do jogador."
    })

    Tab:CreateToggle({
        name = "No Anims",
        value = false,

        callback = function(value)
            State.NoAnims = value

            print(
                "[Player] NoAnims:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Animation Speed",
        range = {1, 500},
        increment = 1,
        value = State.AnimSpeed or 1,

        callback = function(value)
            State.AnimSpeed = value

            print(
                "[Player] AnimSpeed:",
                value
            )
        end,
    })

    Tab:CreateSlider({
        name = "Utility Speed",
        range = {1, 200},
        increment = 1,
        value = State.UtilitySpeed or 16,

        callback = function(value)
            State.UtilitySpeed = value

            print(
                "[Player] UtilitySpeed:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Anti AFK",
        value = false,

        callback = function(value)
            State.AntiAFK = value

            print(
                "[Player] AntiAFK:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- CHARACTER
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Character",
        text = "Configurações relacionadas ao personagem."
    })

    Tab:CreateButton({
        name = "Request Kill Self",
        description = "Solicita a ação de teste de morte do próprio personagem.",

        callback = function()
            State.KillSelfRequested = true

            print(
                "[Player] KillSelfRequested = true"
            )
        end,
    })

    Tab:CreateToggle({
        name = "TP Back On Death",
        value = false,

        callback = function(value)
            State.TPBackOnDeath = value

            print(
                "[Player] TPBackOnDeath:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "No Kill Bricks",
        value = false,

        callback = function(value)
            State.NoKillbricks = value

            print(
                "[Player] NoKillbricks:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Anti Void",
        value = false,

        callback = function(value)
            State.AntiVoid = value

            print(
                "[Player] AntiVoid:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "No Slow",
        value = false,

        callback = function(value)
            State.NoSlow = value

            print(
                "[Player] NoSlow:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- SERVER
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Server",
        text = "Configurações relacionadas ao servidor."
    })

    Tab:CreateToggle({
        name = "Infinite Yield",
        value = false,

        callback = function(value)
            State.InfiniteYield = value

            print(
                "[Player] InfiniteYield:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Auto Rejoin",
        value = false,

        callback = function(value)
            State.AutoRejoin = value

            print(
                "[Player] AutoRejoin:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Kick Timer",
        value = false,

        callback = function(value)
            State.KickTimer = value

            print(
                "[Player] KickTimer:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Kick Timer Minutes",
        range = {1, 120},
        increment = 1,
        value = State.KickMinutes or 10,

        callback = function(value)
            State.KickMinutes = value

            print(
                "[Player] KickMinutes:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Join Leave Logger",
        value = false,

        callback = function(value)
            State.JoinLeaveLogger = value

            print(
                "[Player] JoinLeaveLogger:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateButton({
        name = "Request Server Hop",
        description = "Registra uma solicitação de troca de servidor.",

        callback = function()
            State.ServerHopRequested = true

            print(
                "[Player] ServerHopRequested = true"
            )
        end,
    })

    Tab:CreateButton({
        name = "Request Rejoin",
        description = "Registra uma solicitação de reconexão.",

        callback = function()
            State.RejoinServerRequested = true

            print(
                "[Player] RejoinServerRequested = true"
            )
        end,
    })

    ------------------------------------------------------------
    -- CHAT
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Chat",
        text = "Configurações relacionadas ao chat."
    })

    Tab:CreateToggle({
        name = "Chat Logger",
        value = false,

        callback = function(value)
            State.ChatLogger = value

            print(
                "[Player] ChatLogger:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateInput({
        name = "Spam Message",
        placeholder = "Digite uma mensagem...",

        removeTextAfterFocusLost = false,

        callback = function(value)
            State.SpamMessage = value

            print(
                "[Player] SpamMessage:",
                value
            )
        end,
    })

    Tab:CreateSlider({
        name = "Chat Delay",
        range = {1, 60},
        increment = 1,
        value = State.ChatDelay or 1,
        suffix = " sec",

        callback = function(value)
            State.ChatDelay = value

            print(
                "[Player] ChatDelay:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "Chat Spammer",
        value = false,

        callback = function(value)
            State.ChatSpammer = value

            print(
                "[Player] ChatSpammer:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- IDENTITY
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Identity",
        text = "Configuração de identidade visual armazenada no State."
    })

    Tab:CreateInput({
        name = "Display Name",
        placeholder = "Display Name",

        removeTextAfterFocusLost = false,

        callback = function(value)
            State.DisplayName = value

            print(
                "[Player] DisplayName:",
                value
            )
        end,
    })

    Tab:CreateInput({
        name = "Username",
        placeholder = "Username",

        removeTextAfterFocusLost = false,

        callback = function(value)
            State.Username = value

            print(
                "[Player] Username:",
                value
            )
        end,
    })

    Tab:CreateButton({
        name = "Apply Identity",
        description = "Registra uma solicitação de aplicação de identidade.",

        callback = function()
            State.IdentityApplyRequested = true

            print(
                "[Player] IdentityApplyRequested = true"
            )
        end,
    })

    Tab:CreateButton({
        name = "Reset Identity",
        description = "Registra uma solicitação para restaurar a identidade.",

        callback = function()
            State.IdentityResetRequested = true

            print(
                "[Player] IdentityResetRequested = true"
            )
        end,
    })

    Tab:CreateButton({
        name = "Refresh Identity",
        description = "Solicita atualização da identidade armazenada.",

        callback = function()
            State.IdentityRefreshRequested = true

            print(
                "[Player] IdentityRefreshRequested = true"
            )
        end,
    })

    ------------------------------------------------------------
    -- CHARACTER VISIBILITY
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Visibility",
        text = "Configurações de visibilidade do personagem e jogadores."
    })

    Tab:CreateToggle({
        name = "Hide Character",
        value = false,

        callback = function(value)
            State.HideCharacter = value

            print(
                "[Player] HideCharacter:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Hide Other Players",
        value = false,

        callback = function(value)
            State.HideOtherPlayers = value

            print(
                "[Player] HideOtherPlayers:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Hide All Players",
        value = false,

        callback = function(value)
            State.HideAllPlayers = value

            print(
                "[Player] HideAllPlayers:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Hide All Names",
        value = false,

        callback = function(value)
            State.HideAllNames = value

            print(
                "[Player] HideAllNames:",
                value and "ON" or "OFF"
            )
        end,
    })

    ------------------------------------------------------------
    -- DEBUG
    ------------------------------------------------------------

    Tab:CreateText({
        name = "Player Debug",
        text = "Mostra os principais valores armazenados no State."
    })

    Tab:CreateButton({
        name = "Player Debug Test",
        description = "Exibe o estado atual da aba Player.",

        callback = function()

            print("================================")
            print("[PlayerUI] DEBUG")
            print("================================")

            print("Fly:", State.Fly)
            print("FlySpeed:", State.FlySpeed)
            print("Speedhack:", State.Speedhack)
            print("WalkSpeed:", State.WalkSpeed)
            print("InfiniteJump:", State.InfiniteJump)
            print("JumpHeight:", State.JumpHeight)
            print("Noclip:", State.Noclip)

            print("NoAnims:", State.NoAnims)
            print("AnimSpeed:", State.AnimSpeed)
            print("AntiAFK:", State.AntiAFK)

            print("AutoRejoin:", State.AutoRejoin)
            print("JoinLeaveLogger:", State.JoinLeaveLogger)

            print("DisplayName:", State.DisplayName)
            print("Username:", State.Username)

            print("HideCharacter:", State.HideCharacter)
            print("HideOtherPlayers:", State.HideOtherPlayers)
            print("HideAllPlayers:", State.HideAllPlayers)
            print("HideAllNames:", State.HideAllNames)

            print("================================")

        end,
    })

    print("[UI] Player UI carregada com sucesso.")

    return PlayerUI
end

return PlayerUI