directories
outputDir

	"the directory where built binaries will be stored"

	^ outputDir ifNil: [ outputDir := self msysPathFor: (self buildDir parent / self outputDirName) ]