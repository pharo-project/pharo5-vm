A CurrentImageCoInterpreterFacade is a stand-in for an object memory (ObjectMemory, SpurMemoryManager, etc) that allows the Cogits to access image objects as if they were in the simulator VM's heap.  hence it allows the Cogits to generate code for methdos in the current image, for testing, etc.

Instance Variables
	cachedObject:			<Object>
	cachedOop:			<Integer>
	coInterpreter:			<CoInterpreter>
	cogit:					<Cogit>
	headerToMethodMap:	<Dictionary>
	memory:				<ByteArray>
	objectMap:				<IdentityDictionary>
	objectMemory:			<NewObjectMemory|SpurMemoryManager>
	variables:				<Dictionary>

cachedObject
	- the object matching cachedOop, to speed-up oop to obejct mapping

cachedOop
	- the last used oop

coInterpreter
	- the CoInterpreter simulator used by the cogit.

cogit
	- the code egnerator in use

headerToMethodMap
	- a map from header to CompiledMethod

memory
	- a rump memory for holding various interpreter variables (e.g. stackLimit) that are accessed as memory locations by generated code

objectMap
	- map from objects to their oops

objectMemory
	- the object memory used to encode various values, answer queries, etc

variables
	- a map from the names of variables to their addresses in memory
