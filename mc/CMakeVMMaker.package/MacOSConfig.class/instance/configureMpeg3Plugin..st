plugin extra rules
configureMpeg3Plugin: maker

	super configureMpeg3Plugin: maker.
	
	maker addPlatformSources: #(	
		'sqMacFileBits.c')
	