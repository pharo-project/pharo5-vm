surface support
query: handle Sur: widthPtr fa: heightPtr ce: depthPtr Fn: endianPtr
	"Query the dimension of an OS surface.
	This method is provided so that in case the inst vars of the
	source form are broken, *actual* values of the OS surface
	can be obtained. This might, for instance, happen if the user
	resizes the main window.
	This is a simulation of the querySurfaceFn function call; simulate as a failure."
	<doNotGenerate>
	^false