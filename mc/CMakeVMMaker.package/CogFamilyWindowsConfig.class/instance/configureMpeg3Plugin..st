plugin extra rules
configureMpeg3Plugin:  maker 
	"extra rules for Mpeg3Plugin "

	super configureMpeg3Plugin:  maker.
	
	maker addDefinitions: '-DNOPTHREADS'.

	maker addPlatformSources: #( 'sqOpenFile.c')