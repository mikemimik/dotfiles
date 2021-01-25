-- Entrypoint
inspect = require 'inspect'

-- Gobals
mainScreen = hs.screen.mainScreen()
mainFrame = mainScreen:frame()
usbWatcher = nil
delay = nil

-- Defaults
hs.window.animationDuration = 0.00

-- COLUMNS: must be an even number
COLUMNS = 4
ROWS = 2

POSITIONS = nil

function generatePositions(columns, rows)
  print("screen:", mainFrame)
  print("width:", mainFrame.w)
  print("height:", mainFrame.h)
  local colBreak = mainFrame.w / columns
  local halfScreen = colBreak * (columns / 2)
  print("colBreak:", colBreak)
  local positions = {
    left = { },
    right = { },
  }

  -----------------------------
  -- Set LEFT position
  -----------------------------
  print("GENERATING LEFT POSITIONS")
  local leftColLimit
  if (columns > 2) then
    leftColLimit = columns / 2 - 1
  else
    leftColLimit = 0
  end
  for col = 0, leftColLimit do
    local startX = colBreak * col
    local leftRect = hs.geometry.rect(startX, 23.0, colBreak, mainFrame.h)
    positions["left"][col] = leftRect
    for row = 0, rows - 1 do
      local key = string.format("row%dleft", row)
      if (positions[key] == nil) then positions[key] = {} end

      local rect = hs.geometry.rect(
        startX,
        23.0 + ((mainFrame.h / rows) * row),
        colBreak,
        mainFrame.h / rows
      )
      positions[key][col] = rect
    end
  end
  -----------------------------
  --- Set LEFT _full_/_third_ position
  -----------------------------
  local fullLeftRect = hs.geometry.rect(0.0, 23.0, halfScreen, mainFrame.h)
  local thirdLeftRect = hs.geometry.rect(
    0.0,
    23.0,
    (halfScreen) * (2 / 3),
    mainFrame.h
  )
  positions["left"][#positions["left"] + 1] = thirdLeftRect
  positions["left"][#positions["left"] + 1] = fullLeftRect

  for row = 0, rows - 1 do
    local key = string.format("row%dleft", row)
    -- Create full section, half screen ROW
    local fullRect = hs.geometry.rect(
      0.0,
      23.0 + ((mainFrame.h / rows) * row),
      halfScreen,
      mainFrame.h / rows
    )
    -- Create third section, half screen ROW
    local thirdRect = hs.geometry.rect(
      0.0,
      23.0 + ((mainFrame.h / rows) * row),
      (halfScreen) * (2 / 3),
      mainFrame.h / rows
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
    local rightRect = hs.geometry.rect(startX, 23.0, colBreak, mainFrame.h)
    positions["right"][index] = rightRect
    for row = 0, rows - 1 do
      local key = string.format("row%dright", row)
      if (positions[key] == nil) then positions[key] = {} end

      local rect = hs.geometry.rect(
        startX,
        23.0 + ((mainFrame.h / rows) * row),
        colBreak,
        mainFrame.h / rows
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
    fullRightStart,
    23.0,
    halfScreen,
    mainFrame.h
  )
  local thirdRightRect = hs.geometry.rect(
    fullRightStart + ((halfScreen) * (1 / 3)),
    23.0,
    (halfScreen) * (2 / 3),
    mainFrame.h
  )
  positions["right"][#positions["right"] + 1] = thirdRightRect
  positions["right"][#positions["right"] + 1] = fullRightRect

  for row = 0, rows - 1 do
    local key = string.format("row%dright", row)
    -- Create full section, half screen ROW
    local fullRect = hs.geometry.rect(
      fullRightStart,
      23.0 + ((mainFrame.h / rows) * row),
      halfScreen,
      mainFrame.h / rows
    )
    -- Create third section, half screen ROW
    local thirdRect = hs.geometry.rect(
      fullRightStart + ((halfScreen) * (1 / 3)),
      23.0 + ((mainFrame.h / rows) * row),
      (halfScreen) * (2 / 3),
      mainFrame.h / rows
    )
    positions[key][#positions[key] + 1] = thirdRect
    positions[key][#positions[key] + 1] = fullRect
  end

  -----------------------------
  -- Set CENTER position
  -----------------------------
  local horizontalCenter = mainFrame.w / 2
  local verticalCenter = mainFrame.h / 2
  print("coords:", horizontalCenter, verticalCenter)
  -- positions["center"] = hs.geometry.point(verticalCenter, horizontalCenter)
  local centerPoint = hs.geometry.point(horizontalCenter, verticalCenter)
  positions["center"] = centerPoint

  -----------------------------
  -- Set FULL position
  -----------------------------
  local fullScreenRect = hs.geometry.rect(0.0, 23.0, mainFrame.w, mainFrame.h)
  positions["full"] = fullScreenRect

  -- TESTING
  -- print("positions: ", inspect(positions))
  return positions
end

function similar(key, a, b)
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
function similarWidth(a, b)
  return similar("w", a, b)
end
function similarHeight(a, b)
  return similar("h", a, b)
end
function similarCenter(a, b)
  local diff = a:distance(b)
  local isSimilar = (math.abs(diff) < 50)
  -- print('~', 'c', diff, isSimilar) -- TESTING
  return isSimilar
end

function indexOf (array, item)
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

function findWindow()
  print("finding window...")
  local win = hs.window.focusedWindow()
  print("window:", win)
  return win
end

function findCurrentFrame(win)
  print("finding current frame...")
  local frame = win:frame()
  print("curFrame:", frame)
  return frame
end

function findNextPosition(win, frame, direction)
  print("finding next position...")
  local nextFrame = frame
  local nextIndex = nil

  local list = POSITIONS[direction]
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

function shiftWindow(win, pos)
  print("shifting window...")
  print("pos:", pos)
  win:setFrame(pos)
  -- TODO: Check if window is off screen (Spotify)
end

moveLeftHandler = function()
  print("handle shift - left")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local nextFrame = findNextPosition(win, curFrame, "left")
  shiftWindow(win, nextFrame)
  print("done shift")
end

moveTopLeftHandler = function()
  print("handle shift - top left")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local nextFrame = findNextPosition(win, curFrame, "row0left")
  shiftWindow(win, nextFrame)
  print("done shift")
end

moveBottomLeftHandler = function()
  print("handle shift - bottom left")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local nextFrame = findNextPosition(win, curFrame, "row1left")
  shiftWindow(win, nextFrame)
  print("done shift")
end

moveRightHandler = function()
  print("handle shift - right")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local nextFrame = findNextPosition(win, curFrame, "right")
  shiftWindow(win, nextFrame)
  print("done shift")
end

moveTopRightHandler = function()
  print("handle shift - top right")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local nextFrame = findNextPosition(win, curFrame, "row0right")
  shiftWindow(win, nextFrame)
  print("done shift")
end

moveBottomRightHandler = function()
  print("handle shift - bottom right")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local nextFrame = findNextPosition(win, curFrame, "row1right")
  shiftWindow(win, nextFrame)
  print("done shift")
end

moveCenterHandler = function()
  print("handle shift - center")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local xAdjusted = POSITIONS["center"].x - (curFrame.w / 2)
  local yAdjusted = POSITIONS["center"].y - (curFrame.h / 2)
  local centerPosition = hs.geometry.rect(xAdjusted, yAdjusted, curFrame.w, curFrame.h)
  shiftWindow(win, centerPosition)
  print("done shift")
end

moveFullHandler = function()
  print("handle shift - full")
  local win = findWindow()
  local curFrame = findCurrentFrame(win)
  local fullFrame = POSITIONS["full"]
  shiftWindow(win, fullFrame)
  print("done shift")
end

keys = {
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


function setWideGrid(columns, rows)
  print("mainScreen:", mainScreen)
  print("mainFrame:", mainFrame)
  print("Columns:", columns)
  print("Rows:", rows)
  hs.grid.setGrid(hs.geometry.size(columns, rows), mainScreen, mainFrame)
  hs.grid.setMargins(hs.geometry.point(0.0, 0.0))
  POSITIONS = generatePositions(columns, rows)
end

function setWindowManagement()
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
end

function setScreenWatcher()
  local screenKey = "screen"
  local identifier = string.format("%sCallback", screenKey)
  hs.settings.set(screenKey, mainScreen:id())
  hs.settings.watchKey(identifier, screenKey, function ()
    hs.console.clearConsole()
    hs.reload()
  end)
  return screenKey
end

function manageConfigReload()
  local identifier = setScreenWatcher()

  delay = hs.timer.delayed.new(3, function()
    local nextScreenId = hs.screen.mainScreen():id()
    hs.settings.set(identifier, nextScreenId)
  end)

  function usbDeviceCallback(data)
    -- TESTING
    -- print('data:', inspect(data))
    delay:start()
  end

  usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
  usbWatcher:start()
end

-- Manage Screen Size
if (mainScreen:name() == "Color LCD") then
  setWideGrid(2, 2)
  setWindowManagement()
else
  setWideGrid(COLUMNS, ROWS)
  setWindowManagement()
end
-- Manage Config Reload
manageConfigReload()
