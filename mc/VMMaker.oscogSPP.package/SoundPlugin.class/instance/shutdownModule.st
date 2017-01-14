initialize-release
shutdownModule
	<export: true>
	^self cCode: 'soundShutdown()' inSmalltalk:[true]