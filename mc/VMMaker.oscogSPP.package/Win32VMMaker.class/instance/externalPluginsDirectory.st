target directories
externalPluginsDirectory
	"return the target directory for the external plugins sources"
	^self sourceDirectory
"	| fd |
	fd := self sourceDirectory directoryNamed: 'external'.
	fd assureExistence.
	^fd"