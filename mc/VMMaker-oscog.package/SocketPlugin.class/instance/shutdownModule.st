initialize-release
shutdownModule
	<export: true>
	^self cCode: 'socketShutdown()' inSmalltalk:[true]