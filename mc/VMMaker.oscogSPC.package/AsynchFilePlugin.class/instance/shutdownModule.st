initialize-release
shutdownModule
	"Initialise the module"
	<export: true>
	^self cCode: 'asyncFileShutdown()' inSmalltalk:[true]