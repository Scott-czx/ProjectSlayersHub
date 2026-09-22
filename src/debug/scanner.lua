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

    return {
        Instance = model,
        Humanoid = humanoid,
        Name = model.Name,
        FullName = GetFullName(model),
        Health = humanoid.Health,
        MaxHealth = humanoid.MaxHealth,
    }
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
        LastScan = 0,
    }

    print("[Scanner] Resultados limpos.")

end

-- ========================================================
-- SCAN MODELS
-- ========================================================

function Scanner.ScanModels()

    local models = {}

    local success, descendants = pcall(function()
        return workspace:GetDescendants()
    end)

    if not success then
        warn(
            "[Scanner] Falha ao obter descendants:",
            descendants
        )

        return models
    end

    for _, object in ipairs(descendants) do

        if object:IsA("Model") then

            table.insert(models, {
                Instance = object,
                Name = object.Name,
                FullName = GetFullName(object),
                ClassName = GetClassName(object),
                Attributes = GetAttributes(object),
            })

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

    local success, descendants = pcall(function()
        return workspace:GetDescendants()
    end)

    if not success then
        warn(
            "[Scanner] Falha ao obter descendants:",
            descendants
        )

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

    local success, descendants = pcall(function()
        return workspace:GetDescendants()
    end)

    if not success then
        warn(
            "[Scanner] Falha ao obter descendants:",
            descendants
        )

        return questNPCs
    end

    for _, object in ipairs(descendants) do

        if object:IsA("Model") and IsKnownName(object.Name) then

            local humanoidInfo = GetHumanoidInfo(object)

            local entry = {
                Instance = object,
                Name = object.Name,
                FullName = GetFullName(object),
                ClassName = GetClassName(object),
                Attributes = GetAttributes(object),
                Humanoid = humanoidInfo,
            }

            table.insert(
                questNPCs,
                entry
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

    local success, descendants = pcall(function()
        return workspace:GetDescendants()
    end)

    if not success then
        warn(
            "[Scanner] Falha ao obter descendants:",
            descendants
        )

        return prompts
    end

    for _, object in ipairs(descendants) do

        if object:IsA("ProximityPrompt") then

            table.insert(
                prompts,
                {
                    Instance = object,
                    Name = object.Name,
                    FullName = GetFullName(object),
                    ActionText = object.ActionText,
                    ObjectText = object.ObjectText,
                    Enabled = object.Enabled,
                }
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

    local found = {}

    local success, descendants = pcall(function()
        return workspace:GetDescendants()
    end)

    if not success then
        warn(
            "[Scanner] Falha ao pesquisar:",
            descendants
        )

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
                {
                    Instance = object,
                    Name = object.Name,
                    FullName = GetFullName(object),
                    ClassName = GetClassName(object),
                }
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
            result.ClassName
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

function Scanner.GetSearchResults()

    return Results.SearchResults

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

return Scanner