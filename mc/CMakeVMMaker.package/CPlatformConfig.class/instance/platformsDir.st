accessing
platformsDir 
	"Answer the value of srcDir"

	^ platformsDir ifNil: [ platformsDir := (self topDir / self platformsDirName) fullName ]
	