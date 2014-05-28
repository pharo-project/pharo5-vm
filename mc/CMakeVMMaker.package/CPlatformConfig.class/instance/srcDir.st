accessing
srcDir
	"Answer the value of srcDir"

	^ srcDir ifNil: [ srcDir := (self topDir / self srcDirName) ensureCreateDirectory fullName ]