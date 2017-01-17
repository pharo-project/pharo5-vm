target directories
internalPluginsDirectoryFor: plugin
	"return the directory for the internal plugin sources"
	|fd|
	fd := self internalPluginsDirectory directoryNamed: plugin moduleName.
	fd assureExistence.
	^fd