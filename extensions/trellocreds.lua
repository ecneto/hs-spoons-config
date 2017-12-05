module = {}

local config = {
  workingListId= 'xxxxxxxxxxxxxxxxxxxxxxxx',
  completeListId= 'xxxxxxxxxxxxxxxxxxxxxxxx',
  apiKey= 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  serverToken= 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
}

function module.getConfig()
  return config
end

return module