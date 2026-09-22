local Mobs = {}

-- ========================================================
-- STATE
-- ========================================================

local State = nil

-- ========================================================
-- INIT
-- ========================================================

function Mobs.Init(SharedState)

    if type(SharedState) ~= "table" then
        error("[Mobs] State inválido.")
    end

    State = SharedState

    print("[Mobs] Inicializado.")

    return Mobs
end

-- ========================================================
-- STATE
-- ========================================================

function Mobs.GetState()

    return State
end

-- ========================================================
-- TARGET
-- ========================================================

function Mobs.SetTarget(target)

    if State == nil then
        warn("[Mobs] State não inicializado.")
        return false
    end

    State.TargetMob = target

    print(
        "[Mobs] Target definido:",
        target
    )

    return true
end

function Mobs.GetTarget()

    if State == nil then
        return nil
    end

    return State.TargetMob
end

function Mobs.ClearTarget()

    if State == nil then
        return false
    end

    State.TargetMob = nil

    print("[Mobs] Target removido.")

    return true
end

-- ========================================================
-- DISCOVERY
-- ========================================================

function Mobs.GetCandidates()

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

function Mobs.FindByName(name)

    if type(name) ~= "string" then
        return nil
    end

    local candidates = Mobs.GetCandidates()

    local wantedName = string.lower(name)

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

function Mobs.FindAllByName(name)

    local results = {}

    if type(name) ~= "string" then
        return results
    end

    local wantedName = string.lower(name)

    local candidates = Mobs.GetCandidates()

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

function Mobs.IsAlive(object)

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

function Mobs.Count()

    local count = 0

    local candidates = Mobs.GetCandidates()

    for _, object in ipairs(candidates) do

        if Mobs.IsAlive(object) then
            count = count + 1
        end

    end

    return count
end

-- ========================================================
-- DEBUG
-- ========================================================

function Mobs.Debug()

    print("================================")
    print("[Mobs] DEBUG")
    print("================================")

    print(
        "Inicializado:",
        State ~= nil
    )

    print(
        "Target:",
        Mobs.GetTarget()
    )

    local candidates = Mobs.GetCandidates()

    print(
        "Entidades encontradas:",
        #candidates
    )

    print(
        "Entidades vivas:",
        Mobs.Count()
    )

    print("================================")

end

return Mobs