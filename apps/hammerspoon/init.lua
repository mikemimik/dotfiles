-- Entrypoint
local inspect = require 'inspect'

-- Gobals
-- mainScreen = hs.screen.mainScreen()
local usbWatcher = nil
local delay = nil

-- Defaults
hs.window.animationDuration = 0.00

-- COLUMNS: must be an even number
local COLUMNS = 4
local ROWS = 2

local MENU_HEIGHT = 25.0

local POSITIONS = {}

local function generatePositions(columns, rows, frame)
  print("screen:", frame)
  print("width:", frame.w)
  print("height:", frame.h)
  local colBreak = frame.w / columns
  local halfScreen = frame.w / 2
  print("colBreak:", colBreak)
  local positions = {
    left = { },
    right = { },
  }

  -----------------------------
  -- Set LEFT position
  -----------------------------
  print("GENERATING LEFT POSITIONS")
  local leftColLimit = (columns / 2) - 1
  for col = 0, leftColLimit do
    local startX = colBreak * col
    local leftRect = hs.geometry.rect(startX, MENU_HEIGHT, colBreak, frame.h)
    positions["left"][col] = leftRect
    for row = 0, rows - 1 do
      local key = string.format("row%dleft", row)
      if (positions[key] == nil) then positions[key] = {} end

      local rect = hs.geometry.rect(
        startX,
        MENU_HEIGHT + ((frame.h / rows) * row),
        colBreak,
        frame.h / rows
      )
      positions[key][col] = rect
    end
  end
  -----------------------------
  --- Set LEFT _full_/_third_ position
  -----------------------------
  local fullLeftRect = hs.geometry.rect(0.0, MENU_HEIGHT, halfScreen, frame.h)
  local thirdLeftRect = hs.geometry.rect(
    0.0,
    MENU_HEIGHT,
    (halfScreen) * (2 / 3),
    frame.h
  )
  positions["left"][#positions["left"] + 1] = thirdLeftRect
  positions["left"][#positions["left"] + 1] = fullLeftRect
  -- positions["left"][leftColLimit + 1] = thirdLeftRect
  -- positions["left"][leftColLimit + 2] = fullLeftRect

  for row = 0, rows - 1 do
    local key = string.format("row%dleft", row)
    -- Create full section, half screen ROW
    local fullRect = hs.geometry.rect(
      0.0,
      MENU_HEIGHT + ((frame.h / rows) * row),
      halfScreen,
      frame.h / rows
    )
    -- Create third section, half screen ROW
    local thirdRect = hs.geometry.rect(
      0.0,
      MENU_HEIGHT + ((frame.h / rows) * row),
      (halfScreen) * (2 / 3),
      frame.h / rows
    )
    positions[key][#positions[key] + 1] = thirdRect
    positions[key][#positions[key] + 1] = fullRect
  end

  -----------------------------
  -- Set RIGHT position
  -----------------------------
  print("GENERATING RIGHT POSITIONS")
  local rightColLimit = columns / 2

  -- col = 2, col = 3
  -- idx = 0, idx = 1
  -- dif = 2, dif = 2
  for col = (columns - 1), rightColLimit, -1 do
    -- if COLUMNS was 6
    -- col = 5, col = 4, col = 3
    -- idx = 0, idx = 1, idx = 2
    -- dif = 5, dif = 3, dif = 1
    -- C'  = 5, C'  = 5, C'  = 5
    -- C'c = 0, C'c = 1, C'c = 2
    local index = (columns - 1) - col
    local startX = colBreak * col
    local rightRect = hs.geometry.rect(startX, MENU_HEIGHT, colBreak, frame.h)
    positions["right"][index] = rightRect
    for row = 0, rows - 1 do
      local key = string.format("row%dright", row)
      if (positions[key] == nil) then positions[key] = {} end

      local rect = hs.geometry.rect(
        startX,
        MENU_HEIGHT + ((frame.h / rows) * row),
        colBreak,
        frame.h / rows
      )
      positions[key][index] = rect
    end
  end
  -----------------------------
  --- Set RIGHT _full_/_third_ position
  -----------------------------
  local fullRightStart = nil
  if (columns > 2) then
    fullRightStart = halfScreen
  else
    fullRightStart = 0
  end
  local fullRightRect = hs.geometry.rect(
    halfScreen,
    MENU_HEIGHT,
    halfScreen,
    frame.h
  )
  local thirdRightRect = hs.geometry.rect(
    fullRightStart + ((halfScreen) * (1 / 3)),
    MENU_HEIGHT,
    (halfScreen) * (2 / 3),
    frame.h
  )
  positions["right"][#positions["right"] + 1] = thirdRightRect
  positions["right"][#positions["right"] + 1] = fullRightRect

  for row = 0, rows - 1 do
    local key = string.format("row%dright", row)
    -- Create full section, half screen ROW
    local fullRect = hs.geometry.rect(
      fullRightStart,
      MENU_HEIGHT + ((frame.h / rows) * row),
      halfScreen,
      frame.h / rows
    )
    -- Create third section, half screen ROW
    local thirdRect = hs.geometry.rect(
      fullRightStart + ((halfScreen) * (1 / 3)),
      MENU_HEIGHT + ((frame.h / rows) * row),
      (halfScreen) * (2 / 3),
      frame.h / rows
    )
    positions[key][#positions[key] + 1] = thirdRect
    positions[key][#positions[key] + 1] = fullRect
  end

  -----------------------------
  -- Set CENTER position
  -----------------------------
  local horizontalCenter = frame.w / 2
  local verticalCenter = frame.h / 2
  print("coords:", horizontalCenter, verticalCenter)
  -- positions["center"] = hs.geometry.point(verticalCenter, horizontalCenter)
  local centerPoint = hs.geometry.point(horizontalCenter, verticalCenter)
  positions["center"] = centerPoint

  -----------------------------
  -- Set FULL position
  -----------------------------
  local fullScreenRect = hs.geometry.rect(0.0, MENU_HEIGHT, frame.w, frame.h)
  positions["full"] = fullScreenRect

  -- TESTING
  -- print("positions: ", inspect(positions))
  return positions
end

local function similar(key, a, b)
  local diff = nil
  if (a[key] > b[key]) then
    diff = a[key] - b[key]
  else
    diff = b[key] - a[key]
  end
  local isSimilar = (diff <= 90)
  -- print('~', key, diff, isSimilar) -- TESTING
  return isSimilar
end
local function similarWidth(a, b)
  return similar("w", a, b)
end
local function similarHeight(a, b)
  return similar("h", a, b)
end
local function similarCenter(a, b)
  local diff = a:distance(b)
  local isSimilar = (math.abs(diff) < 50)
  -- print('~', 'c', diff, isSimilar) -- TESTING
  return isSimilar
end

local function indexOf (array, item)
  print("array:", array)
  print("length:", #array)
  print("item:", item)
  -- print('item.center:', item.center) -- TESTING
  local result = -1
  for index = 0, #array do
    -- print('--- COMPARING ELEMENTS ---') -- TESTING
    -- print("i:", index, "ele:", array[index]) -- TESTING
    -- print('ele.center:', array[index].center) -- TESTING
    local isEqual = array[index]:equals(item)
    local isSimilarWidth = similarWidth(array[index], item)
    local isSimilarHeight = similarHeight(array[index], item)
    local isSimilarCenter = similarCenter(array[index], item)
    local isClose = (
      isSimilarWidth and
      isSimilarHeight and
      isSimilarCenter
    )
    -- print("isEqual:", isEqual) -- TESTING
    -- print("isSimilarWidth:", isSimilarWidth) -- TESTING
    -- print("isSimilarHeight:", isSimilarHeight) -- TESTING
    -- print("isSimilarCenter:", isSimilarCenter) -- TESTING
    -- print("isClose:", isClose) -- TESTING
    if (isEqual or isClose) then
      result = index
      break
    end
  end
  return result
end

local function findWindow()
  print("finding window...")
  local win = hs.window.focusedWindow()
  print("window:", win)
  return win
end

local function findCurrentFrame(win)
  print("finding current frame...")
  local frame = win:frame()
  print("curFrame:", frame)
  return frame
end

local function findNextPosition(win, frame, direction)
  print("finding next position...")
  local nextFrame = frame
  local nextIndex = nil

  local list = POSITIONS[win:screen():name()][direction]
  local posIndex = indexOf(list, frame)
  print("posIndex:", posIndex)
  print("list.length:", #list)
  if (posIndex == -1 or posIndex == #list) then
    -- NOTE: not in a set position, push to first
    -- NOTE: end of the list, push to first
    nextIndex = 0
  else
    nextIndex = posIndex + 1
  end
  nextFrame = list[nextIndex]
  print("nextFrame:", nextFrame)
  print("nextIndex:", nextIndex)
  return nextFrame
end

local function shiftWindow(win, pos)
  print("shifting window...")
  print("pos:", pos)
  win:setFrame(pos)
  -- TODO: Check if window is off screen (Spotify)
end

local function moveHandler(loc, prettyName)
  local output = loc
  if (prettyName ~= nil) then
    output = prettyName
  end
  print("handle shift - %s", output)
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local nextFrame = findNextPosition(win, curFrame, loc)
  shiftWindow(win, nextFrame)
  print("done shift")
end

local moveLeftHandler = function()
  moveHandler("left")
end

local moveTopLeftHandler = function()
  moveHandler("row0left", "top left")
end

local moveBottomLeftHandler = function()
  moveHandler("row1left", "bottom left")
end

local moveRightHandler = function()
  moveHandler("right")
end

local moveTopRightHandler = function()
  moveHandler("row0right", "top right")
end

local moveBottomRightHandler = function()
  moveHandler("row1right", "bottom right")
end

local moveCenterHandler = function()
  print("handle shift - center")
  local win = findWindow()
  local screenName = win:screen():name()
  local curFrame = findCurrentFrame(win)
  local xAdjusted = POSITIONS[screenName]["center"].x - (curFrame.w / 2)
  local yAdjusted = POSITIONS[screenName]["center"].y - (curFrame.h / 2)
  local centerPosition = hs.geometry.rect(xAdjusted, yAdjusted, curFrame.w, curFrame.h)
  shiftWindow(win, centerPosition)
  print("done shift")
end

local moveFullHandler = function()
  print("handle shift - full")
  local win = findWindow()
  local screenName = win:screen():name()
  -- local curFrame = findCurrentFrame(win)
  local fullFrame = POSITIONS[screenName]["full"]
  shiftWindow(win, fullFrame)
  print("done shift")
end

local keys = {
  moveLeft = {
    modifier = { "cmd", "alt" },
    key = "left",
    func = moveLeftHandler
  },
  moveTopLeft = {
    modifier = { "cmd", "ctrl" },
    key = "left",
    func = moveTopLeftHandler
  },
  moveBottomLeft = {
    modifier = { "cmd", "ctrl", "shift" },
    key = "left",
    func = moveBottomLeftHandler
  },
  moveRight = {
    modifier = { "cmd" , "alt" },
    key = "right",
    func = moveRightHandler
  },
  moveTopRight = {
    modifier = { "cmd", "ctrl" },
    key = "right",
    func = moveTopRightHandler
  },
  moveBottomRight = {
    modifier = { "cmd", "ctrl", "shift" },
    key = "right",
    func = moveBottomRightHandler
  },
  moveCenter = {
    modifier = { "cmd", "alt" },
    key = "c",
    func = moveCenterHandler
  },
  moveFull = {
    modifier = { "cmd", "alt" },
    key = "f",
    func = moveFullHandler
  }
}

local function moveSpace(spaceNum)
  return function ()
    local spaces = hs.spaces.spacesForScreen()
    hs.spaces.gotoSpace(spaces[spaceNum])
    hs.spaces.closeMissionControl()
  end
end

local function setWideGrid(columns, rows, screen)
  local frame = screen:frame();
  print("screen:", screen)
  print("frame:", frame)
  print("Columns:", columns)
  print("Rows:", rows)
  hs.grid.setGrid(hs.geometry.size(columns, rows), screen, frame)
  hs.grid.setMargins(hs.geometry.point(0.0, 0.0))
  return generatePositions(columns, rows, frame)
end

local function setWindowManagement()
  hs.hotkey.bind(keys.moveLeft.modifier, keys.moveLeft.key, keys.moveLeft.func)
  hs.hotkey.bind(keys.moveTopLeft.modifier, keys.moveTopLeft.key, keys.moveTopLeft.func)
  hs.hotkey.bind(keys.moveBottomLeft.modifier, keys.moveBottomLeft.key, keys.moveBottomLeft.func)
  hs.hotkey.bind(keys.moveRight.modifier, keys.moveRight.key, keys.moveRight.func)
  hs.hotkey.bind(keys.moveTopRight.modifier, keys.moveTopRight.key, keys.moveTopRight.func)
  hs.hotkey.bind(keys.moveBottomRight.modifier, keys.moveBottomRight.key, keys.moveBottomRight.func)
  hs.hotkey.bind(keys.moveCenter.modifier, keys.moveCenter.key, keys.moveCenter.func)
  hs.hotkey.bind(keys.moveFull.modifier, keys.moveFull.key, keys.moveFull.func)
  -- hs.hotkey.bind({ "cmd", "alt" }, "i", function ()
  --  hs.grid.toggleShow()
  --  print("gridFrame:", hs.grid.getGridFrame(mainScreen))
  -- end)
  hs.hotkey.bind({ "cmd", "alt" }, "k", function ()
    hs.console.clearConsole()
  end)
  hs.hotkey.bind({ "cmd", "shift", "," }, ".", function ()
    hs.reload()
  end)
  hs.hotkey.bind({ "alt" }, "1", moveSpace(1))
  hs.hotkey.bind({ "alt" }, "2", moveSpace(2))
  hs.hotkey.bind({ "alt" }, "3", moveSpace(3))
  hs.hotkey.bind({ "alt" }, "4", moveSpace(4))
end

local function setScreenWatcher()
  local screenKey = "screen"
  local identifier = string.format("%sCallback", screenKey)
  local primaryScreen = hs.screen.primaryScreen()
  hs.settings.set(screenKey, primaryScreen:id())
  hs.settings.watchKey(identifier, screenKey, function ()
    hs.console.clearConsole()
    hs.reload()
  end)
  return screenKey
end

local function manageConfigReload()
  local identifier = setScreenWatcher()

  delay = hs.timer.delayed.new(6, function()
    local nextScreenId = hs.screen.primaryScreen():id()
    hs.settings.set(identifier, nextScreenId)
  end)

  local function usbDeviceCallback(_)
    -- TESTING
    -- print('data:', inspect(data))
    delay:start()
  end

  usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
  usbWatcher:start()
end

local function manageWindowManagement()
  local allScreens = hs.screen.allScreens()

  for index=1, #allScreens do
    -- Manage Screen Size
    local screen = allScreens[index]
    local screenName = screen:name();

    print("screen:", screen)
    print("screenName:", screenName)

    if (POSITIONS[screenName] == nil) then POSITIONS[screenName] = {} end

    if (screenName == "Built-in Retina Display") then
      POSITIONS[screenName] = setWideGrid(2, 2, screen)
    else
      POSITIONS[screenName] = setWideGrid(COLUMNS, ROWS, screen)
    end
  end

  print("POSITIONS:", inspect(POSITIONS))
  setWindowManagement()
end

-- Manage Windows Manager
manageWindowManagement()

-- Manage Config Reload
manageConfigReload()

hs.loadSpoon("Hyper")
Config = {}
Config.applications = {
  ["com.googlecode.iterm2"] = {
    bundleID = "org.alacritty",
    hyperKey = "k",
    tags = { "coding" },
    layouts = {
      { nil, 1, hs.layout.maximized },
    },
  },
  ["com.google.Chrome"] = {
    bundleID = "com.google.Chrome",
    hyperKey = "j",
    tags = { "browsers" },
    layouts = {
      { nil, 1, hs.layout.maximized },
      { "Confluence", 1, hs.layout.maximized },
    },
  },
  ["com.tinyspeck.slackmacgap"] = {
    bundleID = "com.tinyspeck.slackmacgap",
    hyperKey = "h",
    tags = { "distraction", "communication", "chat" },
    layouts = {
      { nil, 1, hs.layout.maximized },
      { nil, 2, hs.layout.maximized },
    },
  },
  ["net.shinyfrog.bear"] = {
    bundleID = "net.shinyfrog.bear",
    hyperKey = "l",
    tags = { "planning" },
    layouts = {},
  },
  ["us.zoom.xos"] = {
    bundleID = "us.zoom.xos",
    hyperKey = "y",
    tags = { "communication", "meetings" },
    layouts = {},
  },
  ["com.spotify.client"] = {
    bundleID = "com.spotify.client",
    hyperKey = "p",
    tags = {},
    layouts = {},
  },
  ["com.reincubate.macos.cam"] = {
    bundleID = "com.reincubate.macos.cam",
    hyperKey = "b",
    tags = { "communication", "meetings" },
  },
  ["com.apple.MobileSMS"] = {
    bundleID = "com.apple.MobileSMS",
    hyperKey = "m",
    tags = { "communication" },
  },
  ["com.culturedcode.ThingsMac"] = {
    bundleID = "com.culturedcode.ThingsMac",
    hyperKey = "t",
    tags = { "planning" },
  },
  ["com.apple.Safari"] = {
    bundleID = "com.apple.Safari",
    hyperKey = "s",
    tags = { "browsers" },
  },
  ["com.apple.iCal"] = {
    bundleID = "com.apple.iCal",
    hyperKey = "c",
    tags = { "planning", "meetings" },
  },
}
Hyper = spoon.Hyper

Hyper:bindHotKeys({hyperKey = {{}, "F19"}})

hs.fnutils.each(Config.applications, function(appConfig)
  if appConfig.hyperKey then
    Hyper:bind({}, appConfig.hyperKey, function()
      hs.application.launchOrFocusByBundleID(appConfig.bundleID)
    end)

    Hyper:bind({ "shift" }, appConfig.hyperKey, function()
      -- save current space
      local currentSpace = hs.spaces.focusedSpace()
      -- launch or focus the app
      hs.application.launchOrFocusByBundleID(appConfig.bundleID)
      -- save windowId
      local window = hs.window.focusedWindow()
      -- move window to 'current space'
      hs.spaces.moveWindowToSpace(window, currentSpace)
      -- refocus the space
      hs.timer.delayed.new(0.3, function()
        hs.application.launchOrFocusByBundleID(appConfig.bundleID)
      end):start()
    end)
  end
  if appConfig.localBindings then
    hs.fnutils.each(appConfig.localBindings, function(key)
      Hyper:bindPassThrough(key, appConfig.bundleID)
    end)
  end
end)
