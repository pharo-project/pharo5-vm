InterpreterPrimitives implements most of the VM's core primitives.  It is the root of the interpreter hierarchy so as to share the core primitives amongst the varioius interpreters.

Instance Variables
	argumentCount:	<Integer>
	messageSelector:	<Integer>
	newMethod:		<Integer>
	nextProfileTick:		<Integer>
	objectMemory:		<ObjectMemory> (simulation only)
	preemptionYields:	<Boolean>
	primFailCode:		<Integer>
	profileMethod:		<Integer>
	profileProcess:		<Integer>
	profileSemaphore:	<Integer>

argumentCount
	- the number of arguments of the current message

messageSelector
	- the oop of the selector of the current message

newMethod
	- the oop of the result of looking up the current message

nextProfileTick
	- the millisecond clock value of the next profile tick (if profiling is in effect)

objectMemory
	- the memory manager and garbage collector that manages the heap

preemptionYields
	- a boolean controlling the process primitives.  If true (old, incorrect, blue-book semantics) a preempted process is sent to the back of its run-queue.  If false, a process preempted by a higher-priority process is put back at the head of its run queue, hence preserving cooperative scheduling within priorities.

primFailCode
	- primtiive success/failure flag, 0 for success, otherwise the reason code for failure

profileMethod
	- the oop of the method at the time nextProfileTick was reached

profileProcess
	- the oop of the activeProcess at the time nextProfileTick was reached

profileSemaphore
	- the oop of the semaphore to signal when nextProfileTick is reached
