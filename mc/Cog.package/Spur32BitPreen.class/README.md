A Spur32BitPreen is a simple image rewriter for 32-bit Spru images that eliminates free space and hence shrinks the preened image.  Use via
	Spur32BitPreen new preenImage: 'spur'
which will produce spur-preen.image and spur-preen.changes from spur.image and spur.changes.

Instance Variables
	imageHeaderFlags:		<Integer>
	map:					<Dictionary>
	newHeap:				<Spur32BitMMLESimulator>
	newInterpreter:			<StackInterpreterSimulatorLSB>
	oldHeap:				<Spur32BitMMLESimulator>
	oldInterpreter:			<StackInterpreterSimulatorLSB>
	reverseMap:			<Dictionary>
	savedWindowSize:		<Integer>

imageHeaderFlags
	- flags word in image header

map
	- map from oops in old image to oops in new image

newHeap
	- the preened heap

newInterpreter
	- the interpreter wrapping the preened heap

oldHeap
	- the heap to be preened

oldInterpreter
	- the interpreter wrapping the heap to be preened

reverseMap
	- map from oops in new image to oops in old image

savedWindowSize
	- screen size word in mage header
