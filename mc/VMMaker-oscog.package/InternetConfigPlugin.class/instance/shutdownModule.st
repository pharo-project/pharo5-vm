initialize
shutdownModule
	<export: true>
	^self cCode: 'sqInternetConfigurationShutdown()' inSmalltalk:[true]