initialize-release
initialiseModule
	"Initialise the module"
	<export: true>
	sCOAFfn := interpreterProxy ioLoadFunction: 'secCanOpenAsyncFileOfSizeWritable' From: 'SecurityPlugin'.
	^self cCode: 'asyncFileInit()' inSmalltalk:[true]