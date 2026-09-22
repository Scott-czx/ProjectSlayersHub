local FarmUI = {}

local function NormalizeDropdownValue(option)
    if type(option) == "table" then
        return option[1]
    end

    return option
end

function FarmUI.Init(Tab, State)

    if Tab == nil then
        error("[FarmUI] Tab inválida.")
    end

    if type(State) ~= "table" then
        error("[FarmUI] State inválido.")
    end

    print("[FarmUI] Inicializando...")

    -- ========================================================
    -- FARM
    -- ========================================================

    Tab:CreateText({
        name = "Project Slayers 2 - Farm",
        text = "Sistema de Farm. Nesta etapa estamos configurando apenas a interface e o gerenciamento de estado.",
    })

    Tab:CreateButton({
        name = "Farm UI Test",
        description = "Verifica se os elementos da aba Farm estão funcionando.",
        callback = function()
            print("================================")
            print("[Farm] UI funcionando corretamente.")
            print("================================")
        end,
    })

    Tab:CreateText({
        name = "Farm Mobs",
        text = "Configurações relacionadas a mobs.",
    })

    local TargetMobElement = Tab:CreateDropdown({
        name = "Target Mob",
        description = "Escolha o mob que será armazenado como alvo.",
        options = {
            "Nenhum",
            "Bandit",
            "Demon",
            "Spider",
            "Custom",
        },
        value = "Nenhum",
        callback = function(option)
            local value = NormalizeDropdownValue(option)

            if value == "Nenhum" then
                State.TargetMob = nil
            else
                State.TargetMob = value
            end

            print("[FarmUI] TargetMob:", State.TargetMob)
        end,
    })

    State.TargetMobElement = TargetMobElement

    Tab:CreateButton({
        name = "Refresh Mobs",
        description = "Atualiza a lista de mobs quando o sistema de descoberta estiver conectado.",
        callback = function()
            print("[FarmUI] Refresh Mobs solicitado.")

            if State.FarmService then
                local success, result = pcall(function()
                    return State.FarmService.GetMobCandidates()
                end)

                if success then
                    print(
                        "[FarmUI] Mobs encontrados:",
                        #result
                    )
                else
                    warn(
                        "[FarmUI] Falha ao procurar mobs:",
                        result
                    )
                end
            end
        end,
    })

    Tab:CreateToggle({
        name = "Farm Mobs",
        description = "Liga/desliga o estado de Farm Mobs.",
        value = false,
        callback = function(value)
            State.FarmMobs = value
            print("[FarmUI] FarmMobs:", value)
        end,
    })

    Tab:CreateToggle({
        name = "Mob Kill Aura",
        description = "Liga/desliga o estado de Mob Kill Aura.",
        value = false,
        callback = function(value)
            State.MobKillAura = value
            print("[FarmUI] MobKillAura:", value)
        end,
    })

    Tab:CreateSlider({
        name = "Mob Farm Distance",
        description = "Distância armazenada para o posicionamento do farm.",
        range = { 1, 50 },
        increment = 1,
        value = State.FarmDistance or 5,
        suffix = " studs",
        callback = function(value)
            State.FarmDistance = value
            print("[FarmUI] FarmDistance:", value)
        end,
    })

    Tab:CreateText({
        name = "Mob Farm Position",
        text = "Offsets utilizados posteriormente pelo sistema de posicionamento.",
    })

    Tab:CreateSlider({
        name = "Mob Offset X",
        range = { -50, 50 },
        increment = 1,
        value = State.FarmOffsetX or 0,
        suffix = " X",
        callback = function(value)
            State.FarmOffsetX = value
        end,
    })

    Tab:CreateSlider({
        name = "Mob Offset Y",
        range = { -50, 50 },
        increment = 1,
        value = State.FarmOffsetY or 0,
        suffix = " Y",
        callback = function(value)
            State.FarmOffsetY = value
        end,
    })

    Tab:CreateSlider({
        name = "Mob Offset Z",
        range = { -50, 50 },
        increment = 1,
        value = State.FarmOffsetZ or 0,
        suffix = " Z",
        callback = function(value)
            State.FarmOffsetZ = value
        end,
    })

    Tab:CreateText({
        name = "Loot",
        text = "Configurações relacionadas à coleta.",
    })

    Tab:CreateToggle({
        name = "Auto Loot Chests",
        description = "Liga/desliga o estado de Auto Loot Chests.",
        value = false,
        callback = function(value)
            State.AutoLootChests = value
            print("[FarmUI] AutoLootChests:", value)
        end,
    })

    Tab:CreateToggle({
        name = "Pickup Aura",
        description = "Liga/desliga o estado de Pickup Aura.",
        value = false,
        callback = function(value)
            State.PickupAura = value
            print("[FarmUI] PickupAura:", value)
        end,
    })

    Tab:CreateText({
        name = "Boss Farm",
        text = "Configurações relacionadas a bosses.",
    })

    local TargetBossElement = Tab:CreateDropdown({
        name = "Target Boss",
        description = "Escolha o boss que será armazenado como alvo.",
        options = {
            "Nenhum",
            "Obanai",
            "Zentaro",
            "Sabito",
            "Giyu",
            "Daki",
            "Gyutaro",
            "Sanemi",
            "Shinobu",
            "Rengoku",
            "Nezura",
        },
        value = "Nenhum",
        callback = function(option)
            local value = NormalizeDropdownValue(option)

            if value == "Nenhum" then
                State.TargetBoss = nil
            else
                State.TargetBoss = value
            end

            print("[FarmUI] TargetBoss:", State.TargetBoss)
        end,
    })

    State.TargetBossElement = TargetBossElement

    Tab:CreateToggle({
        name = "Boss Farm",
        description = "Liga/desliga o estado de Boss Farm.",
        value = false,
        callback = function(value)
            State.BossFarm = value
            print("[FarmUI] BossFarm:", value)
        end,
    })

    Tab:CreateButton({
        name = "Refresh Bosses",
        description = "Procura entidades disponíveis através do FarmService.",
        callback = function()
            print("[FarmUI] Refresh Bosses solicitado.")

            if State.FarmService then
                local success, result = pcall(function()
                    return State.FarmService.GetBossCandidates()
                end)

                if success then
                    print("[FarmUI] Boss candidates:", #result)
                else
                    warn("[FarmUI] Falha ao procurar bosses:", result)
                end
            end
        end,
    })

    Tab:CreateText({
        name = "Auto Quest",
        text = "Configurações relacionadas às quests.",
    })

    local TargetQuestElement = Tab:CreateDropdown({
        name = "Target Quest NPC",
        description = "Escolha um NPC conhecido de quest.",
        options = {
            "Nenhum",
            "Krue",
            "Tom",
            "Chaka",
            "Wagwan",
            "Jugg",
            "Goro",
            "Tomoi",
            "Mitsu",
            "Kasugai Crow",
            "Kona",
        },
        value = "Nenhum",
        callback = function(option)
            local value = NormalizeDropdownValue(option)

            if value == "Nenhum" then
                State.TargetQuest = nil
            else
                State.TargetQuest = value
            end

            print("[FarmUI] TargetQuest:", State.TargetQuest)
        end,
    })

    State.TargetQuestElement = TargetQuestElement

    Tab:CreateToggle({
        name = "Auto Quest",
        description = "Liga/desliga o estado de Auto Quest.",
        value = false,
        callback = function(value)
            State.AutoQuest = value
            print("[FarmUI] AutoQuest:", value)
        end,
    })

    Tab:CreateButton({
        name = "Refresh Quest NPCs",
        description = "Procura os NPCs conhecidos no Workspace.",
        callback = function()
            print("[FarmUI] Refresh Quest NPCs solicitado.")

            if State.FarmService then
                local success, result = pcall(function()
                    return State.FarmService.GetQuestCandidates()
                end)

                if success then
                    print("[FarmUI] Quest NPCs encontrados:", #result)
                else
                    warn("[FarmUI] Falha ao procurar Quest NPCs:", result)
                end
            end
        end,
    })

    Tab:CreateText({
        name = "Farm Players",
        text = "Interface preparada para seleção e configuração de jogadores.",
    })

    local TargetPlayerElement = Tab:CreateDropdown({
        name = "Target Player",
        description = "Lista temporária para configuração da interface.",
        options = {"Nenhum"},
        value = "Nenhum",
        callback = function(option)
            local value = NormalizeDropdownValue(option)

            if value == "Nenhum" then
                State.TargetPlayer = nil
            else
                State.TargetPlayer = value
            end

            print("[FarmUI] TargetPlayer:", State.TargetPlayer)
        end,
    })

    State.TargetPlayerElement = TargetPlayerElement

    Tab:CreateButton({
        name = "Refresh Players",
        description = "Atualiza a lista de jogadores futuramente.",
        callback = function()
            print("[FarmUI] Refresh Players solicitado.")
        end,
    })

    Tab:CreateToggle({
        name = "Farm Player",
        description = "Estado da configuração de Farm Player.",
        value = false,
        callback = function(value)
            State.FarmPlayer = value
            print("[FarmUI] FarmPlayer:", value)
        end,
    })

    Tab:CreateToggle({
        name = "Player Kill Aura",
        description = "Estado da configuração de Player Kill Aura.",
        value = false,
        callback = function(value)
            State.PlayerKillAura = value
            print("[FarmUI] PlayerKillAura:", value)
        end,
    })

    Tab:CreateSlider({
        name = "Player Farm Distance",
        range = { 1, 50 },
        increment = 1,
        value = State.PlayerFarmDistance or 5,
        suffix = " studs",
        callback = function(value)
            State.PlayerFarmDistance = value
        end,
    })

    Tab:CreateText({
        name = "Player Farm Position",
        text = "Offsets da configuração de posicionamento.",
    })

    Tab:CreateSlider({
        name = "Player Offset X",
        range = { -50, 50 },
        increment = 1,
        value = State.PlayerFarmOffsetX or 0,
        suffix = " X",
        callback = function(value)
            State.PlayerFarmOffsetX = value
        end,
    })

    Tab:CreateSlider({
        name = "Player Offset Y",
        range = { -50, 50 },
        increment = 1,
        value = State.PlayerFarmOffsetY or 0,
        suffix = " Y",
        callback = function(value)
            State.PlayerFarmOffsetY = value
        end,
    })

    Tab:CreateSlider({
        name = "Player Offset Z",
        range = { -50, 50 },
        increment = 1,
        value = State.PlayerFarmOffsetZ or 0,
        suffix = " Z",
        callback = function(value)
            State.PlayerFarmOffsetZ = value
        end,
    })

    -- ========================================================
    -- SCANNER
    -- ========================================================

    Tab:CreateText({
        name = "Scanner",
        text = "Ferramentas de diagnóstico do ambiente.",
    })

    Tab:CreateButton({
        name = "Run Full Scan",
        description = "Executa o scanner completo.",
        callback = function()

            if not State.Scanner then
                warn("[FarmUI] Scanner não está disponível.")
                return
            end

            local success, result = pcall(function()
                return State.Scanner.Scan()
            end)

            if not success then
                warn("[FarmUI] Falha no Full Scan:", result)
                return
            end

            print("================================")
            print("[FarmUI] SCANNER RESULT")
            print("================================")
            print("Models:", #result.Models)
            print("Humanoids:", #result.Humanoids)
            print("Quest NPCs:", #result.QuestNPCs)
            print("Prompts:", #result.Prompts)
            print("================================")
        end,
    })

    Tab:CreateButton({
        name = "Scan Quest NPCs",
        description = "Procura os NPCs de quest conhecidos.",
        callback = function()

            if not State.Scanner then
                warn("[FarmUI] Scanner não está disponível.")
                return
            end

            local success, result = pcall(function()
                return State.Scanner.ScanQuestNPCs()
            end)

            if not success then
                warn("[FarmUI] Falha no scan de Quest NPCs:", result)
                return
            end

            print(
                "[FarmUI] Quest NPCs encontrados:",
                #result
            )

            for index, npc in ipairs(result) do
                print(
                    "[" .. index .. "]",
                    npc.Name,
                    "|",
                    npc.FullName
                )
            end
        end,
    })

    local ScannerSearchInput = ""

    Tab:CreateInput({
        name = "Scanner Search",
        description = "Digite um nome ou parte do nome para pesquisar.",
        placeholder = "Ex: Krue",
        value = "",
        callback = function(value)
            ScannerSearchInput = tostring(value or "")
        end,
    })

    Tab:CreateButton({
        name = "Search Scanner",
        description = "Pesquisa o texto informado no Workspace.",
        callback = function()

            if not State.Scanner then
                warn("[FarmUI] Scanner não está disponível.")
                return
            end

            if ScannerSearchInput == "" then
                warn("[FarmUI] Digite algo para pesquisar.")
                return
            end

            local success, result = pcall(function()
                return State.Scanner.Search(
                    ScannerSearchInput
                )
            end)

            if not success then
                warn(
                    "[FarmUI] Falha na pesquisa:",
                    result
                )
                return
            end

            print(
                "[FarmUI] Resultados:",
                #result
            )
        end,
    })

    Tab:CreateButton({
        name = "Scanner Debug",
        description = "Mostra o estado atual do Scanner.",
        callback = function()

            if not State.Scanner then
                warn("[FarmUI] Scanner não está disponível.")
                return
            end

            State.Scanner.Debug()
        end,
    })

    -- ========================================================
    -- DEBUG
    -- ========================================================

    Tab:CreateText({
        name = "Farm Debug",
        text = "Ferramentas de diagnóstico da interface.",
    })

    Tab:CreateButton({
        name = "Farm Debug Test",
        description = "Mostra o estado atual do módulo Farm.",
        callback = function()

            print("================================")
            print("[FarmUI] DEBUG")
            print("================================")
            print("TargetMob:", State.TargetMob)
            print("FarmMobs:", State.FarmMobs)
            print("MobKillAura:", State.MobKillAura)
            print("TargetBoss:", State.TargetBoss)
            print("BossFarm:", State.BossFarm)
            print("TargetQuest:", State.TargetQuest)
            print("AutoQuest:", State.AutoQuest)
            print("TargetPlayer:", State.TargetPlayer)
            print("FarmPlayer:", State.FarmPlayer)
            print("PlayerKillAura:", State.PlayerKillAura)
            print("================================")

        end,
    })

    print("[FarmUI] Inicializado com sucesso.")

    return FarmUI
end

return FarmUI