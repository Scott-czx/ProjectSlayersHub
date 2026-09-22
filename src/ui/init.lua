local UI = {}

function UI.Init(Config)

    print("[UI] Inicializando " .. Config.ProjectName)

    local UserInputService =
        game:GetService("UserInputService")

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

    -- ========================================================
    -- CORE
    -- ========================================================

    local State = LoadModule(
        "src/core/state.lua"
    )

    print("[UI] State central carregado.")

    local Services = LoadModule(
        "src/core/services.lua"
    )

    print("[UI] Services central carregado.")

    local Entities = LoadModule(
        "src/core/entities.lua"
    )

    print("[UI] Entity Manager carregado.")

    -- ========================================================
    -- RAYFIELD
    -- ========================================================

    local Rayfield = loadstring(
        game:HttpGet(
            "https://sirius.menu/gen2"
        )
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

    -- ========================================================
    -- STATE CONNECTION
    -- ========================================================

    State.Visible = true
    State.Rayfield = Rayfield
    State.Window = Window
    State.Tabs = Tabs
    State.Services = Services
    State.Entities = Entities

    -- ========================================================
    -- TOGGLE UI
    -- ========================================================

    UserInputService.InputBegan:Connect(
        function(Input, GameProcessed)

            if GameProcessed then
                return
            end

            if Input.KeyCode == Enum.KeyCode.LeftShift then

                State.Visible =
                    not State.Visible

                Rayfield:SetVisibility(
                    State.Visible
                )

                print(
                    "[UI] Visibilidade:",
                    State.Visible
                        and "ON"
                        or "OFF"
                )

            end

        end
    )

    -- ========================================================
    -- FARM MODULES
    -- ========================================================

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

    -- ========================================================
    -- SCANNER
    -- ========================================================

    local Scanner = LoadModule(
        "src/debug/scanner.lua"
    )

    print("[UI] Scanner carregado.")

    -- ========================================================
    -- FARM SERVICE
    -- ========================================================

    local FarmService = LoadModule(
        "src/farm/service.lua"
    )

    print("[UI] FarmService carregado.")

    -- ========================================================
    -- COMBAT SERVICE
    -- ========================================================

    local CombatService = LoadModule(
        "src/combat/service.lua"
    )

    print("[UI] CombatService carregado.")

    -- ========================================================
    -- SERVICES REGISTRY
    -- ========================================================

    Services.Register(
        "Scanner",
        Scanner
    )

    print("[UI] Scanner registrado.")

    Services.Register(
        "Entities",
        Entities
    )

    print("[UI] Entity Manager registrado.")

    Services.Register(
        "Farm",
        FarmService
    )

    print("[UI] FarmService registrado.")

    Services.Register(
        "Combat",
        CombatService
    )

    print("[UI] CombatService registrado.")

    -- ========================================================
    -- ENTITY MANAGER
    -- ========================================================

    Entities.Init(State)

    Entities.SetScanner(
        Scanner
    )

    print(
        "[UI] Entity Manager conectado ao Scanner."
    )

    -- ========================================================
    -- FARM SERVICE
    -- ========================================================

    FarmService.Init(
        State,
        Mobs,
        Boss,
        Quests
    )

    print(
        "[UI] FarmService inicializado."
    )

    -- ========================================================
    -- COMBAT SERVICE
    -- ========================================================

    CombatService.Init(
        State
    )

    print(
        "[UI] CombatService inicializado."
    )

    -- ========================================================
    -- PAGES
    -- ========================================================

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

    print(
        "[UI] Pages carregadas:",
        "Farm =", Pages.Farm,
        "Combat =", Pages.Combat,
        "Player =", Pages.Player,
        "ESP =", Pages.ESP,
        "World =", Pages.World,
        "Navigation =", Pages.Navigation
    )

    -- ========================================================
    -- VALIDATION
    -- ========================================================

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

    -- ========================================================
    -- PAGE INIT
    -- ========================================================

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

    -- ========================================================
    -- FINAL STATE
    -- ========================================================

    State.Pages = Pages

    State.Mobs = Mobs
    State.Boss = Boss
    State.Quests = Quests

    State.FarmService = FarmService
    State.CombatService = CombatService

    State.Scanner = Scanner
    State.Entities = Entities

    print("[UI] Rayfield carregado.")
    print("[UI] State central conectado.")
    print("[UI] Services central conectado.")
    print("[UI] Entity Manager conectado.")
    print("[UI] Scanner conectado.")
    print("[UI] FarmService conectado.")
    print("[UI] CombatService conectado.")
    print("[UI] Todas as Pages carregadas.")

    return State
end

return UI