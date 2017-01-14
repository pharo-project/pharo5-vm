initialize-release
shutdownModule
	<export: true>
	^self cCode: 'midiShutdown()' inSmalltalk:[true]