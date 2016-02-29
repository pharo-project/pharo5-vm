generating cmake file
generate

	gen message: 'Configuring thirdparty package: ', self canonicalName.
	
	self 
		setVariables;
		download;
		unpack;
		build;
		copyArtefacts