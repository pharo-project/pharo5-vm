generating actions
unpack
	"produce commands for unpacking the library archive.
	
	the output of this command should use a directory
	${workDir}/${libName}
	where the unpacked library sources will be located.
	
	see #setVariables method for understanding what variables used here
	"

	gen set: #unpackTarget toString: '${libSourcesDir}/touch.cmake'.
	
	gen puts:
'add_custom_command(OUTPUT "${unpackTarget}"
		COMMAND tar -xzf "${archiveFileName}" 
		COMMAND touch "${unpackTarget}"
		COMMENT "Unpacking ${libName} ... "
	)
'.
