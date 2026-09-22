local CONFIG_URL =
    "https://raw.githubusercontent.com/Scott-czx/ProjectSlayersHub/refs/heads/main/config.lua"

local function LoadModule(baseURL, path)

    local url = baseURL .. path

    local source = game:HttpGet(url)

    local success, result = pcall(function()
        return loadstring(source)()
    end)

    if not success then
        error(
            "[Loader] Falha ao carregar: "
            .. path
            .. "\n"
            .. tostring(result)
        )
    end

    return result
end

print("[ProjectSlayersHub] Iniciando...")

-- ========================================================
-- CONFIG
-- ========================================================

local ConfigSource = game:HttpGet(CONFIG_URL)

local ConfigSuccess, Config = pcall(function()
    return loadstring(ConfigSource)()
end)

if not ConfigSuccess then
    error(
        "[Loader] Falha ao carregar config.lua\n"
        .. tostring(Config)
    )
end

print("[ProjectSlayersHub] Config carregada.")
print("[ProjectSlayersHub] BaseURL:", Config.BaseURL)

-- ========================================================
-- UI
-- ========================================================

local UI = LoadModule(
    Config.BaseURL,
    "src/ui/init.lua"
)

print("[ProjectSlayersHub] UI carregada.")

-- ========================================================
-- INITIALIZE
-- ========================================================

local UISuccess, UIState = pcall(function()
    return UI.Init(Config)
end)

if not UISuccess then
    error(
        "[Loader] Falha ao inicializar UI\n"
        .. tostring(UIState)
    )
end

print("================================")
print(Config.ProjectName)
print("Versão: " .. Config.Version)
print("================================")
print("[ProjectSlayersHub] Projeto inicializado.")

return {
    Config = Config,
    UI = UI,
    UIState = UIState,
}