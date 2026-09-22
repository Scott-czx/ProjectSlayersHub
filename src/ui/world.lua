local WorldUI = {}

function WorldUI.Init(Tab, State)

    if Tab == nil then
        error("[WorldUI] Tab inválida.")
    end

    if type(State) ~= "table" then
        error("[WorldUI] State inválido.")
    end

    print("[UI] World inicializado.")

    Tab:CreateText({
        name = "World",
        text = "Configurações do mundo."
    })

    Tab:CreateToggle({
        name = "No Fog",
        value = State.NoFog or false,
        callback = function(value)
            State.NoFog = value
            print("[World] No Fog:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "No Atmosphere",
        value = State.NoAtmosphere or false,
        callback = function(value)
            State.NoAtmosphere = value
            print("[World] No Atmosphere:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "Full Bright",
        value = State.FullBright or false,
        callback = function(value)
            State.FullBright = value
            print("[World] Full Bright:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateSlider({
        name = "Brightness",
        range = {0, 10},
        increment = 0.1,
        value = State.Brightness or 2,
        callback = function(value)
            State.Brightness = value
            print("[World] Brightness:", value)
        end,
    })

    Tab:CreateToggle({
        name = "World Ambient",
        value = State.WorldAmbient or false,
        callback = function(value)
            State.WorldAmbient = value
            print("[World] World Ambient:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateColorPicker({
        name = "Ambient Color",
        color = State.AmbientColor or Color3.fromRGB(255, 255, 255),
        callback = function(value)
            State.AmbientColor = value
            print("[World] Ambient Color alterada.")
        end,
    })

    Tab:CreateToggle({
        name = "Force Time Of Day",
        value = State.ForceTimeOfDay or false,
        callback = function(value)
            State.ForceTimeOfDay = value
            print("[World] Force Time Of Day:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateSlider({
        name = "World Hour",
        range = {0, 24},
        increment = 1,
        value = State.WorldHour or 12,
        suffix = ":00",
        callback = function(value)
            State.WorldHour = value
            print("[World] World Hour:", value)
        end,
    })

    Tab:CreateText({
        name = "Camera",
        text = "Configurações relacionadas à câmera."
    })

    Tab:CreateToggle({
        name = "Free Cam",
        value = State.FreeCam or false,
        callback = function(value)
            State.FreeCam = value
            print("[World] Free Cam:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateSlider({
        name = "Look Sensitivity",
        range = {1, 100},
        increment = 1,
        value = State.LookSensitivity or 50,
        callback = function(value)
            State.LookSensitivity = value
        end,
    })

    Tab:CreateSlider({
        name = "Free Cam Move Speed",
        range = {1, 200},
        increment = 1,
        value = State.FreeCamMoveSpeed or 50,
        callback = function(value)
            State.FreeCamMoveSpeed = value
        end,
    })

    Tab:CreateToggle({
        name = "Force Third Person",
        value = State.ForceThirdPerson or false,
        callback = function(value)
            State.ForceThirdPerson = value
            print("[World] Force Third Person:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "Custom FOV",
        value = State.CustomFOV or false,
        callback = function(value)
            State.CustomFOV = value
            print("[World] Custom FOV:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateSlider({
        name = "Camera FOV",
        range = {30, 120},
        increment = 1,
        value = State.CameraFOV or 70,
        callback = function(value)
            State.CameraFOV = value
        end,
    })

    Tab:CreateToggle({
        name = "Infinite Zoom",
        value = State.InfiniteZoom or false,
        callback = function(value)
            State.InfiniteZoom = value
            print("[World] Infinite Zoom:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateText({
        name = "Performance",
        text = "Configurações relacionadas ao desempenho."
    })

    Tab:CreateSlider({
        name = "FPS Cap",
        range = {30, 300},
        increment = 1,
        value = State.FPSCap or 60,
        suffix = " FPS",
        callback = function(value)
            State.FPSCap = value
        end,
    })

    Tab:CreateToggle({
        name = "No 3D Render",
        value = State.No3DRender or false,
        callback = function(value)
            State.No3DRender = value
            print("[World] No 3D Render:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "Potato Mode",
        value = State.PotatoMode or false,
        callback = function(value)
            State.PotatoMode = value
            print("[World] Potato Mode:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateText({
        name = "World Visibility",
        text = "Configurações de visibilidade do mapa e jogadores."
    })

    Tab:CreateToggle({
        name = "X-Ray",
        value = State.XRay or false,
        callback = function(value)
            State.XRay = value
            print("[World] X-Ray:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "Hide Map",
        value = State.HideMap or false,
        callback = function(value)
            State.HideMap = value
            print("[World] Hide Map:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateText({
        name = "Nearby Alerts",
        text = "Configurações de detecção de jogadores próximos."
    })

    Tab:CreateToggle({
        name = "Nearby Alert",
        value = State.NearbyAlert or false,
        callback = function(value)
            State.NearbyAlert = value
            print("[World] Nearby Alert:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateSlider({
        name = "Alert Range",
        range = {10, 500},
        increment = 10,
        value = State.AlertRange or 100,
        suffix = " studs",
        callback = function(value)
            State.AlertRange = value
        end,
    })

    Tab:CreateToggle({
        name = "Staff Detection",
        value = State.StaffDetection or false,
        callback = function(value)
            State.StaffDetection = value
            print("[World] Staff Detection:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateToggle({
        name = "Kick On Staff Join",
        value = State.KickOnStaffJoin or false,
        callback = function(value)
            State.KickOnStaffJoin = value
            print("[World] Kick On Staff Join:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateText({
        name = "Retreat",
        text = "Configurações de posição de recuo."
    })

    Tab:CreateButton({
        name = "Set Retreat Position",
        callback = function()
            State.SetRetreatPositionRequested = true
            print("[World] Set Retreat Position solicitado.")
        end,
    })

    Tab:CreateButton({
        name = "Clear Retreat Position",
        callback = function()
            State.ClearRetreatPositionRequested = true
            print("[World] Clear Retreat Position solicitado.")
        end,
    })

    Tab:CreateToggle({
        name = "Auto Retreat",
        value = State.AutoRetreat or false,
        callback = function(value)
            State.AutoRetreat = value
            print("[World] Auto Retreat:", value and "ON" or "OFF")
        end,
    })

    Tab:CreateSlider({
        name = "Retreat HP",
        range = {1, 100},
        increment = 1,
        value = State.RetreatHP or 25,
        suffix = "%",
        callback = function(value)
            State.RetreatHP = value
        end,
    })

    Tab:CreateText({
        name = "World Debug",
        text = "Ferramentas de diagnóstico da configuração World."
    })

    Tab:CreateButton({
        name = "World Debug Test",
        description = "Mostra os valores atuais do State.",
        callback = function()
            print("================================")
            print("[WorldUI] DEBUG")
            print("================================")
            print("NoFog:", State.NoFog)
            print("NoAtmosphere:", State.NoAtmosphere)
            print("FullBright:", State.FullBright)
            print("Brightness:", State.Brightness)
            print("WorldAmbient:", State.WorldAmbient)
            print("ForceTimeOfDay:", State.ForceTimeOfDay)
            print("WorldHour:", State.WorldHour)
            print("FreeCam:", State.FreeCam)
            print("CustomFOV:", State.CustomFOV)
            print("CameraFOV:", State.CameraFOV)
            print("FPSCap:", State.FPSCap)
            print("XRay:", State.XRay)
            print("PotatoMode:", State.PotatoMode)
            print("NearbyAlert:", State.NearbyAlert)
            print("StaffDetection:", State.StaffDetection)
            print("AutoRetreat:", State.AutoRetreat)
            print("================================")
        end,
    })

    print("[UI] World UI carregada com sucesso.")

    return WorldUI
end

return WorldUI