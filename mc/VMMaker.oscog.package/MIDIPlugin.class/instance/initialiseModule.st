initialize-release
initialiseModule
	<export: true>
	^self cCode: 'midiInit()' inSmalltalk:[true]