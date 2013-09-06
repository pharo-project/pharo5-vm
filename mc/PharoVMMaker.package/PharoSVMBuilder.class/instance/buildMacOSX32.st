building
buildMacOSX32 
	
	self buildConfig: (PharoSOSXConfig new  
		addExternalPlugins: #(  FT2Plugin );
		addInternalPlugins: #( UnixOSProcessPlugin );
		yourself).
