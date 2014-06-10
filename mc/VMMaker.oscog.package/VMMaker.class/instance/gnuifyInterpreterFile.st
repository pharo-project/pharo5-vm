processing external files
gnuifyInterpreterFile
"post-process the interp.c file to make it gcc friendly"
	(Gnuifier on: self coreVMDirectory)
		interpreterFilename: self interpreterFilename;
		gnuify.