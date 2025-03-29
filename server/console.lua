addCommandHandler("testsentry", function(invoker)
    if getElementType(invoker) ~= 'console' then
        return
    end

    sendErrorToSentry('Your test Sentry log.', ":"..getResourceName().."/server/console.lua", 'test')

    outputDebugString("Sending Sentry log.")
end)