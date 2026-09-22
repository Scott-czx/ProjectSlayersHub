local WorldUI = {}

function WorldUI.Init(Tab, State)

    print("[UI] World inicializado.")

    -- =========================
    -- CAMERA
    -- =========================

    Tab:CreateParagraph({
        name = "Camera",
        content = "Configurações da câmera e visualização do mundo."
    })

    -- Spectate Player
    local SpectatePlayer = Tab:CreateDropdown({
        name = "Spectate Player",
        options = {
            "Nenhum jogador encontrado"
        },

        currentOption = {
            "Nenhum jogador encontrado"
        },

        callback = function(option)
            State.SpectatePlayer = option

            print(
                "[World] Spectate Player:",
                option
            )
        end,
    })

    Tab:CreateButton({
        name = "Spectate",
        callback = function()
            State.SpectateRequested = true

            print("[World] Spectate solicitado.")
        end,
    })

    Tab:CreateButton({
        name = "Stop",
        callback = function()
            State.StopSpectateRequested = true

            print("[World] Stop Spectate solicitado.")
        end,
    })

    -- =========================
    -- WORLD VISUAL
    -- =========================

    Tab:CreateParagraph({
        name = "World Visual",
        content = "Configurações de iluminação e atmosfera."
    })

    Tab:CreateToggle({
        name = "No Fog",
        currentValue = false,

        callback = function(value)
            State.NoFog = value

            print(
                "[World] No Fog:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "No Atmosphere",
        currentValue = false,

        callback = function(value)
            State.NoAtmosphere = value

            print(
                "[World] No Atmosphere:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "FullBright",
        currentValue = false,

        callback = function(value)
            State.FullBright = value

            print(
                "[World] FullBright:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Brightness",
        range = {0, 10},
        increment = 0.1,
        currentValue = 2,
        suffix = "",

        callback = function(value)
            State.Brightness = value
        end,
    })

    Tab:CreateToggle({
        name = "World Ambient",
        currentValue = false,

        callback = function(value)
            State.WorldAmbient = value

            print(
                "[World] World Ambient:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateColorPicker({
        name = "Ambient Color",
        color = Color3.fromRGB(255, 255, 255),

        callback = function(value)
            State.AmbientColor = value

            print("[World] Ambient Color alterada.")
        end,
    })

    -- =========================
    -- TIME
    -- =========================

    Tab:CreateParagraph({
        name = "Time",
        content = "Configurações do horário do mundo."
    })

    Tab:CreateToggle({
        name = "Force Time of Day",
        currentValue = false,

        callback = function(value)
            State.ForceTimeOfDay = value

            print(
                "[World] Force Time of Day:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Hour",
        range = {0, 24},
        increment = 1,
        currentValue = 12,
        suffix = ":00",

        callback = function(value)
            State.WorldHour = value
        end,
    })

    -- =========================
    -- FREE CAM
    -- =========================

    Tab:CreateParagraph({
        name = "Free Cam",
        content = "Configurações da câmera livre."
    })

    Tab:CreateToggle({
        name = "Free Cam",
        currentValue = false,

        callback = function(value)
            State.FreeCam = value

            print(
                "[World] Free Cam:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Look Sensitivity",
        range = {1, 100},
        increment = 1,
        currentValue = 50,
        suffix = "%",

        callback = function(value)
            State.LookSensitivity = value
        end,
    })

    Tab:CreateSlider({
        name = "Move Speed",
        range = {1, 200},
        increment = 1,
        currentValue = 50,

        callback = function(value)
            State.FreeCamMoveSpeed = value
        end,
    })

    -- =========================
    -- CAMERA SETTINGS
    -- =========================

    Tab:CreateParagraph({
        name = "Camera Settings",
        content = "Configurações adicionais da câmera."
    })

    Tab:CreateToggle({
        name = "Force 3rd Person",
        currentValue = false,

        callback = function(value)
            State.ForceThirdPerson = value

            print(
                "[World] Force 3rd Person:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Custom FOV",
        currentValue = false,

        callback = function(value)
            State.CustomFOV = value

            print(
                "[World] Custom FOV:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Camera FOV",
        range = {30, 120},
        increment = 1,
        currentValue = 70,
        suffix = "°",

        callback = function(value)
            State.CameraFOV = value
        end,
    })

    Tab:CreateToggle({
        name = "Infinite Zoom",
        currentValue = false,

        callback = function(value)
            State.InfiniteZoom = value

            print(
                "[World] Infinite Zoom:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "X-Ray",
        currentValue = false,

        callback = function(value)
            State.XRay = value

            print(
                "[World] X-Ray:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- PERFORMANCE
    -- =========================

    Tab:CreateParagraph({
        name = "Performance",
        content = "Configurações para reduzir o uso de recursos."
    })

    Tab:CreateSlider({
        name = "FPS Cap",
        range = {30, 240},
        increment = 5,
        currentValue = 60,
        suffix = " FPS",

        callback = function(value)
            State.FPSCap = value

            print(
                "[World] FPS Cap:",
                value
            )
        end,
    })

    Tab:CreateToggle({
        name = "No 3D Render",
        currentValue = false,

        callback = function(value)
            State.No3DRender = value

            print(
                "[World] No 3D Render:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Potato Mode",
        currentValue = false,

        callback = function(value)
            State.PotatoMode = value

            print(
                "[World] Potato Mode:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Hide Map",
        currentValue = false,

        callback = function(value)
            State.HideMap = value

            print(
                "[World] Hide Map:",
                value and "ON" or "OFF"
            )
        end,
    })

    -- =========================
    -- SAFETY
    -- =========================

    Tab:CreateParagraph({
        name = "Safety",
        content = "Configurações de alerta e retirada."
    })

    Tab:CreateToggle({
        name = "Nearby Alert",
        currentValue = false,

        callback = function(value)
            State.NearbyAlert = value

            print(
                "[World] Nearby Alert:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Alert Range",
        range = {10, 500},
        increment = 10,
        currentValue = 100,
        suffix = " studs",

        callback = function(value)
            State.AlertRange = value
        end,
    })

    Tab:CreateToggle({
        name = "Kick Nearby",
        currentValue = false,

        callback = function(value)
            State.KickNearby = value

            print(
                "[World] Kick Nearby:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Kick Range",
        range = {10, 500},
        increment = 10,
        currentValue = 100,
        suffix = " studs",

        callback = function(value)
            State.KickRange = value
        end,
    })

    Tab:CreateToggle({
        name = "Staff Detection",
        currentValue = false,

        callback = function(value)
            State.StaffDetection = value

            print(
                "[World] Staff Detection:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateToggle({
        name = "Kick On Staff Join",
        currentValue = false,

        callback = function(value)
            State.KickOnStaffJoin = value

            print(
                "[World] Kick On Staff Join:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateButton({
        name = "Set Retreat Position",
        callback = function()
            State.SetRetreatPositionRequested = true

            print(
                "[World] Set Retreat Position solicitado."
            )
        end,
    })

    Tab:CreateButton({
        name = "Clear Retreat Position",
        callback = function()
            State.ClearRetreatPositionRequested = true

            print(
                "[World] Clear Retreat Position solicitado."
            )
        end,
    })

    Tab:CreateToggle({
        name = "Auto Retreat",
        currentValue = false,

        callback = function(value)
            State.AutoRetreat = value

            print(
                "[World] Auto Retreat:",
                value and "ON" or "OFF"
            )
        end,
    })

    Tab:CreateSlider({
        name = "Retreat At HP %",
        range = {1, 100},
        increment = 1,
        currentValue = 25,
        suffix = "%",

        callback = function(value)
            State.RetreatHP = value
        end,
    })

end

return WorldUI