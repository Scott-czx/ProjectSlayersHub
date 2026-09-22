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

-- ========================================================
-- INSTANCE INFO
-- ========================================================

local function PrintBasicInfo(object)

    print(
        "[Scanner]",
        GetFullName(object),
        "| Class:",
        GetClassName(object)
    )

end

-- ========================================================
-- ATTRIBUTES
-- ========================================================

local function ScanAttributes(object)

    local success, attributes = pcall(function()
        return object:GetAttributes()
    end)

    if not success then
        return
    end

    for name, value in pairs(attributes) do

        print(
            "    [Attribute]",
            tostring(name),
            "=",
            tostring(value)
        )

    end

end

-- ========================================================
-- CHILDREN
-- ========================================================

local function ScanChildren(object, depth)

    if depth > MAX_DEPTH then
        return
    end

    local success, children = pcall(function()
        return object:GetChildren()
    end)

    if not success then
        return
    end

    for _, child in ipairs(children) do

        local prefix = string.rep(
            "    ",
            depth
        )

        print(
            prefix
            .. "[Child] "
            .. child.Name
            .. " | "
            .. GetClassName(child)
        )

        ScanAttributes(child)

        ScanChildren(
            child,
            depth + 1
        )

    end

end

-- ========================================================
-- HUMANOID
-- ========================================================

local function ScanHumanoid(model)

    if not model:IsA("Model") then
        return
    end

    local humanoid = model:FindFirstChildOfClass(
        "Humanoid"
    )

    if humanoid == nil then
        return
    end

    print(
        "    [Humanoid]",
        "Health=" .. tostring(humanoid.Health),
        "MaxHealth=" .. tostring(humanoid.MaxHealth)
    )

end

-- ========================================================
-- PROMPTS
-- ========================================================

local function ScanPrompts(object)

    local descendants = object:GetDescendants()

    for _, descendant in ipairs(descendants) do

        if descendant:IsA("ProximityPrompt") then

            print(
                "    [ProximityPrompt]",
                descendant:GetFullName()
            )

            print(
                "        ActionText:",
                descendant.ActionText
            )

            print(
                "        ObjectText:",
                descendant.ObjectText
            )

            print(
                "        Enabled:",
                descendant.Enabled
            )

        end

    end

end

-- ========================================================
-- QUEST NPC SCAN
-- ========================================================

function Scanner.ScanQuestNPCs()

    print("================================")
    print("[Scanner] PROJECT SLAYERS 2")
    print("[Scanner] QUEST NPC SCAN")
    print("================================")

    local found = 0

    for _, object in ipairs(workspace:GetDescendants()) do

        if object:IsA("Model") then

            if IsKnownName(object.Name) then

                found = found + 1

                print("")
                print("--------------------------------")
                print("[Quest NPC #" .. found .. "]")
                print("--------------------------------")

                PrintBasicInfo(object)

                ScanAttributes(object)

                ScanHumanoid(object)

                ScanPrompts(object)

                ScanChildren(
                    object,
                    1
                )

            end

        end

    end

    print("")
    print("================================")
    print(
        "[Scanner] NPCs encontrados:",
        found
    )
    print("================================")

    return found
end

-- ========================================================
-- ALL MODELS
-- ========================================================

function Scanner.ScanModels()

    print("================================")
    print("[Scanner] TODOS OS MODELS")
    print("================================")

    local count = 0

    for _, object in ipairs(workspace:GetDescendants()) do

        if object:IsA("Model") then

            count = count + 1

            print(
                "[Model]",
                object:GetFullName()
            )

        end

    end

    print(
        "[Scanner] Total de Models:",
        count
    )

    print("================================")

    return count
end

-- ========================================================
-- SEARCH
-- ========================================================

function Scanner.Search(text)

    if type(text) ~= "string" then
        return 0
    end

    local wanted = string.lower(text)

    local found = 0

    print("================================")
    print(
        "[Scanner] SEARCH:",
        text
    )
    print("================================")

    for _, object in ipairs(workspace:GetDescendants()) do

        local objectName = string.lower(
            object.Name
        )

        if string.find(
            objectName,
            wanted,
            1,
            true
        ) then

            found = found + 1

            print(
                "[" .. found .. "]",
                object:GetFullName(),
                "|",
                object.ClassName
            )

        end

    end

    print("================================")

    print(
        "[Scanner] Encontrados:",
        found
    )

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

    print("================================")

end

return Scanner