translated prims
primClosePort
	"Close the WeDo port."

	<export: true>
	interpreterProxy success: (self cCode: 'WeDoClosePort()').
	^ 0
