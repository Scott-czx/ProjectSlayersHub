local Quests = {}

-- ========================================================
-- STATE
-- ========================================================

local State = nil

-- ========================================================
-- PROJECT SLAYERS 2
-- QUEST NPCS
-- ========================================================

local KnownQuestNPCs = {
    "Krue",
    "Tom",
    "Chaka",
    "Wagwan",
    "Jugg",
    "Goro",
    "Tomoi",
    "Mitsu",
    "Kasugai Crow",
}

-- ========================================================
-- INIT
-- ========================================================

function Quests.Init(SharedState)

    if type(SharedState) ~= "table" then
        error("[Quests] State inválido.")
    end

    State = SharedState

    print("[Quests] Inicializado.")
    print(
        "[Quests] Project Slayers 2 - NPCs conhecidos:",
        #KnownQuestNPCs
    )

    return Quests
end

-- ========================================================
-- STATE
-- ========================================================

function Quests.GetState()

    return State
end

-- ========================================================
-- TARGET
-- ========================================================

function Quests.SetTarget(target)

    if State == nil then
        warn("[Quests] State não inicializado.")
        return false
    end

    State.TargetQuest = target

    print(
        "[Quests] Target definido:",
        target
    )

    return true
end

function Quests.GetTarget()

    if State == nil then
        return nil
    end

    return State.TargetQuest
end

function Quests.ClearTarget()

    if State == nil then
        return false
    end

    State.TargetQuest = nil

    print("[Quests] Target removido.")

    return true
end

-- ========================================================
-- KNOWN QUEST NPCS
-- ========================================================

function Quests.GetKnownNPCNames()

    local result = {}

    for _, name in ipairs(KnownQuestNPCs) do

        table.insert(
            result,
            name
        )

    end

    return result
end

function Quests.IsKnownQuestNPC(name)

    if type(name) ~= "string" then
        return false
    end

    local wantedName = string.lower(name)

    for _, knownName in ipairs(KnownQuestNPCs) do

        if string.lower(knownName) == wantedName then
            return true
        end

    end

    return false
end

-- ========================================================
-- DISCOVERY
-- ========================================================

function Quests.GetCandidates()

    local candidates = {}

    local descendants = workspace:GetDescendants()

    for _, object in ipairs(descendants) do

        if object:IsA("Model") then

            if Quests.IsKnownQuestNPC(object.Name) then

                table.insert(
                    candidates,
                    object
                )

            end

        end

    end

    return candidates
end

-- ========================================================
-- FIND BY NAME
-- ========================================================

function Quests.FindByName(name)

    if type(name) ~= "string" then
        return nil
    end

    local wantedName = string.lower(name)

    local candidates = Quests.GetCandidates()

    for _, object in ipairs(candidates) do

        if string.lower(object.Name) == wantedName then
            return object
        end

    end

    return nil
end

-- ========================================================
-- FIND ALL BY NAME
-- ========================================================

function Quests.FindAllByName(name)

    local results = {}

    if type(name) ~= "string" then
        return results
    end

    local wantedName = string.lower(name)

    local candidates = Quests.GetCandidates()

    for _, object in ipairs(candidates) do

        if string.lower(object.Name) == wantedName then

            table.insert(
                results,
                object
            )

        end

    end

    return results
end

-- ========================================================
-- FIND ALL KNOWN QUEST NPCS
-- ========================================================

function Quests.FindKnownQuestNPCs()

    local results = {}

    local candidates = Quests.GetCandidates()

    for _, object in ipairs(candidates) do

        table.insert(
            results,
            object
        )

    end

    return results
end

-- ========================================================
-- CHECK VALID
-- ========================================================

function Quests.IsValid(object)

    if object == nil then
        return false
    end

    if not object:IsA("Model") then
        return false
    end

    return Quests.IsKnownQuestNPC(
        object.Name
    )
end

-- ========================================================
-- COUNT
-- ========================================================

function Quests.Count()

    local count = 0

    local candidates = Quests.GetCandidates()

    for _, object in ipairs(candidates) do

        if Quests.IsValid(object) then
            count = count + 1
        end

    end

    return count
end

-- ========================================================
-- DEBUG
-- ========================================================

function Quests.Debug()

    print("================================")
    print("[Quests] DEBUG")
    print("================================")

    print(
        "Inicializado:",
        State ~= nil
    )

    print(
        "Target:",
        Quests.GetTarget()
    )

    print(
        "NPCs conhecidos:",
        #KnownQuestNPCs
    )

    local candidates = Quests.GetCandidates()

    print(
        "Quest NPCs encontrados:",
        #candidates
    )

    for _, object in ipairs(candidates) do

        print(
            "[Quest NPC]",
            object:GetFullName()
        )

    end

    print("================================")

end

return Quests