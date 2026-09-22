local FarmService = {}

-- ========================================================
-- STATE
-- ========================================================

local State = nil

-- ========================================================
-- MODULES
-- ========================================================

local Mobs = nil
local Boss = nil
local Quests = nil
local Scanner = nil

-- ========================================================
-- INTERNAL
-- ========================================================

local Running = false

-- ========================================================
-- INIT
-- ========================================================

function FarmService.Init(
    SharedState,
    MobsModule,
    BossModule,
    QuestsModule
)

    if type(SharedState) ~= "table" then
        error("[FarmService] State inválido.")
    end

    if type(MobsModule) ~= "table" then
        error("[FarmService] MobsModule inválido.")
    end

    if type(BossModule) ~= "table" then
        error("[FarmService] BossModule inválido.")
    end

    if type(QuestsModule) ~= "table" then
        error("[FarmService] QuestsModule inválido.")
    end

    State = SharedState
    Mobs = MobsModule
    Boss = BossModule
    Quests = QuestsModule

    -- Scanner é registrado antes do FarmService.
    if State.Services
        and type(State.Services.Get) == "function" then

        Scanner = State.Services.Get("Scanner")

    end

    Mobs.Init(State)
    Boss.Init(State)
    Quests.Init(State)

    print("[FarmService] Inicializado.")
    print("[FarmService] Mobs conectado.")
    print("[FarmService] Boss conectado.")
    print("[FarmService] Quests conectado.")

    if Scanner ~= nil then
        print("[FarmService] Scanner conectado.")
    else
        warn("[FarmService] Scanner não encontrado.")
    end

    return FarmService
end

-- ========================================================
-- STATE
-- ========================================================

function FarmService.GetState()

    return State
end

-- ========================================================
-- MODULES
-- ========================================================

function FarmService.GetMobs()

    return Mobs
end

function FarmService.GetBoss()

    return Boss
end

function FarmService.GetQuests()

    return Quests
end

function FarmService.GetScanner()

    return Scanner
end

-- ========================================================
-- SCANNER
-- ========================================================

function FarmService.Scan()

    if Scanner == nil then
        warn("[FarmService] Scanner não inicializado.")
        return nil
    end

    local success, result = pcall(function()
        return Scanner.Scan()
    end)

    if not success then
        warn(
            "[FarmService] Falha no Scanner:",
            result
        )

        return nil
    end

    return result
end

function FarmService.GetScanResults()

    if Scanner == nil then
        return nil
    end

    return Scanner.GetResults()
end

function FarmService.GetScannedEntities()

    if Scanner == nil then
        return {}
    end

    return Scanner.GetEntities()
end

function FarmService.GetScannedModels()

    if Scanner == nil then
        return {}
    end

    return Scanner.GetModels()
end

function FarmService.GetScannedHumanoids()

    if Scanner == nil then
        return {}
    end

    return Scanner.GetHumanoids()
end

function FarmService.GetScannedQuestNPCs()

    if Scanner == nil then
        return {}
    end

    return Scanner.GetQuestNPCs()
end

function FarmService.GetScannedPrompts()

    if Scanner == nil then
        return {}
    end

    return Scanner.GetPrompts()
end

function FarmService.SearchScanned(text)

    if Scanner == nil then
        return {}
    end

    return Scanner.Search(text)
end

function FarmService.GetScannedByType(entityType)

    if Scanner == nil then
        return {}
    end

    return Scanner.GetEntitiesByType(entityType)
end

function FarmService.FindScannedByName(name)

    if Scanner == nil then
        return {}
    end

    return Scanner.FindByName(name)
end

function FarmService.DebugScanner()

    if Scanner == nil then
        warn("[FarmService] Scanner não inicializado.")
        return false
    end

    Scanner.Debug()

    return true
end

-- ========================================================
-- STATUS
-- ========================================================

function FarmService.IsRunning()

    return Running
end

-- ========================================================
-- START
-- ========================================================

function FarmService.Start()

    if State == nil then
        warn("[FarmService] State não inicializado.")
        return false
    end

    if Mobs == nil then
        warn("[FarmService] Mobs não inicializado.")
        return false
    end

    if Boss == nil then
        warn("[FarmService] Boss não inicializado.")
        return false
    end

    if Quests == nil then
        warn("[FarmService] Quests não inicializado.")
        return false
    end

    if Running then
        return false
    end

    Running = true

    print("[FarmService] Farm iniciado.")

    return true
end

-- ========================================================
-- STOP
-- ========================================================

function FarmService.Stop()

    if not Running then
        return false
    end

    Running = false

    print("[FarmService] Farm parado.")

    return true
end

-- ========================================================
-- MOB TARGET
-- ========================================================

function FarmService.SetMobTarget(target)

    if Mobs == nil then
        warn("[FarmService] Mobs não inicializado.")
        return false
    end

    return Mobs.SetTarget(target)
end

function FarmService.GetMobTarget()

    if Mobs == nil then
        return nil
    end

    return Mobs.GetTarget()
end

function FarmService.ClearMobTarget()

    if Mobs == nil then
        return false
    end

    return Mobs.ClearTarget()
end

-- ========================================================
-- MOB DISCOVERY
-- ========================================================

function FarmService.GetMobCandidates()

    if Mobs == nil then
        return {}
    end

    return Mobs.GetCandidates()
end

function FarmService.FindMob(name)

    if Mobs == nil then
        return nil
    end

    return Mobs.FindByName(name)
end

function FarmService.FindMobs(name)

    if Mobs == nil then
        return {}
    end

    return Mobs.FindAllByName(name)
