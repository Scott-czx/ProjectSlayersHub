local State = {

    -- ========================================================
    -- GENERAL
    -- ========================================================

    Visible = true,

    -- ========================================================
    -- FARM
    -- ========================================================

    -- Mobs
    TargetMob = nil,
    FarmMobs = false,
    MobKillAura = false,
    FarmOffsetX = 0,
    FarmOffsetY = 0,
    FarmOffsetZ = 0,
    FarmDistance = 5,

    -- Loot
    AutoLootChests = false,
    PickupAura = false,

    -- Boss
    TargetBoss = nil,
    BossFarm = false,

    -- Quest
    TargetQuest = nil,
    AutoQuest = false,

    -- Players
    TargetPlayer = nil,
    FarmPlayer = false,
    PlayerKillAura = false,
    PlayerFarmOffsetX = 0,
    PlayerFarmOffsetY = 0,
    PlayerFarmOffsetZ = 0,
    PlayerFarmDistance = 5,

    -- ========================================================
    -- COMBAT
    -- ========================================================

    CombatKillAura = false,
    KillAuraSpeed = 10,
    InstaKill = false,
    HPThreshold = 100,
    CombatRange = 25,
    ShowOwnership = false,

    -- ========================================================
    -- PLAYER
    -- ========================================================

    -- Movement
    Fly = false,
    FlySpeed = 50,

    Speedhack = false,
    WalkSpeed = 16,

    InfiniteJump = false,
    JumpHeight = 50,

    IgnoreJumpLock = false,
    BunnyHop = false,
    Noclip = false,

    -- Utility
    NoAnims = false,
    AnimSpeed = 1,
    UtilitySpeed = 16,

    AntiAFK = false,

    KillSelfRequested = false,
    TPBackOnDeath = false,

    NoKillbricks = false,
    AntiVoid = false,
    NoSlow = false,

    -- Misc
    InfiniteYield = false,
    AutoRejoin = false,

    KickTimer = false,
    KickMinutes = 10,

    JoinLeaveLogger = false,

    ServerHopRequested = false,
    RejoinServerRequested = false,

    ChatLogger = false,

    SpamMessage = "",
    ChatDelay = 1,
    ChatSpammer = false,

    -- Identity
    DisplayName = "",
    Username = "",

    IdentityApplyRequested = false,
    IdentityResetRequested = false,

    IdentityPlayer = nil,
    IdentityRefreshRequested = false,

    HideCharacter = false,
    HideOtherPlayers = false,
    HideAllPlayers = false,
    HideAllNames = false,

    -- ========================================================
    -- ESP
    -- ========================================================

    -- Main ESP
    PlayerESP = false,
    PlayerESPColor = Color3.fromRGB(255, 255, 255),
    ShowLocalPlayer = false,

    MobESP = false,
    MobESPColor = Color3.fromRGB(255, 255, 255),

    NPCESP = false,
    NPCESPColor = Color3.fromRGB(255, 255, 255),

    ESPTarget = nil,
    ESPRefreshRequested = false,

    ESPSinglePlayer = false,
    ESPNearestOnly = false,

    -- ESP Config
    ESPBoxes = false,
    ESPBoxGlow = false,
    ESPChams = false,
    ESPName = false,
    ESPDistance = false,
    ESPHealthBar = false,
    ESPWeapon = false,

    ESPMaxDistance = 500,

    ESPBoxType = "Full",

    GlowTopTransparency = 50,
    GlowBottomTransparency = 50,

    ChamsFillTransparency = 50,

    ChamsColor = Color3.fromRGB(255, 255, 255),

    BoxTopColor = Color3.fromRGB(255, 255, 255),
    BoxBottomColor = Color3.fromRGB(255, 255, 255),

    -- ========================================================
    -- WORLD
    -- ========================================================

    -- Camera
    SpectatePlayer = nil,
    SpectateRequested = false,
    StopSpectateRequested = false,

    -- World Visual
    NoFog = false,
    NoAtmosphere = false,
    FullBright = false,

    Brightness = 2,

    WorldAmbient = false,
    AmbientColor = Color3.fromRGB(255, 255, 255),

    -- Time
    ForceTimeOfDay = false,
    WorldHour = 12,

    -- Free Cam
    FreeCam = false,
    LookSensitivity = 50,
    FreeCamMoveSpeed = 50,

    -- Camera Settings
    ForceThirdPerson = false,

    CustomFOV = false,
    CameraFOV = 70,

    InfiniteZoom = false,
    XRay = false,

    -- Performance
    FPSCap = 60,
    No3DRender = false,
    PotatoMode = false,
    HideMap = false,

    -- Safety
    NearbyAlert = false,
    AlertRange = 100,

    KickNearby = false,
    KickRange = 100,

    StaffDetection = false,
    KickOnStaffJoin = false,

    SetRetreatPositionRequested = false,
    ClearRetreatPositionRequested = false,

    AutoRetreat = false,
    RetreatHP = 25,

    -- ========================================================
    -- NAVIGATION
    -- ========================================================

    -- Coordinates
    TweenToRequested = false,
    CopyPositionRequested = false,
    ClickTP = false,

    -- Teleport Settings
    TweenSpeed = 100,
    TweenBypass = false,

    -- Places
    SelectedPlace = nil,
    RefreshPlacesRequested = false,
    TeleportToPlaceRequested = false,

    -- NPC
    SelectedNPC = nil,
    TeleportToNPCRequested = false,
    RefreshNPCsRequested = false,

    -- Players
    SelectedTeleportPlayer = nil,
    TeleportToPlayerRequested = false,
    RefreshTeleportPlayersRequested = false,

    -- Mobs
    SelectedTeleportMob = nil,
    TeleportToMobRequested = false,
    RefreshTeleportMobsRequested = false,

    -- Regions
    SelectedRegion = nil,
    TeleportToRegionRequested = false,

    -- Special Teleports
    TeleportSpawnCrystalRequested = false,

    SpiderLilyFarm = false,
    TeleportNearestLilyRequested = false,

    -- Attach
    AttachTarget = nil,
    AttachPlayer = nil,

    AttachRange = 25,
    AttachDistance = 5,
    AttachHeight = 0,

    AttachTargetEnabled = false,
    AttachPlayerEnabled = false,

    -- Fling / Anti Fling
    FlingTargetRequested = false,
    FlingPlayerRequested = false,

    AntiFling = false,

    RefreshAttachTargetsRequested = false,
}

return State