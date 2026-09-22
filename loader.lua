local BASE_URL = "https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPOSITORIO/main/"

local function LoadModule(path)
    local url = BASE_URL .. path

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

local function Log(message)
    print("[ProjectSlayersHub] " .. message)
end

Log("Iniciando...")

local Config = LoadModule("config.lua")

Log("Config carregada.")

local UI = LoadModule("src/ui/init.lua")

Log("UI carregada.")

local UIState = UI.Init(Config)

Log("================================")
Log(Config.ProjectName)
Log("Versão: " .. Config.Version)
Log("================================")
Log("Projeto inicializado.")

return {
    Config = Config,
    UI = UI,
    UIState = UIState,
}