Testcase1 = LibStub("AceAddon-3.0"):NewAddon("Testcase1", "AceConsole-3.0", "AceEvent-3.0" );

Testcase1.framePool = nil

function Testcase1:OnInitialize()
	self:RegisterChatCommand("testcase", "ShowFrame")
	self:RegisterChatCommand("tc", "ShowFrame")
    self:RegisterChatCommand("tp", "ShowFrame")
    self:Print("Testcase is work")
    local FriendsContainer = MainFrame.Body.FriendsFrame.FriendsItemContainer
    self.framePool = CreateFramePool("Frame", FriendsContainer, "FriendsItemTemplate");






end

function ChangeText(object, Text)
    object.Text:SetText(Text)
    TextWidth = (object.Text:GetWidth())
    object:SetWidth(TextWidth)
end

function Testcase1:ShowFrame()
    MainFrame:Show()

    ChangeText(MainFrame.Header.FAQ, "FAQ")
    ChangeText(MainFrame.Header.MAIN, "ОСНОВНОЕ")
    ChangeText(MainFrame.Header.Community, "СООБЩЕСТВО")
    ChangeText(MainFrame.Header.SBIR, "СИСТЕМА БОЯ И РАЗВИТИЯ")
    ChangeText(MainFrame.Header.Guidelines, "РУКОВОДСТВА")


    ChangeText(MainFrame.Breadcrumbs.BreadcrumbForumThread, "Пользователи")
    ChangeText(MainFrame.Breadcrumbs.BreadcrumbsForumThreadName, "SanityIs4TheWeak")
    ChangeText(MainFrame.Body.ContextUsername, "SanityIs4TheWeak")
    ChangeText(MainFrame.Body.FriendsFrame.FriendsTag, "Друзья")
    ChangeText(MainFrame.Body.CharactersFrame.CharactersTag, "Анкеты")
    ChangeText(MainFrame.Body.EventsFrame.EventsTag, "События")
    ChangeText(MainFrame.Body.PageWriteTag, "СТЕНА ПОЛЬЗОВАТЕЛЯ")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileRegistration, "Регистрация")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileRegistrationText, "6 лет назад")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileGroups, "Группы")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileGroupsText, "Ролевики")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileCity, "Город")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileCityText, "Брилл")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileSex, "Пол")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileSexText, "Мужской")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileSkype, "Skype")
    ChangeText(MainFrame.Body.ProfileInformation.ProfileInformation.MyProfileSkypeText, "123123123")
    ChangeText(MainFrame.Body.ProfileNavigation.MyProfile, "ПРОФИЛЬ")
    ChangeText(MainFrame.Body.ProfileNavigation.MyThread, "МОЯ ЛЕНТА")
    ChangeText(MainFrame.Body.ProfileNavigation.MyFriends, "ДРУЗЬЯ")
    ChangeText(MainFrame.Body.ProfileNavigation.MyComments, "КОММЕНТАРИИ")
    ChangeText(MainFrame.Body.ProfileNavigation.MyReputation, "РЕПУТАЦИЯ")
    ChangeText(MainFrame.Body.ProfileNavigation.MyIntegrations, "ИНТЕГРАЦИИ")



    -- Скролл
    Testcase1.DataProvider = CreateDataProvider()
    Testcase1.ScrollView = CreateScrollBoxListLinearView()
    Testcase1.ScrollView:SetDataProvider(Testcase1.DataProvider)
    Testcase1.ScrollView:SetElementInitializer("UIPanelButtonTemplate", Initializer)

    Testcase1.ScrollBox = MainFrame.Body.ProfileInformation.ProfileInformation.MyScrollBox
    Testcase1.ScrollBar = MainFrame.Body.ProfileInformation.ProfileInformation.MyScrollBar
    ScrollUtil.InitScrollBoxListWithScrollBar(Testcase1.ScrollBox, Testcase1.ScrollBar, Testcase1.ScrollView)

    local myData = {
        PlayerName = "Ghost",
        PlayerClass = "Priest"
    }
    Testcase1.DataProvider:Insert(myData)


end




function Initializer(button, data)
    local playerName = data.PlayerName
    local playerClass = data.PlayerClass
    button:SetScript("OnClick", function()
        print(playerName .. ": " .. playerClass)
    end)
    button:SetText(playerName)
end


FriendStatusMixin={};

function FriendStatusMixin:FriendStatus()
    local RandValue = math.random(1, 100);
    if RandValue %2 == 0 then
        local FriendStatus = true;
        return FriendStatus
    else 
        FriendStatus = false;
        return FriendStatus
    end
end

function FriendStatusMixin:ShowOnlineTooltip()
    GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 5)
    if self:FriendStatus() == true then 
        GameTooltip:ClearLines()
        GameTooltip:AddLine("В сети")
    else
        GameTooltip:ClearLines()
        GameTooltip:AddLine("Не в сети")
    end
    GameTooltip:Show()
end 


function FriendStatusMixin:HideOnlineTooltip()
    GameTooltip:Hide()
end 



function Testcase1:CreateFriendsItem()
    local Item = self.framePool:Acquire()
    Item:Show()
    print(Item)
    return Item
  end
  
  
  
  function Testcase1:GetItemCount(object)
      local n = tonumber(object:GetText())
      if n then
          self:CreateFramesFromTemplate(n)
      else
          return nil
      end
  end
  
  function Testcase1:CreateFramesFromTemplate(n)
    local FriendsContainer = MainFrame.Body.FriendsFrame.FriendsItemContainer
    local ColumnCounter = 0
    local yOffset = 0
    local xOffset = 0

    for i = 1, n do
        local Item = self:CreateFriendsItem()
        if not Item then
          break
        end

        Item:SetPoint("TOPLEFT", FriendsContainer, "TOPLEFT", xOffset, yOffset)

        xOffset = xOffset + 40
        if i % 5 == 0 then
            xOffset = 0
            yOffset = yOffset - 40
            ColumnCounter = ColumnCounter + 1
        end
    end

    print(i)

    local currentHeight = MainFrame.Body.FriendsFrame:GetHeight()
    MainFrame.Body.FriendsFrame:SetHeight(currentHeight + 35 * ColumnCounter)
    MainFrame.Body.FriendsFrame.Border:SetHeight(currentHeight + 35 * ColumnCounter)
end