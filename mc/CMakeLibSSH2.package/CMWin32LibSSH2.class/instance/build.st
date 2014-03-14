generating actions
build
	"In windows build I need the exec-prefix because it thinks a dll is an executable. 
	 Thats also the reason I need another variable to copy the artifact to the appropriate place (see #setVariables).
	 In all other terms, this method is equal to its parent."
	
	gen 
		puts:
'
add_custom_command(OUTPUT "${libSSH2Installed}"
	COMMAND ./configure --prefix=''${installPrefix}'' --exec-prefix=''${installPrefix}'' ', self configurationFlags, '
	DEPENDS "${unpackTarget}"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)
'