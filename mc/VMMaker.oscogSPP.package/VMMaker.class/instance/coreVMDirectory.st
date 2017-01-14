target directories
coreVMDirectory
	"return the target directory for the main VM sources, interp.c etc"
	| fd |
	fd := self sourceDirectory directoryNamed: self class coreVMDirName.
	fd assureExistence.
	^ fd