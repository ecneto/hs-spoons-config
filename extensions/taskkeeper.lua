module = {}

local trellocreds = require "extensions.trellocreds"
local prompter = require "extensions.prompter"

local tasks
local current

function init()
  if tasks==nil then
    module.update()
  end
end

function msg(txt)
  hs.alert.closeAll()
  hs.alert.show(txt)
end

function module.print()
  init()
  msg(tasks[current].name)
end

function module.skip()
  init()
  current = (current+1) % #tasks
  if current == 0 then
    current = #tasks
  end
  msg(tasks[current].name)
end

function module.update()
  -- Get all my cards.
  local c = trellocreds.getConfig()
  local authParams = "key="..c.apiKey.."&token="..c.serverToken;
  local url = "https://api.trello.com/1/list/"..c.workingListId.."/cards?fields=name&" .. authParams
  local status,result,headerResponse = hs.http.get(url)
  -- Build Task List
  local taskObjects = hs.json.decode(result)
  tasks = {}
  for i = 1,#taskObjects do 
    table.insert(tasks, taskObjects[i])
  end
  current = 1
  msg('Loaded ' .. #tasks .. ' cards.')
end

function module.new()
  cb = function(taskName)
    if taskName == nil or taskName == "" then
      return
    end
    local c = trellocreds.getConfig()
    local authParams = "key="..c.apiKey.."&token="..c.serverToken;
    local encodedName = hs.http.encodeForQuery(taskName)
    local url = "https://api.trello.com/1/cards?idList="..c.workingListId.."&name="..encodedName.."&"..authParams
    local status,result,headerResponse = hs.http.post(url)
    if status == 200 then
      msg('Added [' .. taskName ..']')
    else 
      msg('Error Code ' .. status)
    end
  end

  prompter.prompt("What else?", cb)
end

function module.complete()
  local c = trellocreds.getConfig()
  local authParams = "key="..c.apiKey.."&token="..c.serverToken;
  local cardId = tasks[current].id
  local taskName = tasks[current].name
  local url = "https://api.trello.com/1/cards/".. cardId .."/idList?value="..c.completeListId.."&" .. authParams
  print(url)
  local status,result,headerResponse = hs.http.doRequest(url, 'PUT')
  if status == 200 then
    msg('Completed [' .. taskName .. "]!!! 🏆")
  else 
    print('Error Code ' .. status)
  end
end

function module.start() 
  
end

return module