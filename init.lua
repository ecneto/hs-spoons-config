-- [[ General ]]

-- [cmd+alt+ctrl+R]efresh Config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)


-- [[ Task Keeper ]]

local taskkeeper = require "extensions.taskkeeper"
taskkeeper.start()

-- [cmd+alt+ctrl+W]hat am I doing?
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  taskkeeper.print()
end)

-- [cmd+alt+ctrl+S]kip to the next one.
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "S", function()
  taskkeeper.skip()
end)

-- [cmd+alt+ctrl+E]verything I'm doing.
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "E", function()
  taskkeeper.update()
end)

-- [[ Finish ]]

function onComplete()
  hs.alert.closeAll()
  hs.alert.show("Config loaded")
end

onComplete()