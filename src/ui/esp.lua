local ESPUI = {}

local function NormalizeDropdownValue(option)
    if type(option) == "table" then
        return option[1]
    end

    return option
end

local function GetEntities(State)

    if State.Entities then
        return State.Entities
    end

    if State.Services
        and type(State.Services.Get) == "function" then

        return State.Services.Get("Entities")
    end

    return nil
end

local function PrintEntities(Entities, Title)

    if type(Entities) ~= "table" then
        warn("[ESP] Resultado inválido.")
        return
    end

    print("================================")
    print("[ESP]", Title)
    print("================================")
    print("Total:", #Entities)

    for index, Entity in ipairs(Entities) do

        print(
            "[" .. index .. "]",
            Entity.Name,
            "|",
            Entity.Type,
            "|",
            Entity.ClassName,
            "|",
            Entity.FullName
        )

    end

    print("================================")
end

function ESPUI.Init(Tab, State)

    if Tab == nil then
        error("[ESPUI] Tab inválida.")
    end

    if type(State) ~= "table" then
        error("[ESPUI] State inválido.")
    end

    print("[UI] ESP inicializado.")

    -- ========================================================
    -- PLAYER ESP
    -- ========================================================

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
        color = State.PlayerESPColor
            or Color3.fromRGB(255, 255, 255),
        callback = function(value)
            State.PlayerESPColor = value
        end,
    })

    Tab:CreateToggle({
        name = "Show Local Player",
        value = false,
        callback = function(value)
            State.ShowLocalPlayer = value
        end,
    })

    -- ========================================================
    -- MOB ESP
    -- ========================================================

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
        color = State.MobESPColor
            or Color3.fromRGB(255, 255, 255),
        callback = function(value)
            State.MobESPColor = value
        end,
    })

    -- ========================================================
    -- NPC ESP
    -- ========================================================

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
        color = State.NPCESPColor
            or Color3.fromRGB(255, 255, 255),
        callback = function(value)
            State.NPCESPColor = value
        end,
    })

    -- ========================================================
    -- ENTITY MANAGER
    -- ========================================================

    Tab:CreateText({
        name = "Entity Manager",
        text = "Consulta centralizada das entidades descobertas."
    })

    Tab:CreateButton({
        name = "Refresh Entities",
        description = "Atualiza o cache do Entity Manager usando o Scanner.",
        callback = function()

            local Entities = GetEntities(State)

            if Entities == nil then
                warn("[ESP] Entity Manager não disponível.")
                return
            end

            local success, result = pcall(function()
                return Entities.Refresh()
            end)

            if not success then
                warn(
                    "[ESP] Falha ao atualizar entidades:",
                    result
                )
                return
            end

            if result then
                print(
                    "[ESP] Entity Manager atualizado."
                )
            end

        end,
    })

    Tab:CreateButton({
        name = "Show All Entities",
        description = "Mostra todas as entidades armazenadas.",
        callback = function()

            local Entities = GetEntities(State)

            if Entities == nil then
                warn("[ESP] Entity Manager não disponível.")
                return
            end

            local success, result = pcall(function()
                return Entities.GetAll()
            end)

            if not success then
                warn(
                    "[ESP] Falha ao obter entidades:",
                    result
                )
                return
            end

            PrintEntities(
                result,
                "ALL ENTITIES"
            )

        end,
    })

    Tab:CreateButton({
        name = "Show Humanoids",
        description = "Mostra entidades que possuem Humanoid.",
        callback = function()

            local Entities = GetEntities(State)

            if Entities == nil then
                warn("[ESP] Entity Manager não disponível.")
                return
            end

            local success, result = pcall(function()
                return Entities.GetHumanoids()
            end)

            if not success then
                warn(
                    "[ESP] Falha ao obter Humanoids:",
                    result
                )
                return
            end

            PrintEntities(
                result,
                "HUMANOIDS"
            )

        end,
    })

    Tab:CreateButton({
        name = "Show Quest NPCs",
        description = "Mostra os NPCs de quest encontrados.",
        callback = function()

            local Entities = GetEntities(State)

            if Entities == nil then
                warn("[ESP] Entity Manager não disponível.")
                return
            end

            local success, result = pcall(function()
                return Entities.GetQuestNPCs()
            end)

            if not success then
                warn(
                    "[ESP] Falha ao obter Quest NPCs:",
                    result
                )
                return
            end

            PrintEntities(
                result,
                "QUEST NPCS"
            )

        end,
    })

    local EntitySearchInput = ""

    Tab:CreateInput({
        name = "Entity Search",
        description = "Pesquisa entidades pelo nome.",
        placeholder = "Ex: Krue",
        value = "",
        callback = function(value)
            EntitySearchInput = tostring(value or "")
        end,
    })

    Tab:CreateButton({
        name = "Search Entities",
        description = "Pesquisa no cache do Entity Manager.",
        callback = function()

            local Entities = GetEntities(State)

            if Entities == nil then
                warn("[ESP] Entity Manager não disponível.")
                return
            end

            if EntitySearchInput == "" then
                warn("[ESP] Digite algo para pesquisar.")
                return
            end

            local success, result = pcall(function()
                return Entities.Search(
                    EntitySearchInput
                )
            end)

            if not success then
                warn(
                    "[ESP] Falha na pesquisa:",
                    result
                )
                return
            end

            PrintEntities(
                result,
                "SEARCH: " .. EntitySearchInput
            )

        end,
    })

    Tab:CreateButton({
        name = "Entity Manager Debug",
        description = "Mostra o estado do Entity Manager.",
        callback = function()

            local Entities = GetEntities(State)

            if Entities == nil then
                warn("[ESP] Entity Manager não disponível.")
                return
            end

            Entities.Debug()

        end,
    })

    -- ========================================================
    -- ESP TARGET
    -- ========================================================

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
            print("[ESP] Atualização de jogadores solicitada.")
        end,
    })

    Tab:CreateToggle({
        name = "ESP Single Player",
        value = false,
        callback = function(value)
            State.ESPSinglePlayer = value
        end,
    })

    Tab:CreateToggle({
        name = "ESP Nearest Only",
        value = false,
        callback = function(value)
            State.ESPNearestOnly = value
        end,
    })

    -- ========================================================
    -- ESP CONFIG
    -- ========================================================

    Tab:CreateText({
        name = "ESP Config",
        text = "Configurações visuais dos elementos de ESP."
    })

    Tab:CreateToggle({
        name = "Boxes",
        value = false,
        callback = function(value)
            State.ESPBoxes = value
        end,
    })

    Tab:CreateToggle({
        name = "Box Glow",
        value = false,
        callback = function(value)
            State.ESPBoxGlow = value
        end,
    })

    Tab:CreateToggle({
        name = "Chams",
        value = false,
        callback = function(value)
            State.ESPChams = value
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

        end,
    })

    -- ========================================================
    -- GLOW
    -- ========================================================

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

    -- ========================================================
    -- CHAMS
    -- ========================================================

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
        color = State.ChamsColor
            or Color3.fromRGB(255, 255, 255),
        callback = function(value)
            State.ChamsColor = value
        end,
    })

    -- ========================================================
    -- BOX COLORS
    -- ========================================================

    Tab:CreateText({
        name = "Box Colors",
        text = "Configurações das cores superior e inferior dos boxes."
    })

    Tab:CreateColorPicker({
        name = "Box Top",
        color = State.BoxTopColor
            or Color3.fromRGB(255, 255, 255),
        callback = function(value)
            State.BoxTopColor = value
        end,
    })

    Tab:CreateColorPicker({
        name = "Box Bottom",
        color = State.BoxBottomColor
            or Color3.fromRGB(255, 255, 255),
        callback = function(value)
            State.BoxBottomColor = value
        end,
    })

    -- ========================================================
    -- DEBUG
    -- ========================================================

    Tab:CreateText({
        name = "ESP Debug",
        text = "Ferramentas de diagnóstico da configuração ESP."
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