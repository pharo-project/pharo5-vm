A SistaCogit is a refinement of RegisterAllocatingCogit that generates code suitable for dynamic optimization by Sista, the Speculative Inlining Smalltalk Architecture, a project by Clément Bera and Eliot Miranda.  Sista is an optimizer that exists in the Smalltalk image, /not/ in the VM,  and optimizes by substituting normal bytecoded methods by optimized bytecoded methods that may use special bytecodes for which the Cogit can generate faster code.  These bytecodes eliminate overheads such as bounds checks or polymorphic code (indexing Array, ByteArray, String etc).  But the bulk of the optimization performed is in inlining blocks and sends for the common path.

The basic scheme is that SistaCogit generates code containing performance counters.  When these counters trip, a callback into the image is performed, at which point Sista analyses some portion of the stack, looking at performance data for the methods on the stack, and optimises based on the stack and performance data.  Execution then resumes in the optimized code.

SistaCogit adds counters to conditional branches.  Each branch has an executed and a taken count, implemented at the two 16-bit halves of a single 32-bit word.  Each counter pair is initialized with initialCounterValue.  On entry to the branch the executed count is decremented and if the count goes below zero the ceMustBeBooleanAdd[True|False] trampoline called.  The trampoline distinguishes between true mustBeBoolean and counter trips because in the former the register temporarily holding the counter value will contain zero.  Then the condition is tested, and if the branch is taken the taken count is decremented.  The two counter values allow an optimizer to collect basic block execution paths and to know what are the "hot" paths through execution that are worth agressively optimizing.  Since conditional branches are about 1/6 as frequent as sends, and since they can be used to determine the hot path through code, they are a better choice to count than, for example, method or block entry.

SistaCogit implements picDataFor:into: that fills an Array with the state of the counters in a method and the state of each linked send in a method.  This is used to implement a primitive used by the optimizer to answer the branch and send data for a method as an Array.

Instance Variables
	counterIndex:			<Integer>
	counterMethodCache:	<CogMethod>
	counters:				<Array of AbstractInstruction>
	initialCounterValue:		<Integer>
	numCounters:			<Integer>
	picData:				<Integer Oop>
	picDataIndex:			<Integer>
	prevMapAbsPCMcpc:	<Integer>

counterIndex
	- xxxxx

counterMethodCache
	- xxxxx

counters
	- xxxxx

initialCounterValue
	- xxxxx

numCounters
	- xxxxx

picData
	- xxxxx

picDataIndex
	- xxxxx

prevMapAbsPCMcpc
	- xxxxx
