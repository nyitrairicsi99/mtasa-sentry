local resName = getResourceName(resource)   
local serverInitialized = false
local config = {
    ['key'] = get(resName..'.key') or '',
    ['host'] = get(resName..'.host') or '',
    ['project'] = get(resName..'.project') or '',
    ['logClient'] = get(resName..'.logClient') or '0',
    ['logErrors'] = get(resName..'.logErrors') or '0',
    ['logWarnings'] = get(resName..'.logWarnings') or '0',
    ['msBetweenReports'] = get(resName..'.msBetweenReports') or '3600000',
}

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    init(config)
end)

addEvent("mta-sentry.requestClientData", true)
addEventHandler("mta-sentry.requestClientData", root, function()
    if config['logClient'] ~= '1' then
        return
    end

    triggerClientEvent(client, 'mta-sentry.initClient', client, config)
end)