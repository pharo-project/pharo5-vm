initialisation
forPlatform: platformName
	"return a VMMaker initialised to build a default no-internal-plugins, no-external-plugins vm codebase"
	^(self activeVMMakerClassFor: platformName) new initialize setPlatName: platformName