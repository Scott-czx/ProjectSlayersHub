local Services = {}

-- ========================================================
-- REGISTRY
-- ========================================================

local Registry = {}

-- ========================================================
-- REGISTER
-- ========================================================

function Services.Register(name, service)

    if type(name) ~= "string" then
        error("[Services] O nome do service precisa ser string.")
    end

    if type(service) ~= "table" then
        error(
            "[Services] O service '" 
            .. name 
            .. "' precisa ser uma tabela."
        )
    end

    if Registry[name] ~= nil then
        warn(
            "[Services] Service '" 
            .. name 
            .. "' já estava registrado. Substituindo."
        )
    end

    Registry[name] = service

    print(
        "[Services] Registrado:",
        name
    )

    return service
end

-- ========================================================
-- GET
-- ========================================================

function Services.Get(name)

    return Registry[name]
end

-- ========================================================
-- HAS
-- ========================================================

function Services.Has(name)

    return Registry[name] ~= nil
end

-- ========================================================
-- REMOVE
-- ========================================================

function Services.Remove(name)

    if Registry[name] == nil then
        return false
    end

    Registry[name] = nil

    print(
        "[Services] Removido:",
        name
    )

    return true
end

-- ========================================================
-- CLEAR
-- ========================================================

function Services.Clear()

    Registry = {}

    print("[Services] Registry limpa.")
end

-- ========================================================
-- GET ALL
-- ========================================================

function Services.GetAll()

    return Registry
end

-- ========================================================
-- RUN
-- ========================================================

function Services.Run(name, methodName, ...)

    local service = Registry[name]

    if service == nil then
        warn(
            "[Services] Service não encontrado:",
            name
        )

        return false, "Service não encontrado"
    end

    local method = service[methodName]

    if type(method) ~= "function" then
        warn(
            "[Services] Método não encontrado:",
            name,
            methodName
        )

        return false, "Método não encontrado"
    end

    local success, result = pcall(
        method,
        service,
        ...
    )

    if not success then
        warn(
            "[Services] Erro ao executar:",
            name,
            methodName,
            result
        )

        return false, result
    end

    return true, result
end

-- ========================================================
-- DEBUG
-- ========================================================

function Services.Debug()

    print("================================")
    print("[Services] Registry")
    print("================================")

    for name, service in pairs(Registry) do

        print(
            "[Services]",
            name,
            service
        )

    end

    print("================================")
end

return Services