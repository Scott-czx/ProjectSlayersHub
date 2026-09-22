local Boss = {}

-- ========================================================
-- STATE
-- ========================================================

local State = nil

-- ========================================================
-- INIT
-- ========================================================

function Boss.Init(SharedState)

    if type(SharedState) ~= "table" then
        error("[Boss] State inválido.")
    end

    State = SharedState

    print("[Boss] Inicializado.")

    return Boss
end

-- ========================================================
-- STATE
-- ========================================================

function Boss.GetState()

    return State
end

-- ========================================================
-- TARGET
-- ========================================================

function Boss.SetTarget(target)

    if State == nil then
        warn("[Boss] State não inicializado.")
        return false
    end

    State.TargetBoss = target

    print(
        "[Boss] Target definido:",
        target
    )

    return true
end

function Boss.GetTarget()

    if State == nil then
        return nil
    end

    return State.TargetBoss
end

function Boss.ClearTarget()

    if State == nil then
        return false
    end

    State.TargetBoss = nil

    print("[Boss] Target removido.")

    return true
end

-- ========================================================
-- DISCOVERY
-- ========================================================

function Boss.GetCandidates()

    local candidates = {}

    local descendants = workspace:GetDescendants()

    for _, object in ipairs(descendants) do

        if object:IsA("Model") then

            local humanoid = object:FindFirstChildOfClass(
                "Humanoid"
            )

            if humanoid ~= nil then

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

function Boss.FindByName(name)

    if type(name) ~= "string" then
        return nil
    end

    local wantedName = string.lower(name)

    local candidates = Boss.GetCandidates()

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

function Boss.FindAllByName(name)

    local results = {}

    if type(name) ~= "string" then
        return results
    end

    local wantedName = string.lower(name)

    local candidates = Boss.GetCandidates()

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
-- CHECK ALIVE
-- ========================================================

function Boss.IsAlive(object)

    if object == nil then
        return false
    end

    if not object:IsA("Model") then
        return false
    end

    local humanoid = object:FindFirstChildOfClass(
        "Humanoid"
    )

    if humanoid == nil then
        return false
    end

    return humanoid.Health > 0
end

-- ========================================================
-- COUNT
-- ========================================================

function Boss.Count()

    local count = 0

    local candidates = Boss.GetCandidates()

    for _, object in ipairs(candidates) do

        if Boss.IsAlive(object) then
            count = count + 1
        end

    end

    return count
end

-- ========================================================
-- DEBUG
-- ========================================================

function Boss.Debug()

    print("================================")
    print("[Boss] DEBUG")
    print("================================")

    print(
        "Inicializado:",
        State ~= nil
    )

    print(
        "Target:",
        Boss.GetTarget()
    )

    local candidates = Boss.GetCandidates()

    print(
        "Entidades encontradas:",
        #candidates
    )

    print(
        "Entidades vivas:",
        Boss.Count()
    )

    print("================================")

end

return Boss