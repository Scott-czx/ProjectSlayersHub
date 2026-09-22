local UI = {}

function UI.Init(Config)

    print("[UI] Inicializando " .. Config.ProjectName)

    local UserInputService = game:GetService("UserInputService")

    local function LoadModule(path)

        local url =
            Config.BaseURL
            .. path
            .. "?v="
            .. tostring(os.clock())

        print("[UI] Carregando:", path)

        local source = game:HttpGet(url)

        print(
            "[UI] Source recebido:",
            path,
            "tamanho =",
            #source
        )

        if source == nil or source == "" then
            error(
                "[UI] Source vazio para "
                .. path
            )
        end

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

        if result == nil then
            error(
                "[UI] Modulo "
                .. path
                .. " retornou nil."
            )
        end

        print(
            "[UI] Modulo carregado:",
            path,
            result
        )

        return result
    end

    local State = LoadModule("src/core/state.lua")
    print("[UI] State central carregado.")

    local Services = LoadModule("src/core/services.lua")
    print("[UI] Services central carregado.")

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

    State.Visible = true
    State.Rayfield = Rayfield
    State.Window = Window
    State.Tabs = Tabs
    State.Services = Services

    UserInputService.InputBegan:Connect(function(Input, GameProcessed)

        if GameProcessed then
            return
        end

        if Input.KeyCode == Enum.KeyCode.LeftShift then

            State.Visible = not State.Visible

            Rayfield:SetVisibility(State.Visible)

            print(
                "[UI] Visibilidade:",
                State.Visible and "ON" or "OFF"
            )
        end
    end)

    local Mobs = LoadModule("src/farm/mobs.lua")
    print("[UI] Mobs carregado.")

    local Boss = LoadModule("src/farm/boss.lua")
    print("[UI] Boss carregado.")

    local Quests = LoadModule("src/farm/quests.lua")
    print("[UI] Quests carregado.")

    local FarmService = LoadModule("src/farm/service.lua")
    print("[UI] FarmService carregado.")

    local Scanner = LoadModule("src/debug/scanner.lua")
    print("[UI] Scanner carregado.")

    Services.Register("Farm", FarmService)
    print("[UI] FarmService registrado.")

    Services.Register("Scanner", Scanner)
    print("[UI] Scanner registrado.")

    FarmService.Init(
        State,
        Mobs,
        Boss,
        Quests
    )

    print("[UI] FarmService inicializado.")

    local Pages = {}

    Pages.Farm = LoadModule("src/ui/farm.lua")
    Pages.Combat = LoadModule("src/ui/combat.lua")
    Pages.Player = LoadModule("src/ui/player.lua")
    Pages.ESP = LoadModule("src/ui/esp.lua")
    Pages.World = LoadModule("src/ui/world.lua")
    Pages.Navigation = LoadModule("src/ui/navigation.lua")

    print(
        "[UI] Pages carregadas:",
        "Farm =", Pages.Farm,
        "Combat =", Pages.Combat,
        "Player =", Pages.Player,
        "ESP =", Pages.ESP,
        "World =", Pages.World,
        "Navigation =", Pages.Navigation
    )

    if type(Pages.Farm) ~= "table" then
        error("[UI] Pages.Farm inválido.")
    end

    if type(Pages.Combat) ~= "table" then
        error("[UI] Pages.Combat inválido.")
    end

    if type(Pages.Player) ~= "table" then
        error("[UI] Pages.Player inválido.")
    end

    if type(Pages.ESP) ~= "table" then
        error("[UI] Pages.ESP inválido.")
    end

    if type(Pages.World) ~= "table" then
        error("[UI] Pages.World inválido.")
    end

    if type(Pages.Navigation) ~= "table" then
        error("[UI] Pages.Navigation inválido.")
    end

    if type(Pages.Farm.Init) ~= "function" then
        error("[UI] Pages.Farm.Init inválido.")
    end

    if type(Pages.Combat.Init) ~= "function" then
        error("[UI] Pages.Combat.Init inválido.")
    end

    if type(Pages.Player.Init) ~= "function" then
        error("[UI] Pages.Player.Init inválido.")
    end

    if type(Pages.ESP.Init) ~= "function" then
        error("[UI] Pages.ESP.Init inválido.")
    end

    if type(Pages.World.Init) ~= "function" then
        error("[UI] Pages.World.Init inválido.")
    end

    if type(Pages.Navigation.Init) ~= "function" then
        error("[UI] Pages.Navigation.Init inválido.")
    end

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

    State.Pages = Pages
    State.Mobs = Mobs
    State.Boss = Boss
    State.Quests = Quests
    State.FarmService = FarmService
    State.Scanner = Scanner

    print("[UI] Rayfield carregado.")
    print("[UI] State central conectado.")
    print("[UI] Services central conectado.")
    print("[UI] Todas as Pages carregadas.")

    return State
end

return UI