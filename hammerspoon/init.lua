local mode = '1'

local FRemap = require('foundation_remapping')
local remapper = FRemap.new()
remapper:remap('ralt', 'f18')
remapper:remap('lcmd', 'lalt')
remapper:remap('lalt', 'lcmd')
remapper:register()
hs.alert.show('Gaming keyboard mode.')

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
if (mode == '0') then
    applyDefaultKeyboardSettings()
    mode = '1'
  else
    applyGamingKeyboardSettings()
    mode = '0'
  end
end)

function applyGamingKeyboardSettings()
  local FRemap = require('foundation_remapping')
  local remapper = FRemap.new()
  remapper:remap('ralt', 'f18')
  remapper:remap('lcmd', 'lalt')
  remapper:remap('lalt', 'lcmd')
  remapper:register()
  hs.alert.show('Gaming keyboard mode.')
end

function applyDefaultKeyboardSettings()
  local FRemap = require('foundation_remapping')
  local remapper = FRemap.new()
  remapper:remap('rcmd', 'f18')
  remapper:register()
  hs.alert.show('Default keyboard mode.')
end

usbWatcher = nil

function usbDeviceCallback(data)
    if (data['productName'] == 'Gaming Keyboard') then
        if (data['eventType'] == 'added') then
            applyGamingKeyboardSettings()
        elseif (data['eventType'] == 'removed') then
            applyDefaultKeyboardSettings()
        end
    end
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
