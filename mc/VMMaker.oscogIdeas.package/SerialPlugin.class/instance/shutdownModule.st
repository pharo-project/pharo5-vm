initialize-release
shutdownModule
	<export: true>
	^self cCode: 'serialPortShutdown()' inSmalltalk:[true]