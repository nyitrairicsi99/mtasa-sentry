addEvent("mta-sentry.initClient", true)
addEventHandler("mta-sentry.initClient", root, init)

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), function ( startedRes )
    triggerServerEvent("mta-sentry.requestClientData", localPlayer)
end)