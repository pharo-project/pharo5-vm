initialize-release
initialiseModule
	<export: true>
	^self cCode: 'serialPortInit()' inSmalltalk:[true]