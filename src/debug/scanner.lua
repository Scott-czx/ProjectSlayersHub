local Scanner = {}

-- ========================================================
-- CONFIG
-- ========================================================

local MAX_DEPTH = 3

local KnownQuestNames = {
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
}

-- ========================================================
-- STATE
-- ========================================================

local Results = {
    Models = {},
    Humanoids = {},
    QuestNPCs = {},
    Prompts = {},
    SearchResults = {},
    Entities = {},
    LastScan = 0,
}

-- ========================================================
-- HELPERS
-- ========================================================

local function IsKnownName(name)

    if type(name) ~= "string" then
        return false
    end

    local wanted = string.lower(name)

    for _, knownName in ipairs(KnownQuestNames) do

        if string.lower(knownName) == wanted then
            return true
        end

    end

    return false
end

local function GetClassName(object)

    local success, result = pcall(function()
        return object.ClassName
    end)

    if success then
        return result
    end

    return "Unknown"
end

local function GetFullName(object)

    local success, result = pcall(function()
        return object:GetFullName()
    end)

    if success then
        return result
    end

    return tostring(object)
end

local function GetAttributes(object)

    local success, attributes = pcall(function()
        return object:GetAttributes()
    end)

    if success then
        return attributes
    end

    return {}
end

local function GetParentName(object)

    local success, result = pcall(function()

        if object.Parent then
            return object.Parent.Name
        end

        return nil

    end)

    if success then
        return result
    end

    return nil
end

local function GetPosition(object)

    local success, result = pcall(function()

        if object:IsA("BasePart") then
            return object.Position
        end

        if object:IsA("Model") then
            return object:GetPivot().Position
        end

        return nil

    end)

    if success then
        return result
    end

    return nil
end

local function CreateResult(object, resultType)

    return {
        Type = resultType,
        Instance = object,
        Name = object.Name,
        FullName = GetFullName(object),
        ClassName = GetClassName(object),
        ParentName = GetParentName(object),
        Attributes = GetAttributes(object),
        Position = GetPosition(object),
    }

end

local function GetHumanoidInfo(model)

    if not model:IsA("Model") then
        return nil
    end

    local success, humanoid = pcall(function()
        return model:FindFirstChildOfClass("Humanoid")
    end)

    if not success or humanoid == nil then
        return nil
    end

    local result = CreateResult(
        model,
        "Humanoid"
    )

    result.Humanoid = humanoid
    result.Health = humanoid.Health
    result.MaxHealth = humanoid.MaxHealth

    return result

end

local function GetWorkspaceDescendants()

    local success, descendants = pcall(function()
        return workspace:GetDescendants()
    end)

    if not success then

        warn(
            "[Scanner] Falha ao obter descendants:",
            descendants
        )

        return nil
    end

    return descendants

end

-- ========================================================
-- RESET
-- ========================================================

function Scanner.Clear()

    Results = {
        Models = {},
        Humanoids = {},
        QuestNPCs = {},
        Prompts = {},
        SearchResults = {},
        Entities = {},
        LastScan = 0,
    }

    print("[Scanner] Resultados limpos.")

end

-- ========================================================
-- SCAN MODELS
-- ========================================================

function Scanner.ScanModels()

    local models = {}
    local descendants = GetWorkspaceDescendants()

    if descendants == nil then
        return models
    end

    for _, object in ipairs(descendants) do

        if object:IsA("Model") then

            local result = CreateResult(
                object,
                "Model"
            )

            table.insert(
                models,
                result
            )

        end

    end

    Results.Models = models

    print(
        "[Scanner] Models encontrados:",
        #models
    )

    return models

end

-- ========================================================
-- SCAN HUMANOIDS
-- ========================================================

function Scanner.ScanHumanoids()

    local humanoids = {}
    local descendants = GetWorkspaceDescendants()

    if descendants == nil then
        return humanoids
    end

    for _, object in ipairs(descendants) do

        if object:IsA("Model") then

            local info = GetHumanoidInfo(object)

            if info ~= nil then

                table.insert(
                    humanoids,
                    info
                )

            end

        end

    end

    Results.Humanoids = humanoids

    print(
        "[Scanner] Models com Humanoid:",
        #humanoids
    )

    return humanoids

end

-- ========================================================
-- SCAN QUEST NPCS
-- ========================================================

function Scanner.ScanQuestNPCs()

    local questNPCs = {}
    local descendants = GetWorkspaceDescendants()

    if descendants == nil then
        return questNPCs
    end

    for _, object in ipairs(descendants) do

        if object:IsA("Model")
            and IsKnownName(object.Name) then

            local humanoidInfo = GetHumanoidInfo(object)

            local result = CreateResult(
                object,
                "QuestNPC"
            )

            result.Humanoid = humanoidInfo

            table.insert(
                questNPCs,
                result
            )

        end

    end

    Results.QuestNPCs = questNPCs

    print(
        "[Scanner] Quest NPCs encontrados:",
        #questNPCs
    )

    return questNPCs

end

-- ========================================================
-- SCAN PROMPTS
-- ========================================================

