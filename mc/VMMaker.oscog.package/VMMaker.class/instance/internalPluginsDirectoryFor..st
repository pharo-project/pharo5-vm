target directories
internalPluginsDirectoryFor: plugin
	"return the directory for the internal plugin sources"
	|fd|
	fd := self internalPluginsDirectory / plugin moduleName.
	fd ensureCreateDirectory.
	^fd