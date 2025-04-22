local Library = {}

-- Create main UI elements
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI Settings with Material You 3 Theme (AMOLED)
local UISettings = {
    -- Surface colors (AMOLED + Material You 3)
    MainColor = Color3.fromRGB(0, 0, 0), -- Pure black for AMOLED
    AccentColor = Color3.fromRGB(10, 10, 10), -- Near-black for containers
    ButtonColor = Color3.fromRGB(18, 18, 18), -- Slightly lighter black for buttons
    TextColor = Color3.fromRGB(230, 225, 229), -- Light text for contrast
    HighlightColor = Color3.fromRGB(141, 17, 19), -- Darker glowing red
    SecondaryHighlight = Color3.fromRGB(111, 14, 16), -- Even darker red for states
    SurfaceContainerHigh = Color3.fromRGB(15, 15, 15), -- Dark surface for elevated containers
    OutlineColor = Color3.fromRGB(40, 40, 40), -- Subtle dark outline
    DebugTextColor = Color3.fromRGB(141, 17, 19), -- Matching darker red
    
    -- Typography
    FontFamily = Enum.Font.GothamBold,
    ButtonSize = UDim2.new(0, 150, 0, 32),
    CornerRadius = UDim.new(0, 12),
    
    -- Elevation and States
    SurfaceElevation = 0, -- No transparency
    HoverElevation = 0, -- No transparency on hover
    PressedElevation = 0, -- No transparency when pressed
    GlowTransparency = 0.7, -- Keep glow effect visible
}

