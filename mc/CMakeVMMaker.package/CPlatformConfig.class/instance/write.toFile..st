directories
write: aContents toFile: aFileName
	"write a file to current output directory (buildDir).
	use line end convention appropriate for config platform"

	| bldDir |
	bldDir := self buildDir.
	bldDir isString
		ifTrue: [ bldDir := bldDir asFileReference ].
	bldDir ensureDirectory.
	(bldDir / aFileName)
		ensureFile
		writeStream
		nextPutAll: (self fixLineEndsOf: aContents)