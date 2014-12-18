generating actions
copyArtefacts
	super copyArtefacts.
	"Copying link so we can access to the general name"
	self 
		copyLink: '${libSDL2LinkInstalled}' 
		to: '${externalModulesDir}/${libraryLinkFileName}'