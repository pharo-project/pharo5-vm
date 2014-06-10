initialize
shutdownModule
	<export: true>
	^self cCode: 'dropShutdown()' inSmalltalk:[true]