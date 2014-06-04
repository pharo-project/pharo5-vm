initialize-release
shutdownModule
	<export: true>
	^self cCode: 'sqFileShutdown()' inSmalltalk:[true]