accessing
resourcesDir 
	"Answer the value of resourcesDir"
	^ resourcesDir ifNil: [ resourcesDir := (self topDir / 'iosbuild' / 'resources') fullName ]