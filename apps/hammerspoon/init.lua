-- Entrypoint
local inspect = require 'inspect'

-- Load Spoons
WindowManager = hs.loadSpoon("WindowManager")
Hyper = hs.loadSpoon("Hyper")

-- Gobals
-- mainScreen = hs.screen.mainScreen()
local usbWatcher = nil
local delay = nil

local function moveSpace(spaceNum)
  return function ()
    local spaces = hs.spaces.spacesForScreen()
    hs.spaces.gotoSpace(spaces[spaceNum])
    hs.spaces.closeMissionControl()
  end
end

local function setHotkeys()
  -- hs.hotkey.bind({ "cmd", "alt" }, "i", function ()
  --  hs.grid.toggleShow()
  --  print("gridFrame:", hs.grid.getGridFrame(mainScreen))
  -- end)

  hs.hotkey.bind({ "cmd", "shift", "," }, "/", function ()
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

-- local function manageConfigReload()
--   local identifier = setScreenWatcher()

--   delay = hs.timer.delayed.new(6, function()
--     local nextScreenId = hs.screen.primaryScreen():id()
--     hs.settings.set(identifier, nextScreenId)
--   end)

--   local function usbDeviceCallback(_)
--     -- TESTING
--     -- print('data:', inspect(data))
--     delay:start()
--   end

--   usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
--   usbWatcher:start()
-- end

-- Set Hotkeys
setHotkeys()

-- Manage Config Reload
-- manageConfigReload()

-- WindowManager Config
WindowManager:bindHotKeys({})
WindowManager:start()

-- Hyper Config
Hyper:bindHotKeys({hyperKey = {{}, "F19"}})

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
  ["WhatsApp"] = {
    bundleID = "WhatsApp",
    hyperKey = "w",
    tags = { "communication" },
  },
}

hs.fnutils.each(Config.applications, function(appConfig)
  if appConfig.hyperKey then
    Hyper:bind({}, appConfig.hyperKey, function()
      hs.application.launchOrFocusByBundleID(appConfig.bundleID)
    end)

    -- Yank window to current space
    -- Hyper:bind({ "shift" }, appConfig.hyperKey, function()
    --   -- save current space
    --   local currentSpace = hs.spaces.focusedSpace()
    --   -- launch or focus the app
    --   hs.application.launchOrFocusByBundleID(appConfig.bundleID)
    --   -- save windowId
    --   local window = hs.window.focusedWindow()
    --   -- move window to 'current space'
    --   hs.spaces.moveWindowToSpace(window, currentSpace)
    --   -- refocus the space
    --   hs.timer.delayed.new(0.3, function()
    --     hs.application.launchOrFocusByBundleID(appConfig.bundleID)
    --   end):start()
    -- end)
  end

  if appConfig.localBindings then
    hs.fnutils.each(appConfig.localBindings, function(key)
      Hyper:bindPassThrough(key, appConfig.bundleID)
    end)
  end
end)

-- Insert current date (YYYY-MM-DD)
Hyper:bind({ "alt" }, "t", function()
  local date = os.date("%Y-%m-%d")
  hs.eventtap.keyStrokes(date)
end)

-- Loaded successfully!
hs.alert.show('🔨🥄✅')
