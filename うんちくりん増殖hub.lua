local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local backpack = player:WaitForChild("Backpack")

-- 既存リセット
if playerGui:FindFirstChild("Unchikurin_Hub") then playerGui.Unchikurin_Hub:Destroy() end

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "Unchikurin_Hub"
screenGui.DisplayOrder = 999999

-- 1. アイコン (うんちくりんカラー)
local iconBtn = Instance.new("TextButton", screenGui)
iconBtn.Size = UDim2.new(0, 70, 0, 70)
iconBtn.Position = UDim2.new(0.05, 0, 0.5, -35)
iconBtn.BackgroundColor3 = Color3.fromRGB(139, 69, 19)
iconBtn.Text = "💩+🌲" -- アイコン代わりのデザイン
iconBtn.TextColor3 = Color3.new(1, 1, 1)
iconBtn.TextSize = 24
iconBtn.Draggable = true
iconBtn.Active = true
Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(1, 0)

-- 2. メインフレーム
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "うんちくりん増殖HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(0.9, 0, 0.8, 0)
scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
scroll.BackgroundTransparency = 1
scroll.Parent = mainFrame

-- アイテムリストを更新する関数
local function updateUI()
    -- リストを一度クリア
    for _, child in pairs(scroll:GetChildren()) do 
        if not child:IsA("UIGridLayout") then child:Destroy() end 
    end
    
    -- 現在のバックパックの中身を全て確認
    for _, item in pairs(backpack:GetChildren()) do
        -- Tool（アイテム）ならボタンを作る
        if item:IsA("Tool") then
            local btn = Instance.new("TextButton", scroll)
            btn.Size = UDim2.new(0, 260, 0, 40)
            btn.Position = UDim2.new(0, 0, 0, #scroll:GetChildren() * 45) -- 並べる
            btn.Text = item.Name
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Parent = scroll
            
            btn.MouseButton1Click:Connect(function()
                item:Clone().Parent = backpack
            end)
        end
    end
end

-- 開閉ロジック
iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- アイテムが変わるたびに更新
backpack.ChildAdded:Connect(updateUI)
backpack.ChildRemoved:Connect(updateUI)

-- 最初の一回目を実行
updateUI()