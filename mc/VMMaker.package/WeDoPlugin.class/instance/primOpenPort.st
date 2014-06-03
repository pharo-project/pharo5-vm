translated prims
primOpenPort
	"Open the WeDo port."

	<export: true>
	interpreterProxy success: (self cCode: 'WeDoOpenPort()').
	^ 0
