as yet unclassified
gnuify
	"This Gnuifier produces a file compatible with gcc 3.x and gcc 4.x.
	 We label the gnuified VM so one can identify the valid gcc version.
	 The script run on Wndows, platforms/win32/misc/gnuify, produces
	 something compatible with gcc 2.95 (gack)."
	(directory asFileReference / ('gcc3x-', interpreterFilename)) ensureDeleted.
	self
		gnuifyFrom: (FileStream oldFileNamed: (directory asFileReference / interpreterFilename) fullName)
		to: 			(VMMaker forceNewFileNamed: (directory asFileReference / ('gcc3x-', interpreterFilename)) fullName )
	
