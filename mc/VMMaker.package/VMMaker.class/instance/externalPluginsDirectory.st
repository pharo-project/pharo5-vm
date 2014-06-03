target directories
externalPluginsDirectory
	"return the target directory for the external plugins sources"
	| fd |
	fd := self sourceDirectory / self class pluginsDirName.
	fd ensureCreateDirectory.
	^fd