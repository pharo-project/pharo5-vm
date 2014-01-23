cmake commands
addExternalLibrary: aLibrary 
	self cmd: 'list'
		params: 'APPEND LINKLIBS ' , aLibrary .
		
"	self cmd: 'target_link_libraries' 
		params: self moduleName , ' ' , aLibrary.
"	
