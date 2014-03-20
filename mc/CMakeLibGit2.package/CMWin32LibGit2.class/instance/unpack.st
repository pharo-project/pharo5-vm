generating actions
unpack
	"Overriding because I need to exclude files that are links (and because of that it ends in an error) "

	gen set: #unpackTarget toString: '${libSourcesDir}/touch.cmake'.
	
	gen puts:
'add_custom_command(OUTPUT "${unpackTarget}"
		COMMAND tar --exclude "link.sample" -xzf "${archiveFileName}" 
		COMMAND touch "${unpackTarget}"
		COMMENT "Unpacking ${libName} ... "
	)
'.
