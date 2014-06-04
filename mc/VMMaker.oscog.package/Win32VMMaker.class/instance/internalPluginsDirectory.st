target directories
internalPluginsDirectory
	"return the target directory for the internal plugins sources"
	^self sourceDirectory
"	| fd |
	fd := self sourceDirectory directoryNamed: 'internal'.
	fd assureExistence.
	^fd"