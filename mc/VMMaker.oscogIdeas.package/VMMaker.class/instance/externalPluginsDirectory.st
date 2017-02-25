target directories
externalPluginsDirectory
	"return the target directory for the external plugins sources"
	| fd |
	fd := self sourceDirectory directoryNamed: self class pluginsDirName.
	fd assureExistence.
	^fd