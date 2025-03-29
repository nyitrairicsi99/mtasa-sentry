function setGlobalVariables(config)
    sentryKey = config['key']
    host = config['host']
    projectId = config['project']
    url = "https://"..sentryKey.."@"..host.."/api/"..projectId.."/store/"
    msBetweenReports = tonumber(config['msBetweenReports']) or 3600000
    loggedLevels = {}

    if config['logErrors'] == '1' then
        loggedLevels[1] = 'error'
    end

    if config['logWarnings'] == '1' then
        loggedLevels[2] = 'warning'
    end
end