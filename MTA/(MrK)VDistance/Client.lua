function set( cmd, arg )
	--outputChatBox( tonumber(arg) and arg or 800)
	setOcclusionsEnabled ( false )
	setFarClipDistance( tonumber(arg) and arg or 800 )
end
addCommandHandler("svd", set )
