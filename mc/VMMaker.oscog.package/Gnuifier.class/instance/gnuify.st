as yet unclassified
gnuify
	"This Gnuifier produces a file compatible with gcc 3.x and gcc 4.x.
	 We label the gnuified VM so one can identify the valid gcc version.
	 The script run on Wndows, platforms/win32/misc/gnuify, produces
	 something compatible with gcc 2.95 (gack)."
	(directory fileExists: 'gcc3x-', interpreterFilename) ifTrue:
		[directory deleteFileNamed: 'gcc3x-', interpreterFilename].
	self
		gnuifyFrom: (directory oldFileNamed: interpreterFilename)
		to: 			(VMMaker forceNewFileNamed: (directory fullNameFor: 'gcc3x-', interpreterFilename))
	
