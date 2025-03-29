local isClientSide = localPlayer
local initialized = false

function sendErrorToSentry(message, path, levelStr)
    local data = {
        ['event_id'] = uuid():gsub('-',''),
        ['tags'] = {
            ['side_type'] = localPlayer and 'client' or 'server'
        },
        ['level'] = levelStr,
        ['environment'] = 'production',
        ['timestamp'] = getRealTime().timestamp,
        ['message'] = path,
        ['exception'] = {
            ['values'] = {
                {
                    ['type'] = message,
                    ['value'] = path,
                    ['module'] = '__builtins__'
                },
            }
        },
    }
    
    local json = toJSON(data,true)
    json = json:sub(2,#json-1)
    
    local options = {
        ['queueName'] = randomString(64),
        ['connectTimeout'] = 1000,
        ['method'] = 'POST',
        ['headers'] = {
            ['Content-Length'] = tostring(#json),
            ['Content-Type'] = 'application/json',
        },
        ['postData'] = json,
    }
    
    fetchRemote(url,options,function()end)
end


function init(config)
    if initialized then 
        return
    end

    setGlobalVariables(config)

    if isClientSide then
        requestBrowserDomains ( { url }, true )
    end

    local sentMessages = {}
    
    addEventHandler(isClientSide and "onClientDebugMessage" or "onDebugMessage", getRootElement(), function(message, level, file, line)
        if not loggedLevels[level] then
            return
        end
        
        local messageKey = message.." "..tostring(file)..":"..tostring(line)

        if sentMessages[messageKey] then
            return
        end
        
        sentMessages[messageKey] = true

        sendErrorToSentry(message, tostring(file)..":"..tostring(line), loggedLevels[level])
    end)
    
    setTimer(function()
        sentMessages = {}
    end,msBetweenReports,0)

    initialized = true
end