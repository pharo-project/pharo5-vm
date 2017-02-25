utilities
oldFileNamed: aFilename
	"Always output files in unix lf format.
		A single format is friendlier to e.g. external version control systems.
		The Microsoft and old MacOS classic C compilers all accept lf format files."

	^(MultiByteFileStream oldFileNamed: aFilename)
		lineEndConvention: #lf;
		yourself