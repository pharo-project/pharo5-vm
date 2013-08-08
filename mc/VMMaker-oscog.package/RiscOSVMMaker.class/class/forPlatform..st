initialisation
forPlatform: ignored
	"override to keep a RiscOSVMMaker in charge instead of a CrossPlatformVMMaker"
	^self new initialize setPlatName: self name