initialize
shutdownModule
	<export: true>
	^self cCode: 'sqUUIDShutdown()' inSmalltalk:[true]