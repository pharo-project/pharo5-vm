accessing
sources

	self set: #coreSources to: 
		(self append: '$(srcVMDir)/' toAll: config coreSources).
		
	self set: #platformVMSources to: 
		(self append: '$(targetPlatform)/vm/' toAll: config platformSources).
	
	
	self set: #crossVMSources to: 
		(self append: '$(crossDir)/vm/' toAll: config crossSources).
		
	self set: #extraSources to: config extraSources.
	
	^ '$(coreSources) $(crossVMSources) $(platformVMSources) $(extraSources)'