hs.window.animationDuration = 0.3

hyper = { 'alt', 'ctrl', 'cmd' }
shift_hyper = { 'shift', 'ctrl', 'cmd', 'alt'}

-- ⚠ Plugin MiroWindowsManager requires to be installed
-- See: https://github.com/miromannino/miro-windows-manager
hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})

-- center focused x and y
hs.hotkey.bind(hyper, 'c', function()
local win = hs.window.focusedWindow()
local f = win:frame()
local max = win:screen():frame()

local x = f

x.x = ((max.w - f.w) / 2) + max.x
x.y = ((max.h - f.h) / 2) + max.y
win:setFrame(x)
end)

-- center focused y
hs.hotkey.bind(hyper, 'x', function()
local win = hs.window.focusedWindow()
local f = win:frame()
local max = win:screen():frame()

local x = f

x.y = ((max.h - f.h) / 2) + max.y
win:setFrame(x)
end)

-- center focused x
hs.hotkey.bind(hyper, 'v', function()
local win = hs.window.focusedWindow()
local f = win:frame()
local max = win:screen():frame()

local x = f

x.x = ((max.w - f.w) / 2) + max.x
win:setFrame(x)
end)

-- maximize vertically
hs.hotkey.bind(hyper, '[', function()
local win = hs.window.focusedWindow()
local f = win:frame()
local max = win:screen():frame()

local x = f

x.y = max.y
x.h = max.h
win:setFrame(x)
end)

-- maximize horizontally
hs.hotkey.bind(hyper, ']', function()
local win = hs.window.focusedWindow()
local f = win:frame()
local max = win:screen():frame()

local x = f

x.x = max.x
x.w = max.w
win:setFrame(x)
end)

-- move focused window to other screen
hs.hotkey.bind(shift_hyper, 'right', function() hs.window.focusedWindow():moveOneScreenEast(true, true) end)
hs.hotkey.bind(shift_hyper, 'left', function() hs.window.focusedWindow():moveOneScreenWest(true, true) end)

hs.hotkey.bind(shift_hyper, 'i', function() hs.alert.show(hs.window.focusedWindow()) end)

function bindHyperFocus(shortcutKey, findApplication)
	hs.hotkey.bind(hyper, shortcutKey, function()
		hs.application.find(findApplication):activate()
		hs.application.launchOrFocus(findApplication)
	end)
end

bindHyperFocus('b', 'Bra')
bindHyperFocus('v', 'code')
bindHyperFocus('d', 'Discord')
bindHyperFocus('g', 'chrome')
-- bindHyperFocus('t', 'iTerm Rosetta')
bindHyperFocus('p', 'Postman')
-- -- bindHyperFocus('s', 'sublime text')
-- bindHyperFocus('p', 'Polymail')
-- bindHyperFocus('d', 'Dash')
-- bindHyperFocus('n', 'Notion')

-- -- in case you need to use hyper keys for media controls

-- function bindSystemKey(shortcutKey, systemKeyName)
-- 	hs.hotkey.bind(hyperKeys, shortcutKey, function()
-- 		hs.eventtap.event.newSystemKeyEvent(systemKeyName, true):post()
-- 		hs.eventtap.event.newSystemKeyEvent(systemKeyName, false):post()
-- 	end)
-- end

-- bindSystemKey('f7', 'PREVIOUS')
-- bindSystemKey('f8', 'PLAY')
-- bindSystemKey('f9', 'NEXT')
-- bindSystemKey('f10', 'MUTE')
-- bindSystemKey('f11', 'SOUND_DOWN')
-- bindSystemKey('f12', 'SOUND_UP')
