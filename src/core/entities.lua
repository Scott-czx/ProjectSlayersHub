local Entities = {}

-- ========================================================
-- STATE
-- ========================================================

local State = nil
local Scanner = nil

local Cache = {
    All = {},
    Models = {},
    Humanoids = {},
    QuestNPCs = {},
    Prompts = {},
    LastUpdate = 0,
}

-- ========================================================
-- INIT
-- ========================================================

function Entities.Init(SharedState)

    if type(SharedState) ~= "table" then
        error("[Entities] State inválido.")
    end

    State = SharedState

    if State.Scanner then
        Scanner = State.Scanner
    end

    print("[Entities] Inicializado.")

    return Entities
end

-- ========================================================
-- SCANNER
-- ========================================================

function Entities.SetScanner(ScannerModule)

    if type(ScannerModule) ~= "table" then
        warn("[Entities] Scanner inválido.")
        return false
    end

    Scanner = ScannerModule

    print("[Entities] Scanner conectado.")

    return true
end

function Entities.GetScanner()

    return Scanner
end

-- ========================================================
-- REFRESH
-- ========================================================

function Entities.Refresh()

    if Scanner == nil then
        warn("[Entities] Scanner não conectado.")
        return false
    end

    local success, result = pcall(function()

        return Scanner.Scan()

    end)

    if not success then

        warn(
            "[Entities] Falha ao atualizar:",
            result
        )

        return false
    end

    Cache.Models = result.Models or {}
    Cache.Humanoids = result.Humanoids or {}
    Cache.QuestNPCs = result.QuestNPCs or {}
    Cache.Prompts = result.Prompts or {}
    Cache.All = result.Entities or {}

    Cache.LastUpdate = os.clock()

    print("================================")
    print("[Entities] CACHE ATUALIZADO")
    print("================================")
    print("Models:", #Cache.Models)
    print("Humanoids:", #Cache.Humanoids)
    print("QuestNPCs:", #Cache.QuestNPCs)
    print("Prompts:", #Cache.Prompts)
    print("Entities:", #Cache.All)
    print("================================")

    return true
end

-- ========================================================
-- GETTERS
-- ========================================================

function Entities.GetAll()

    return Cache.All

end

function Entities.GetModels()

    return Cache.Models

end

function Entities.GetHumanoids()

    return Cache.Humanoids

end

function Entities.GetQuestNPCs()

    return Cache.QuestNPCs

end

function Entities.GetPrompts()

    return Cache.Prompts

end

function Entities.GetLastUpdate()

    return Cache.LastUpdate

end

-- ========================================================
-- SEARCH
-- ========================================================

function Entities.FindByName(Name)

    if type(Name) ~= "string" then
        return {}
    end

    local Wanted = string.lower(Name)
    local Found = {}

    for _, Entity in ipairs(Cache.All) do

        if type(Entity.Name) == "string"
            and string.lower(Entity.Name) == Wanted then

            table.insert(
                Found,
                Entity
            )

        end

    end

    return Found
end

function Entities.Search(Text)

    if type(Text) ~= "string" then
        return {}
    end

    local Wanted = string.lower(Text)

    if Wanted == "" then
        return {}
    end

    local Found = {}

    for _, Entity in ipairs(Cache.All) do

        if type(Entity.Name) == "string"
            and string.find(
                string.lower(Entity.Name),
                Wanted,
                1,
                true
            ) then

            table.insert(
                Found,
                Entity
            )

        end

    end

    return Found
end

-- ========================================================
-- TYPE
-- ========================================================

function Entities.GetByType(EntityType)

    if type(EntityType) ~= "string" then
        return {}
    end

    local Found = {}

    for _, Entity in ipairs(Cache.All) do

        if Entity.Type == EntityType then

            table.insert(
                Found,
                Entity
            )

        end

    end

    return Found
end

-- ========================================================
-- DEBUG
-- ========================================================

function Entities.Debug()

    print("================================")
    print("[Entities] DEBUG")
    print("================================")

    print(
        "Scanner:",
        Scanner ~= nil
    )

    print(
        "Models:",
        #Cache.Models
    )

    print(
        "Humanoids:",
        #Cache.Humanoids
    )

    print(
        "QuestNPCs:",
        #Cache.QuestNPCs
    )

    print(
        "Prompts:",
        #Cache.Prompts
    )

    print(
        "All:",
        #Cache.All
    )

    print(
        "LastUpdate:",
        Cache.LastUpdate
    )

    print("================================")

end

return Entities