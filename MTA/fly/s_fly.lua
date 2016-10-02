addCommandHandler ("fly",
    function ()
        if not flyEnabled then
            setWorldSpecialPropertyEnabled ( "aircars", true )
            flyEnabled = true
        else
            setWorldSpecialPropertyEnabled ( "aircars", false )
            flyEnabled = false
        end
    end
)