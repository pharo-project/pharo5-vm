as yet unclassified
generate

	gen message: 'Configuring thirdparty package: ', self canonicalName.
	
	self 
		setVariables;
		build