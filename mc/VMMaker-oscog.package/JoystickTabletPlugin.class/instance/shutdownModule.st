initialize-release
shutdownModule
	<export: true>
	^self cCode: 'joystickShutdown()' inSmalltalk:[true]