function Scanner.ScanPrompts()

    local prompts = {}
    local descendants = GetWorkspaceDescendants()

    if descendants == nil then
        return prompts
    end

    for _, object in ipairs(descendants) do

        if object:IsA("ProximityPrompt") then

            local result = CreateResult(
                object,
                "ProximityPrompt"
            )

            result.ActionText = object.ActionText
            result.ObjectText = object.ObjectText
            result.Enabled = object.Enabled
            result.HoldDuration = object.HoldDuration
            result.MaxActivationDistance =
                object.MaxActivationDistance

            table.insert(
                prompts,
                result
            )

        end

    end

    Results.Prompts = prompts

    print(
        "[Scanner] ProximityPrompts encontrados:",
        #prompts
    )

    return prompts

end

-- ========================================================
-- BUILD ENTITIES
-- ========================================================

function Scanner.BuildEntities()

    local entities = {}

    for _, result in ipairs(Results.Models) do

        table.insert(
            entities,
            result
        )

    end

    for _, result in ipairs(Results.Humanoids) do

        table.insert(
            entities,
            result
        )

    end

    for _, result in ipairs(Results.QuestNPCs) do

        table.insert(
            entities,
            result
        )

    end

    Results.Entities = entities

    print(
        "[Scanner] Entidades padronizadas:",
        #entities
    )

    return entities

end

-- ========================================================
-- FULL SCAN
-- ========================================================

function Scanner.Scan()

    print("================================")
    print("[Scanner] FULL SCAN")
    print("================================")

    Scanner.Clear()

    Scanner.ScanModels()
    Scanner.ScanHumanoids()
    Scanner.ScanQuestNPCs()
    Scanner.ScanPrompts()
    Scanner.BuildEntities()

    Results.LastScan = os.clock()

    print("--------------------------------")

    print(
        "[Scanner] Models:",
        #Results.Models
    )

    print(
        "[Scanner] Humanoids:",
        #Results.Humanoids
    )

    print(
        "[Scanner] Quest NPCs:",
        #Results.QuestNPCs
    )

    print(
        "[Scanner] Prompts:",
        #Results.Prompts
    )

    print(
        "[Scanner] Entities:",
        #Results.Entities
    )

    print("================================")

    return Results

end

-- ========================================================
-- SEARCH
-- ========================================================

function Scanner.Search(text)

    if type(text) ~= "string" then
        return {}
    end

    local wanted = string.lower(text)

    if wanted == "" then
        return {}
    end

    local found = {}
    local descendants = GetWorkspaceDescendants()

    if descendants == nil then
        return found
    end

    for _, object in ipairs(descendants) do

        local objectName = string.lower(
            object.Name
        )

        if string.find(
            objectName,
            wanted,
            1,
            true
        ) then

            table.insert(
                found,
                CreateResult(
                    object,
                    "Search"
                )
            )

        end

    end

    Results.SearchResults = found

    print("================================")
    print(
        "[Scanner] SEARCH:",
        text
    )
    print("================================")

    for index, result in ipairs(found) do

        print(
            "[" .. index .. "]",
            result.FullName,
            "|",
            result.ClassName,
            "| Type:",
            result.Type
        )

    end

    print("--------------------------------")

    print(
        "[Scanner] Encontrados:",
        #found
    )

    print("================================")

    return found

end

-- ========================================================
-- GETTERS
-- ========================================================

function Scanner.GetResults()

    return Results

end

function Scanner.GetModels()

    return Results.Models

end

function Scanner.GetHumanoids()

    return Results.Humanoids

end

function Scanner.GetQuestNPCs()

    return Results.QuestNPCs

end

function Scanner.GetPrompts()

    return Results.Prompts

end

function Scanner.GetEntities()

    return Results.Entities

end

function Scanner.GetSearchResults()

    return Results.SearchResults

end

function Scanner.GetLastScan()

    return Results.LastScan

end

-- ========================================================
-- FIND BY TYPE
-- ========================================================

function Scanner.GetEntitiesByType(entityType)

    if type(entityType) ~= "string" then
        return {}
    end

    local found = {}

    for _, entity in ipairs(Results.Entities) do

        if entity.Type == entityType then

            table.insert(
                found,
                entity
            )

        end

    end

    return found

end

-- ========================================================
-- FIND BY NAME
-- ========================================================

function Scanner.FindByName(name)

    if type(name) ~= "string" then
        return {}
    end

    local wanted = string.lower(name)
    local found = {}

    for _, entity in ipairs(Results.Entities) do

        if string.lower(entity.Name) == wanted then

            table.insert(
                found,
                entity
            )

        end

    end

    return found

end

-- ========================================================
-- DEBUG
-- ========================================================

function Scanner.Debug()

    print("================================")
    print("[Scanner] DEBUG")
    print("================================")

    print(
        "Workspace:",
        workspace:GetFullName()
    )

    print(
        "Known Quest NPCs:",
        #KnownQuestNames
    )

    print(
        "Max Depth:",
        MAX_DEPTH
    )

    print(
        "Models:",
        #Results.Models
    )

    print(
        "Humanoids:",
        #Results.Humanoids
    )

    print(
        "Quest NPCs:",
        #Results.QuestNPCs
    )

    print(
        "Prompts:",
        #Results.Prompts
    )

    print(
        "Entities:",
        #Results.Entities
    )

    print(
        "Search Results:",
        #Results.SearchResults
    )

    print(
        "Last Scan:",
        Results.LastScan
    )

    print("================================")

end

-- ========================================================
-- MODULE INFO
-- ========================================================

function Scanner.GetKnownQuestNames()

    return KnownQuestNames

end

function Scanner.GetMaxDepth()

    return MAX_DEPTH

end

return Scanner