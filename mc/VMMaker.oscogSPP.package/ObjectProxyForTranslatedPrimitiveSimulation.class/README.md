An ObjectProxyForTranslatedPrimitiveSimulation is a wrapper for an object on the simulated heap that allows that "object" to be accessed from within a simulating translated primitive such as Bitmap>>compress:toByteArray:.

Instance Variables
	interpreter:		<ObjectMemory|SpurMemoryManager>
	oop:			<Integer>
	unitSize:		<Integer>

interpreter
	- the object memory class being used as the simulator's interpreterProxy

oop
	- the oop of the "object" being wrapped

unitSize
	- 1, 2, 4 or 8