end

function FarmService.GetMobCount()

    if Mobs == nil then
        return 0
    end

    return Mobs.Count()
end

function FarmService.IsMobAlive(object)

    if Mobs == nil then
        return false
    end

    return Mobs.IsAlive(object)
end

function FarmService.DebugMobs()

    if Mobs == nil then
        warn("[FarmService] Mobs não inicializado.")
        return false
    end

    Mobs.Debug()

    return true
end

-- ========================================================
-- BOSS TARGET
-- ========================================================

function FarmService.SetBossTarget(target)

    if Boss == nil then
        warn("[FarmService] Boss não inicializado.")
        return false
    end

    return Boss.SetTarget(target)
end

function FarmService.GetBossTarget()

    if Boss == nil then
        return nil
    end

    return Boss.GetTarget()
end

function FarmService.ClearBossTarget()

    if Boss == nil then
        return false
    end

    return Boss.ClearTarget()
end

-- ========================================================
-- BOSS DISCOVERY
-- ========================================================

function FarmService.GetBossCandidates()

    if Boss == nil then
        return {}
    end

    return Boss.GetCandidates()
end

function FarmService.FindBoss(name)

    if Boss == nil then
        return nil
    end

    return Boss.FindByName(name)
end

function FarmService.FindBosses(name)

    if Boss == nil then
        return {}
    end

    return Boss.FindAllByName(name)
end

function FarmService.GetBossCount()

    if Boss == nil then
        return 0
    end

    return Boss.Count()
end

function FarmService.IsBossAlive(object)

    if Boss == nil then
        return false
    end

    return Boss.IsAlive(object)
end

function FarmService.DebugBoss()

    if Boss == nil then
        warn("[FarmService] Boss não inicializado.")
        return false
    end

    Boss.Debug()

    return true
end

-- ========================================================
-- QUEST TARGET
-- ========================================================

function FarmService.SetQuestTarget(target)

    if Quests == nil then
        warn("[FarmService] Quests não inicializado.")
        return false
    end

    return Quests.SetTarget(target)
end

function FarmService.GetQuestTarget()

    if Quests == nil then
        return nil
    end

    return Quests.GetTarget()
end

function FarmService.ClearQuestTarget()

    if Quests == nil then
        return false
    end

    return Quests.ClearTarget()
end

-- ========================================================
-- QUEST DISCOVERY
-- ========================================================

function FarmService.GetQuestCandidates()

    if Quests == nil then
        return {}
    end

    return Quests.GetCandidates()
end

function FarmService.FindQuest(name)

    if Quests == nil then
        return nil
    end

    return Quests.FindByName(name)
end

function FarmService.FindQuests(name)

    if Quests == nil then
        return {}
    end

    return Quests.FindAllByName(name)
end

function FarmService.GetQuestCount()

    if Quests == nil then
        return 0
    end

    return Quests.Count()
end

function FarmService.IsQuestValid(object)

    if Quests == nil then
        return false
    end

    return Quests.IsValid(object)
end

function FarmService.DebugQuests()

    if Quests == nil then
        warn("[FarmService] Quests não inicializado.")
        return false
    end

    Quests.Debug()

    return true
end

-- ========================================================
-- RESET
-- ========================================================

function FarmService.Reset()

    Running = false

    if Mobs ~= nil then
        Mobs.ClearTarget()
    end

    if Boss ~= nil then
        Boss.ClearTarget()
    end

    if Quests ~= nil then
        Quests.ClearTarget()
    end

    if State ~= nil then

        State.TargetMob = nil
        State.FarmMobs = false
        State.MobKillAura = false

        State.TargetBoss = nil
        State.BossFarm = false

        State.TargetQuest = nil
        State.AutoQuest = false

    end

    print("[FarmService] Estado resetado.")

    return true
end

-- ========================================================
-- DEBUG
-- ========================================================

function FarmService.Debug()

    print("================================")
    print("[FarmService] DEBUG")
    print("================================")

    print(
        "State:",
        State ~= nil
    )

    print(
        "Mobs:",
        Mobs ~= nil
    )

    print(
        "Boss:",
        Boss ~= nil
    )

    print(
        "Quests:",
        Quests ~= nil
    )

    print(
        "Scanner:",
        Scanner ~= nil
    )

    print(
        "Running:",
        Running
    )

    if Scanner ~= nil then

        local results = Scanner.GetResults()

        print(
            "Scanner Models:",
            #results.Models
        )

        print(
            "Scanner Humanoids:",
            #results.Humanoids
        )

        print(
            "Scanner Quest NPCs:",
            #results.QuestNPCs
        )

        print(
            "Scanner Prompts:",
            #results.Prompts
        )

        print(
            "Scanner Entities:",
            #results.Entities
        )

    end

    if Mobs ~= nil then

        print(
            "Mob Target:",
            Mobs.GetTarget()
        )

        print(
            "Mob Candidates:",
            #Mobs.GetCandidates()
        )

        print(
            "Mob Count:",
            Mobs.Count()
        )

    end

    if Boss ~= nil then

        print(
            "Boss Target:",
            Boss.GetTarget()
        )

        print(
            "Boss Candidates:",
            #Boss.GetCandidates()
        )

        print(
            "Boss Count:",
            Boss.Count()
        )

    end

    if Quests ~= nil then

        print(
            "Quest Target:",
            Quests.GetTarget()
        )

        print(
            "Quest Candidates:",
            #Quests.GetCandidates()
        )

        print(
            "Quest Count:",
            Quests.Count()
        )

    end

    print("================================")

end

return FarmService