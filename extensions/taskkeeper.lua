module = {}

local trellocreds = require "extensions.trellocreds"

local tasks
local current

function module.print()
  hs.alert.closeAll()
  hs.alert.show(tasks[current])
end

function module.skip()
  current = (current+1) % #tasks
  if current == 0 then
    current = #tasks
  end
end

function module.update()
  -- Get all my cards.
  local c = trellocreds.getConfig()
  local url = "https://api.trello.com/1/list/"..c.listId.."/cards?fields=name&key="..c.apiKey.."&token="..c.serverToken
  local status,result,headerResponse = hs.http.get(url)
  -- Build Task List
  local taskObjects = hs.json.decode(result)
  tasks = {}
  hs.alert('loading in a ' .. result)
  for i = 1,#taskObjects do 
    hs.alert("Insert a " .. taskObjects[i].name)
    table.insert(tasks, taskObjects[i].name)
  end
  current = 1
end

function module.start() 
  current = 1
end

return module