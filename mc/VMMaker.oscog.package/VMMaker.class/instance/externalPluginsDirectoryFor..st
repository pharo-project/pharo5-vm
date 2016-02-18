target directories
externalPluginsDirectoryFor: plugin
	"return the directory for the external plugin sources"
	|fd|
	fd := self externalPluginsDirectory directoryNamed: plugin moduleName.
	fd assureExistence.
	^fd