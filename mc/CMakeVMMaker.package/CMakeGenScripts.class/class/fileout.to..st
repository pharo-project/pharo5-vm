scripts generation
fileout: aString to: aFileName

	" put that file to ../codegen-scripts directory "
	
 	(FileStream forceNewFileNamed: aFileName) 
		nextPutAll: aString;
		close.
	