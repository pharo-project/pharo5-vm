directories
outputDir

	"the directory where built binaries will be stored - for now it is copied from CogFamilyUnixConfig"
	^ outputDir ifNil: [ outputDir := (self buildDir parent / self outputDirName) ]
	