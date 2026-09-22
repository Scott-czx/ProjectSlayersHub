local UI = {}

function UI.Init(Config)

    print("[UI] Inicializando " .. Config.ProjectName)

    local UserInputService = game:GetService("UserInputService")

    local function LoadModule(path)
        local url = Config.BaseURL .. path .. "?v=" .. tostring(os.clock())

        local source = game:HttpGet(url)

        local success, result = pcall(function()
            return loadstring(source)()
        end)

        if not success then
            error(
                "[UI] Falha ao carregar "
                .. path
                .. "\n"
                .. tostring(result)
            )
        end

        return result
    end

    ------------------------------------------------------------
    -- CORE
    ------------------------------------------------------------

    local State = LoadModule("src/core/state.lua")
    print("[UI] State central carregado.")

    local Services = LoadModule("src/core/services.lua")
    print("[UI] Services central carregado.")

    ------------------------------------------------------------
    -- RAYFIELD
    ------------------------------------------------------------

    local Rayfield = loadstring(
        game:HttpGet("https://sirius.menu/gen2")
    )()

    local Window = Rayfield:CreateWindow({
        name = Config.ProjectName,
        subtitle = "v" .. Config.Version,
        sidebarLayout = true,
    })

    local Tabs = {}

    Tabs.Farm = Window:CreateTab({
        name = "Farm"
    })

    Tabs.Combat = Window:CreateTab({
        name = "Combat"
    })

    Tabs.Player = Window:CreateTab({
        name = "Player"
    })

    Tabs.ESP = Window:CreateTab({
        name = "ESP"
    })

    Tabs.World = Window:CreateTab({
        name = "World"
    })

    Tabs.Navigation = Window:CreateTab({
        name = "Navigation"
    })

    ------------------------------------------------------------
    -- STATE UI
    ------------------------------------------------------------

    State.Visible = true
    State.Rayfield = Rayfield
    State.Window = Window
    State.Tabs = Tabs
    State.Services = Services

    ------------------------------------------------------------
    -- TOGGLE UI
    ------------------------------------------------------------

    UserInputService.InputBegan:Connect(function(
        Input,
        GameProcessed
    )

        if GameProcessed then
            return
        end

        if Input.KeyCode == Enum.KeyCode.LeftShift then

            State.Visible = not State.Visible

            Rayfield:SetVisibility(
                State.Visible
            )

            print(
                "[UI] Visibilidade:",
                State.Visible and "ON" or "OFF"
            )
        end
    end)

    ------------------------------------------------------------
    -- FARM MODULES
    ------------------------------------------------------------

    local Mobs = LoadModule(
        "src/farm/mobs.lua"
    )

    print("[UI] Mobs carregado.")

    local Boss = LoadModule(
        "src/farm/boss.lua"
    )

    print("[UI] Boss carregado.")

    local Quests = LoadModule(
        "src/farm/quests.lua"
    )

    print("[UI] Quests carregado.")

    local FarmService = LoadModule(
        "src/farm/service.lua"
    )

    print("[UI] FarmService carregado.")

    ------------------------------------------------------------
    -- DEBUG
    ------------------------------------------------------------

    local Scanner = LoadModule(
        "src/debug/scanner.lua"
    )

    print("[UI] Scanner carregado.")

    ------------------------------------------------------------
    -- SERVICES
    ------------------------------------------------------------

    Services.Register(
        "Farm",
        FarmService
    )

    print("[UI] FarmService registrado.")

    Services.Register(
        "Scanner",
        Scanner
    )

    print("[UI] Scanner registrado.")

    ------------------------------------------------------------
    -- FARM INITIALIZATION
    ------------------------------------------------------------

    FarmService.Init(
        State,
        Mobs,
        Boss,
        Quests
    )

    print("[UI] FarmService inicializado.")
    print("[UI] Mobs conectado ao FarmService.")
    print("[UI] Boss conectado ao FarmService.")
    print("[UI] Quests conectado ao FarmService.")

    ------------------------------------------------------------
    -- DEBUG UI
    ------------------------------------------------------------

    Tabs.Farm:CreateText({
        name = "Project Slayers 2 - Debug",
        text = "Ferramentas de diagnóstico para descobrir a estrutura real do jogo."
    })

    Tabs.Farm:CreateButton({
        name = "Scan Quest NPCs",

        callback = function()

            print("")
            print("================================")
            print("[UI] Iniciando Scan Quest NPCs")
            print("================================")

            local success, result = pcall(function()
                return Scanner.ScanQuestNPCs()
            end)

            if not success then
                warn(
                    "[UI] Erro no Scanner:",
                    result
                )

                return
            end

            print(
                "[UI] Scan concluído. NPCs encontrados:",
                result
            )
        end,
    })

    Tabs.Farm:CreateButton({
        name = "Scanner Debug",

        callback = function()

            local success, result = pcall(function()
                return Scanner.Debug()
            end)

            if not success then
                warn(
                    "[UI] Erro no Scanner Debug:",
                    result
                )
            end
        end,
    })

    Tabs.Farm:CreateInput({
        name = "Search Workspace",

        placeholder = "Digite um nome...",

        removeTextAfterFocusLost = false,

        callback = function(value)

            if type(value) ~= "string" then
                return
            end

            if value == "" then
                return
            end

            print("")
            print(
                "[UI] Procurando:",
                value
            )

            local success, result = pcall(function()
                return Scanner.Search(value)
            end)

            if not success then
                warn(
                    "[UI] Erro na busca:",
                    result
                )

                return
            end

            print(
                "[UI] Busca concluída. Resultados:",
                result
            )
        end,
    })

    ------------------------------------------------------------
    -- UI PAGES
    ------------------------------------------------------------

    local Pages = {}

    Pages.Farm = LoadModule(
        "src/ui/farm.lua"
    )

    Pages.Combat = LoadModule(
        "src/ui/combat.lua"
    )

    Pages.Player = LoadModule(
        "src/ui/player.lua"
    )

    Pages.ESP = LoadModule(
        "src/ui/esp.lua"
    )

    Pages.World = LoadModule(
        "src/ui/world.lua"
    )

    Pages.Navigation = LoadModule(
        "src/ui/navigation.lua"
    )

    ------------------------------------------------------------
    -- INITIALIZE PAGES
    ------------------------------------------------------------

    Pages.Farm.Init(
        Tabs.Farm,
        State
    )

    Pages.Combat.Init(
        Tabs.Combat,
        State
    )

    Pages.Player.Init(
        Tabs.Player,
        State
    )

    Pages.ESP.Init(
        Tabs.ESP,
        State
    )

    Pages.World.Init(
        Tabs.World,
        State
    )

    Pages.Navigation.Init(
        Tabs.Navigation,
        State
    )

    ------------------------------------------------------------
    -- SAVE REFERENCES
    ------------------------------------------------------------

    State.Pages = Pages

    State.Mobs = Mobs
    State.Boss = Boss
    State.Quests = Quests
    State.FarmService = FarmService
    State.Scanner = Scanner

    ------------------------------------------------------------
    -- FINAL LOG
    ------------------------------------------------------------

    print("[UI] Rayfield carregado.")
    print("[UI] State central conectado.")
    print("[UI] Services central conectado.")
    print("[UI] Mobs carregado.")
    print("[UI] Boss carregado.")
    print("[UI] Quests carregado.")
    print("[UI] FarmService registrado.")
    print("[UI] Scanner registrado.")
    print("[UI] FarmService inicializado.")
    print("[UI] Mobs conectado ao FarmService.")
    print("[UI] Boss conectado ao FarmService.")
    print("[UI] Quests conectado ao FarmService.")
    print("[UI] Scanner disponível em State.Scanner.")
    print("[UI] Debug UI configurado.")
    print("[UI] 6 abas criadas.")
    print("[UI] LeftShift configurado.")

    return State
end

return UI