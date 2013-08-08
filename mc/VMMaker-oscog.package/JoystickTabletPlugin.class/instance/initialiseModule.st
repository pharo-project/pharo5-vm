initialize-release
initialiseModule
	<export: true>
	^self cCode: 'joystickInit()' inSmalltalk:[true]