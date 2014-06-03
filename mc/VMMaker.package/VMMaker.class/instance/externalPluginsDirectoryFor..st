target directories
externalPluginsDirectoryFor: plugin
	"return the directory for the external plugin sources"
	|fd|
	fd := self externalPluginsDirectory / plugin moduleName.
	fd ensureCreateDirectory.
	^fd