function Library:CreateWindow(title)
    -- Remove existing UI if it exists
    local existingUI = CoreGui:FindFirstChild("NovaFluxUI")
    if existingUI then
        existingUI:Destroy()
    end

    -- Main Frame
    local MainUI = Instance.new("ScreenGui")
    MainUI.Name = "NovaFluxUI"
    MainUI.Parent = CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -170)
    MainFrame.BackgroundColor3 = UISettings.MainColor
    MainFrame.BackgroundTransparency = 0
    MainFrame.Parent = MainUI
    
    -- Add subtle drop shadow (only visible when not minimized)
    local DropShadow = Instance.new("ImageLabel")
    DropShadow.Name = "DropShadow"
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 12, 1, 12)
    DropShadow.ZIndex = -1
    DropShadow.Image = "rbxassetid://6014261993"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.5
    DropShadow.Parent = MainFrame
    
    -- Add rounded corners
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UISettings.CornerRadius
    Corner.Parent = MainFrame
    
    -- Title Bar with elevated surface
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = UISettings.SurfaceContainerHigh
    TitleBar.BackgroundTransparency = 0
    TitleBar.Parent = MainFrame
    
    -- Add subtle stroke to TitleBar
    local TitleStroke = Instance.new("UIStroke")
    TitleStroke.Color = UISettings.OutlineColor
    TitleStroke.Transparency = 0.8
    TitleStroke.Thickness = 1
    TitleStroke.Parent = TitleBar
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UISettings.CornerRadius
    TitleCorner.Parent = TitleBar
    
    -- Title Text with Material You 3 typography
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "Title"
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 16, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = title
    TitleText.TextColor3 = UISettings.TextColor
    TitleText.TextSize = 18
    TitleText.Font = UISettings.FontFamily
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar
    
    -- Update Close Button with Material You 3 styling
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "×"
    CloseButton.TextColor3 = UISettings.TextColor
    CloseButton.TextSize = 20
    CloseButton.Font = UISettings.FontFamily
    CloseButton.Parent = TitleBar
    
    -- Close button hover effect
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 80, 80)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            TextColor3 = UISettings.TextColor
        }):Play()
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        MainUI:Destroy()
    end)
    
    -- Update Minimize Button with Material You 3 styling
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = UISettings.TextColor
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = UISettings.FontFamily
    MinimizeButton.Parent = TitleBar
    
    -- Minimize button hover effect
    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            TextColor3 = UISettings.HighlightColor
        }):Play()
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            TextColor3 = UISettings.TextColor
        }):Play()
    end)
    
    -- Minimize Button Functionality
    local minimized = false
    local originalSize = MainFrame.Size
    local originalNavBarVis = true
    local originalContentVis = true
    
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            -- Store current visibility states
            originalNavBarVis = NavBar.Visible
            originalContentVis = ContentFrame.Visible
            
            -- Hide elements
            NavBar.Visible = false
            ContentFrame.Visible = false
            DropShadow.Visible = false
            
            -- Animate to minimized state
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 450, 0, 30)
            }):Play()
        else
            -- Animate back to original size
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = originalSize
            }):Play()
            
            -- Wait for animation to complete before showing content
            wait(0.2)
            
            -- Restore original visibility states
            NavBar.Visible = originalNavBarVis
            ContentFrame.Visible = originalContentVis
            DropShadow.Visible = true
        end
    end)
    
    -- Navigation Bar with elevated surface
    local NavBar = Instance.new("Frame")
    NavBar.Name = "NavBar"
    NavBar.Size = UDim2.new(0, 110, 1, -30)
    NavBar.Position = UDim2.new(0, 0, 0, 30)
    NavBar.BackgroundColor3 = UISettings.SurfaceContainerHigh
    NavBar.BackgroundTransparency = UISettings.SurfaceElevation
    NavBar.Parent = MainFrame
    
    -- Add subtle stroke to NavBar
    local NavStroke = Instance.new("UIStroke")
    NavStroke.Color = UISettings.OutlineColor
    NavStroke.Transparency = 0.8
    NavStroke.Thickness = 1
    NavStroke.Parent = NavBar
    
    local NavCorner = Instance.new("UICorner")
    NavCorner.CornerRadius = UISettings.CornerRadius
    NavCorner.Parent = NavBar
    
    -- Content Frame with Material You 3 elevation
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -120, 1, -40)
    ContentFrame.Position = UDim2.new(0, 115, 0, 35)
    ContentFrame.BackgroundColor3 = UISettings.SurfaceContainerHigh
    ContentFrame.BackgroundTransparency = UISettings.SurfaceElevation
    ContentFrame.Parent = MainFrame
    
    -- Add subtle stroke to ContentFrame
    local ContentStroke = Instance.new("UIStroke")
    ContentStroke.Color = UISettings.OutlineColor
    ContentStroke.Transparency = 0.8
    ContentStroke.Thickness = 1
    ContentStroke.Parent = ContentFrame
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UISettings.CornerRadius
    ContentCorner.Parent = ContentFrame
    
    -- Coming Soon Label with Material You 3 typography
    local ComingSoonLabel = Instance.new("TextLabel")
    ComingSoonLabel.Name = "ComingSoonLabel"
    ComingSoonLabel.Size = UDim2.new(1, -32, 0, 36)
    ComingSoonLabel.Position = UDim2.new(0, 16, 0, 16)
    ComingSoonLabel.BackgroundTransparency = 1
    ComingSoonLabel.Text = "Coming Soon!"
    ComingSoonLabel.TextColor3 = UISettings.TextColor
    ComingSoonLabel.TextSize = 16
    ComingSoonLabel.Font = UISettings.FontFamily
    ComingSoonLabel.Parent = ContentFrame
    ComingSoonLabel.Visible = false
    
    -- Create Navigation Buttons
    local buttons = {"Overview", "Fruits", "Quests/Raids", "Sea-Events", "Teleport", "Misc", "Settings", "Advanced"}
    local buttonSpacing = 2
    local currentY = 5
    
    -- Function to clear content frame
    local function clearContentFrame()
        for _, child in ipairs(ContentFrame:GetChildren()) do
            if child.Name ~= "ComingSoonLabel" then
                child:Destroy()
            end
        end
        ComingSoonLabel.Visible = true
        ComingSoonLabel.TextColor3 = UISettings.DebugTextColor -- Set debug text to red
    end
    
    -- Function to create glowing text effect
    local function setGlowingText(textButton, isSelected)
        -- Remove any existing glow effect first
        local existingGlow = textButton:FindFirstChild("TextGlow")
        if existingGlow then
            existingGlow:Destroy()
        end

        if isSelected then
            -- Create new text glow effect
            local textGlow = Instance.new("TextLabel")
            textGlow.Name = "TextGlow"
            textGlow.Size = UDim2.new(1, 0, 1, 0)
            textGlow.Position = UDim2.new(0, 0, 0, 0)
            textGlow.BackgroundTransparency = 1
            textGlow.Text = textButton.Text
            textGlow.TextColor3 = UISettings.HighlightColor
            textGlow.TextSize = textButton.TextSize
            textGlow.Font = textButton.Font
            textGlow.ZIndex = textButton.ZIndex - 1
            textGlow.TextTransparency = 0
            textGlow.Parent = textButton
            
            -- Set main text color
            textButton.TextColor3 = UISettings.HighlightColor
        else
            -- Reset text color to default
            textButton.TextColor3 = UISettings.TextColor
        end
    end

    -- Function to update button states
    local function updateButtonStates(selectedButton, initialLoad)
        for _, child in ipairs(NavBar:GetChildren()) do
            if child:IsA("Frame") and child.Name:find("Container") then
                local button = child:FindFirstChild(child.Name:gsub("Container", "Button"))
                if button then
                    local isSelected = (button == selectedButton)
                    
                    -- Always set default background first
                    child.BackgroundColor3 = UISettings.ButtonColor
                    child.BackgroundTransparency = 0
                    
                    -- Remove any existing glow
                    local glow = child:FindFirstChild("Glow")
                    if glow then
                        glow:Destroy()
                    end

                    if isSelected then
                        -- Set text color and glow for selected button
                        setGlowingText(button, true)
                        
                        -- Only change background if not initial load
                        if not initialLoad then
                            child.BackgroundColor3 = UISettings.HighlightColor
                            addButtonGlow(child)
                        end
                    else
                        -- Reset unselected button
                        setGlowingText(button, false)
                    end
                end
            end
        end
    end

    for _, buttonText in ipairs(buttons) do
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Name = buttonText .. "Container"
        ButtonContainer.Size = UDim2.new(0.9, 0, 0, 26)
        ButtonContainer.Position = UDim2.new(0.05, 0, 0, currentY)
        ButtonContainer.BackgroundColor3 = UISettings.ButtonColor
        ButtonContainer.BackgroundTransparency = 0
        ButtonContainer.Parent = NavBar
        
        -- Add subtle stroke to buttons
        local ButtonStroke = Instance.new("UIStroke")
        ButtonStroke.Color = UISettings.OutlineColor
        ButtonStroke.Transparency = 0.8
        ButtonStroke.Thickness = 1
        ButtonStroke.Parent = ButtonContainer
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = ButtonContainer
        
        local Button = Instance.new("TextButton")
        Button.Name = buttonText .. "Button"
        Button.Size = UDim2.new(1, 0, 1, 0)
        Button.Position = UDim2.new(0, 0, 0, 0)
        Button.BackgroundTransparency = 1
        Button.Text = buttonText
        Button.TextColor3 = UISettings.TextColor  -- Set default text color
        Button.TextSize = 12
        Button.Font = UISettings.FontFamily
        Button.Parent = ButtonContainer
        
        Button.MouseButton1Click:Connect(function()
            updateButtonStates(Button, false)  -- false means not initial load

            if buttonText == "Advanced" then
                local DebugPanel = createAdvancedPanel()
                Library.DebugPanel = DebugPanel
            else
                clearContentFrame()
                ComingSoonLabel.Text = buttonText .. " - Coming Soon!"
            end
        end)
        
        -- Enhanced Hover Effects
        ButtonContainer.MouseEnter:Connect(function()
            if ButtonContainer.BackgroundColor3 ~= UISettings.HighlightColor then
                TweenService:Create(ButtonContainer, TweenInfo.new(0.2), {
                    BackgroundTransparency = UISettings.HoverElevation,
                    BackgroundColor3 = UISettings.SurfaceContainerHigh
                }):Play()
            end
        end)
        
        ButtonContainer.MouseLeave:Connect(function()
            if ButtonContainer.BackgroundColor3 ~= UISettings.HighlightColor then
                TweenService:Create(ButtonContainer, TweenInfo.new(0.2), {
                    BackgroundTransparency = UISettings.SurfaceElevation,
                    BackgroundColor3 = UISettings.ButtonColor
                }):Play()
            end
        end)
        
        currentY = currentY + 28 + buttonSpacing
    end
    
    -- Initialize Overview as default selected button
    wait(0.1)  -- Small delay to ensure all buttons are created
    local OverviewButton = NavBar:FindFirstChild("OverviewContainer")
    if OverviewButton then
        local button = OverviewButton:FindFirstChild("OverviewButton")
        if button then
            updateButtonStates(button, true)  -- true means initial load
            clearContentFrame()
            ComingSoonLabel.Text = "Overview - Coming Soon!"
        end
    end
    
    -- Dragging Functionality
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- Function to create the Advanced Debug Panel
    local function createAdvancedPanel()
        -- Clear existing content
        clearContentFrame()
        ComingSoonLabel.Visible = false

        -- Create Debug Log Container
        local DebugLogContainer = Instance.new("ScrollingFrame")
        DebugLogContainer.Name = "DebugLogContainer"
        DebugLogContainer.Size = UDim2.new(1, -20, 0.7, -10)
        DebugLogContainer.Position = UDim2.new(0, 10, 0, 10)
        DebugLogContainer.BackgroundColor3 = UISettings.MainColor
        DebugLogContainer.BackgroundTransparency = 0
        DebugLogContainer.BorderSizePixel = 0
        DebugLogContainer.ScrollBarThickness = 2
        DebugLogContainer.ScrollingDirection = Enum.ScrollingDirection.Y
        DebugLogContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
        DebugLogContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        DebugLogContainer.Parent = ContentFrame

        -- Add glow effect to Debug Log Container
        local DebugLogGlow = Instance.new("ImageLabel")
        DebugLogGlow.Name = "Glow"
        DebugLogGlow.BackgroundTransparency = 1
        DebugLogGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
        DebugLogGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        DebugLogGlow.Size = UDim2.new(1, 40, 1, 40)
        DebugLogGlow.ZIndex = DebugLogContainer.ZIndex - 1
        DebugLogGlow.Image = "rbxassetid://4996891970"
        DebugLogGlow.ImageColor3 = UISettings.HighlightColor
        DebugLogGlow.ImageTransparency = 0.92
        DebugLogGlow.Parent = DebugLogContainer

        -- Add corner radius to Debug Log Container
        local DebugLogCorner = Instance.new("UICorner")
        DebugLogCorner.CornerRadius = UDim.new(0, 8)
        DebugLogCorner.Parent = DebugLogContainer

        -- Add subtle stroke to Debug Log Container
        local DebugLogStroke = Instance.new("UIStroke")
        DebugLogStroke.Color = UISettings.OutlineColor
        DebugLogStroke.Transparency = 0.8
        DebugLogStroke.Thickness = 1
        DebugLogStroke.Parent = DebugLogContainer

        -- Create Execution History Container
        local ExecutionHistoryContainer = Instance.new("ScrollingFrame")
        ExecutionHistoryContainer.Name = "ExecutionHistoryContainer"
        ExecutionHistoryContainer.Size = UDim2.new(1, -20, 0.3, -10)
        ExecutionHistoryContainer.Position = UDim2.new(0, 10, 0.7, 10)
        ExecutionHistoryContainer.BackgroundColor3 = UISettings.MainColor
        ExecutionHistoryContainer.BackgroundTransparency = 0
        ExecutionHistoryContainer.BorderSizePixel = 0
        ExecutionHistoryContainer.ScrollBarThickness = 4
        ExecutionHistoryContainer.ScrollingDirection = Enum.ScrollingDirection.Y
        ExecutionHistoryContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ExecutionHistoryContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        ExecutionHistoryContainer.Parent = ContentFrame

        -- Add corner radius to Execution History Container
        local ExecutionHistoryCorner = Instance.new("UICorner")
        ExecutionHistoryCorner.CornerRadius = UDim.new(0, 8)
        ExecutionHistoryCorner.Parent = ExecutionHistoryContainer

        -- Add subtle stroke to Execution History Container
        local ExecutionHistoryStroke = Instance.new("UIStroke")
        ExecutionHistoryStroke.Color = UISettings.OutlineColor
        ExecutionHistoryStroke.Transparency = 0.8
        ExecutionHistoryStroke.Thickness = 1
        ExecutionHistoryStroke.Parent = ExecutionHistoryContainer

        -- Add glow effect to Execution History Container
        local ExecutionHistoryGlow = Instance.new("ImageLabel")
        ExecutionHistoryGlow.Name = "Glow"
        ExecutionHistoryGlow.BackgroundTransparency = 1
        ExecutionHistoryGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
        ExecutionHistoryGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        ExecutionHistoryGlow.Size = UDim2.new(1, 40, 1, 40)
        ExecutionHistoryGlow.ZIndex = ExecutionHistoryContainer.ZIndex - 1
        ExecutionHistoryGlow.Image = "rbxassetid://4996891970"
        ExecutionHistoryGlow.ImageColor3 = UISettings.HighlightColor
        ExecutionHistoryGlow.ImageTransparency = 0.92
        ExecutionHistoryGlow.Parent = ExecutionHistoryContainer

        -- Function to add debug log entry
        local function addDebugLog(message, type)
            local logEntry = Instance.new("TextLabel")
            logEntry.Size = UDim2.new(1, -16, 0, 20)
            logEntry.Position = UDim2.new(0, 8, 0, #DebugLogContainer:GetChildren() * 22)
            logEntry.BackgroundTransparency = 1
            logEntry.Text = "[" .. type .. "] " .. message
            logEntry.TextColor3 = UISettings.DebugTextColor
            logEntry.TextSize = 12
            logEntry.Font = UISettings.FontFamily
            logEntry.TextXAlignment = Enum.TextXAlignment.Left
            logEntry.TextWrapped = true
            logEntry.Parent = DebugLogContainer
        end

        -- Function to add execution history entry
        local function addExecutionHistory(action)
            local historyEntry = Instance.new("TextLabel")
            historyEntry.Size = UDim2.new(1, -16, 0, 20)
            historyEntry.Position = UDim2.new(0, 8, 0, #ExecutionHistoryContainer:GetChildren() * 22)
            historyEntry.BackgroundTransparency = 1
            historyEntry.Text = os.date("[%H:%M:%S]") .. " " .. action
            historyEntry.TextColor3 = UISettings.TextColor
            historyEntry.TextSize = 12
            historyEntry.Font = UISettings.FontFamily
            historyEntry.TextXAlignment = Enum.TextXAlignment.Left
            historyEntry.TextWrapped = true
            historyEntry.Parent = ExecutionHistoryContainer
        end

        -- Add some sample debug logs
        addDebugLog("Debug panel initialized", "INFO")
        addDebugLog("System ready", "STATUS")
        
        -- Add some sample execution history
        addExecutionHistory("Advanced debug panel opened")
        
        return {
            AddDebugLog = addDebugLog,
            AddExecutionHistory = addExecutionHistory
        }
    end

    -- Add glow effect to selected button
    local function addButtonGlow(button)
        -- Remove existing glow if any
        local existingGlow = button:FindFirstChild("Glow")
        if existingGlow then
            existingGlow:Destroy()
        end

        -- Create glow effect
        local Glow = Instance.new("ImageLabel")
        Glow.Name = "Glow"
        Glow.BackgroundTransparency = 1
        Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
        Glow.AnchorPoint = Vector2.new(0.5, 0.5)
        Glow.Size = UDim2.new(1, 20, 1, 20)
        Glow.ZIndex = button.ZIndex - 1
        Glow.Image = "rbxassetid://4996891970" -- Radial gradient
        Glow.ImageColor3 = UISettings.HighlightColor
        Glow.ImageTransparency = UISettings.GlowTransparency
        Glow.Parent = button
    end

    return MainUI
end

-- Initialize the UI
local Window = Library:CreateWindow("Nova Flux | Blox Fruits")
