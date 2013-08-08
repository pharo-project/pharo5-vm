accessing
outputDir

	"the directory where built binaries will be stored"
	^ outputDir ifNil: [ outputDir := (self buildDir parent / self outputDirName) ]
	