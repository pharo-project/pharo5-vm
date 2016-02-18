system control primitives
primitiveVMParameter
	"Behaviour depends on argument count:
		0 args:	return an Array of VM parameter values;
		1 arg:	return the indicated VM parameter;
		2 args:	set the VM indicated parameter.
	VM parameters are numbered as follows:
		1	end of old-space (0-based, read-only)
		2	end of young-space (read-only)
		3	end of memory (read-only)
		4	allocationCount (read-only)
		5	allocations between GCs (read-write)
		6	survivor count tenuring threshold (read-write)
		7	full GCs since startup (read-only)
		8	total milliseconds in full GCs since startup (read-only)
		9	incremental GCs since startup (read-only)
		10	total milliseconds in incremental GCs since startup (read-only)
		11	tenures of surving objects since startup (read-only)
		12-20 specific to the translating VM
		21	root table size (read-only)
		22	root table overflows since startup (read-only)
		23	bytes of extra memory to reserve for VM buffers, plugins, etc.
		24	memory threshold above which shrinking object memory (rw)
		25	memory headroom when growing object memory (rw)
		26  interruptChecksEveryNms - force an ioProcessEvents every N milliseconds, in case the image  is not calling getNextEvent often (rw)
		27	number of times mark loop iterated for current IGC/FGC (read-only) includes ALL marking
		28	number of times sweep loop iterated  for current IGC/FGC (read-only)
		29	number of times make forward loop iterated for current IGC/FGC (read-only)
		30	number of times compact move loop iterated for current IGC/FGC (read-only)
		31	number of grow memory requests (read-only)
		32	number of shrink memory requests (read-only)
		33	number of root table entries used for current IGC/FGC (read-only)
		34	number of allocations done before current IGC/FGC (read-only)
		35	number of survivor objects after current IGC/FGC (read-only)
		36	millisecond clock when current IGC/FGC completed (read-only)
		37	number of marked objects for Roots of the world, not including Root Table entries for current IGC/FGC (read-only)
		38  milliseconds taken by current IGC  (read-only)
		39  Number of finalization signals for Weak Objects pending when current IGC/FGC completed (read-only)
		40	BytesPerWord for this image
		41  imageFormatVersion for the VM
		42	nil (number of stack pages in use in Stack VM)
		43	nil (desired number of stack pages in Stack VM)
		44	nil (size of eden, in bytes in Stack VM)
		45	nil (desired size of eden in Stack VM)
		46-55 nil; reserved for VM parameters that persist in the image (such as eden above)
		56	number of process switches since startup (read-only)
		57	number of ioProcessEvents calls since startup (read-only)
		58	number of ForceInterruptCheck calls since startup (read-only)
		59	number of check event calls since startup (read-only)
		
	Note: Thanks to Ian Piumarta for this primitive."

	| mem paramsArraySize result arg index |
	<var: #mem type: #usqInt>
	mem := self startOfMemory.
	paramsArraySize := 59.
	argumentCount = 0 ifTrue: [
		result := self instantiateClass: (self splObj: ClassArray) indexableSize: paramsArraySize.
		self storePointerUnchecked: 0	ofObject: result withValue: (self integerObjectOf: youngStart - mem).
		self storePointerUnchecked: 1	ofObject: result withValue: (self integerObjectOf: freeBlock - mem).
		self storePointerUnchecked: 2	ofObject: result withValue: (self integerObjectOf: endOfMemory - mem).
		self storePointerUnchecked: 3	ofObject: result withValue: (self integerObjectOf: allocationCount).
		self storePointerUnchecked: 4	ofObject: result withValue: (self integerObjectOf: allocationsBetweenGCs).
		self storePointerUnchecked: 5	ofObject: result withValue: (self integerObjectOf: tenuringThreshold).
		self storePointerUnchecked: 6	ofObject: result withValue: (self integerObjectOf: statFullGCs).
		self storePointerUnchecked: 7	ofObject: result withValue: (self integerObjectOf: statFullGCUsecs + 500 // 1000).
		self storePointerUnchecked: 8	ofObject: result withValue: (self integerObjectOf: statIncrGCs).
		self storePointerUnchecked: 9	ofObject: result withValue: (self integerObjectOf: statIncrGCUsecs + 500 // 1000).
		self storePointerUnchecked: 10	ofObject: result withValue: (self integerObjectOf: statTenures).
		11 to: 19 do:
			[:i | self storePointerUnchecked: i ofObject: result withValue: ConstZero].
		self storePointerUnchecked: 20	ofObject: result withValue: (self integerObjectOf: rootTableCount).
		self storePointerUnchecked: 21	ofObject: result withValue: (self integerObjectOf: statRootTableOverflows).
		self storePointerUnchecked: 22	ofObject: result withValue: (self integerObjectOf: extraVMMemory).
		self storePointerUnchecked: 23	ofObject: result withValue: (self integerObjectOf: shrinkThreshold).
		self storePointerUnchecked: 24	ofObject: result withValue: (self integerObjectOf: growHeadroom).
		self storePointerUnchecked: 25	ofObject: result withValue: (self integerObjectOf: interruptChecksEveryNms).
		self storePointerUnchecked: 26	ofObject: result withValue: (self integerObjectOf: statMarkCount).
		self storePointerUnchecked: 27	ofObject: result withValue: (self integerObjectOf: statSweepCount).
		self storePointerUnchecked: 28	ofObject: result withValue: (self integerObjectOf: statMkFwdCount).
		self storePointerUnchecked: 29	ofObject: result withValue: (self integerObjectOf: statCompMoveCount).
		self storePointerUnchecked: 30	ofObject: result withValue: (self integerObjectOf: statGrowMemory).
		self storePointerUnchecked: 31	ofObject: result withValue: (self integerObjectOf: statShrinkMemory).
		self storePointerUnchecked: 32	ofObject: result withValue: (self integerObjectOf: statRootTableCount).
		self storePointerUnchecked: 33	ofObject: result withValue: (self integerObjectOf: statAllocationCount).
		self storePointerUnchecked: 34	ofObject: result withValue: (self integerObjectOf: statSurvivorCount).
		self storePointerUnchecked: 35	ofObject: result withValue: (self integerObjectOf: statGCEndTime).
		self storePointerUnchecked: 36	ofObject: result withValue: (self integerObjectOf: statSpecialMarkCount).
		self storePointerUnchecked: 37	ofObject: result withValue: (self integerObjectOf: statIGCDeltaUsecs + 500 // 1000).
		self storePointerUnchecked: 38	ofObject: result withValue: (self integerObjectOf: statPendingFinalizationSignals).
		self storePointerUnchecked: 39	ofObject: result withValue: (self integerObjectOf: self wordSize).
		self storePointerUnchecked: 40	ofObject: result withValue: (self integerObjectOf: self imageFormatVersion).
		41 to: 54 do:
			[:i | self storePointerUnchecked: i ofObject: result withValue: nilObj].
		self storePointerUnchecked: 55	ofObject: result withValue: (self integerObjectOf: statProcessSwitch).
		self storePointerUnchecked: 56	ofObject: result withValue: (self integerObjectOf: statIOProcessEvents).
		self storePointerUnchecked: 57	ofObject: result withValue: (self integerObjectOf: statQuickCheckForEvents).
		self storePointerUnchecked: 58	ofObject: result withValue: (self integerObjectOf: statCheckForEvents).
		self pop: 1 thenPush: result.
		^nil].

	arg := self stackTop.
	(self isIntegerObject: arg) ifFalse: [^self primitiveFail].
	arg := self integerValueOf: arg.
	argumentCount = 1 ifTrue: [	 "read VM parameter"
		(arg < 1 or: [arg > paramsArraySize]) ifTrue: [^self primitiveFail].
		arg = 1		ifTrue: [result := youngStart - mem].
		arg = 2		ifTrue: [result := freeBlock - mem].
		arg = 3		ifTrue: [result := endOfMemory - mem].
		arg = 4		ifTrue: [result := allocationCount].
		arg = 5		ifTrue: [result := allocationsBetweenGCs].
		arg = 6		ifTrue: [result := tenuringThreshold].
		arg = 7		ifTrue: [result := statFullGCs].
		arg = 8		ifTrue: [result := statFullGCUsecs + 500 // 1000].
		arg = 9		ifTrue: [result := statIncrGCs].
		arg = 10	ifTrue: [result := statIncrGCUsecs + 500 // 1000].
		arg = 11	ifTrue: [result := statTenures].
		(arg >= 12
		 and: [arg <= 20]) ifTrue: [result := 0].
		arg = 21	ifTrue: [result := rootTableCount].
		arg = 22	ifTrue: [result := statRootTableOverflows].
		arg = 23	ifTrue: [result := extraVMMemory].
		arg = 24	ifTrue: [result := shrinkThreshold].
		arg = 25	ifTrue: [result := growHeadroom].
		arg = 26	ifTrue: [result := interruptChecksEveryNms]. 
		arg = 27	ifTrue: [result := statMarkCount]. 
		arg = 28	ifTrue: [result := statSweepCount]. 
		arg = 29	ifTrue: [result := statMkFwdCount]. 
		arg = 30	ifTrue: [result := statCompMoveCount]. 
		arg = 31	ifTrue: [result := statGrowMemory]. 
		arg = 32	ifTrue: [result := statShrinkMemory]. 
		arg = 33	ifTrue: [result := statRootTableCount]. 
		arg = 34	ifTrue: [result := statAllocationCount]. 
		arg = 35	ifTrue: [result := statSurvivorCount]. 
		arg = 36  	ifTrue: [result := statGCEndTime]. 
		arg = 37  	ifTrue: [result := statSpecialMarkCount]. 
		arg = 38  	ifTrue: [result := statIGCDeltaUsecs + 500 // 1000]. 
		arg = 39  	ifTrue: [result := statPendingFinalizationSignals]. 
		arg = 40  	ifTrue: [result := self wordSize].
		arg = 41  	ifTrue: [result := self imageFormatVersion].
		(arg >= 42
		 and: [arg <= 55]) ifTrue: [result := nilObj].
		arg = 56  	ifTrue: [result := statProcessSwitch].
		arg = 57  	ifTrue: [result := statIOProcessEvents].
		arg = 58  	ifTrue: [result := statQuickCheckForEvents].
		arg = 59  	ifTrue: [result := statCheckForEvents].
		self pop: 2 thenPush: (self integerObjectOf: result).
		^nil].

	"write a VM parameter"
	argumentCount = 2 ifFalse: [^self primitiveFail].
	index := self stackValue: 1.
	(self isIntegerObject: index) ifFalse: [^self primitiveFail].
	index := self integerValueOf: index.
	index <= 0 ifTrue: [^self primitiveFail].
	successFlag := false.
	index = 5 ifTrue: [
		result := allocationsBetweenGCs.
		allocationsBetweenGCs := arg.
		successFlag := true].
	index = 6 ifTrue: [
		result := tenuringThreshold.
		tenuringThreshold := arg.
		successFlag := true].
	index = 23 ifTrue: [
		result := extraVMMemory.
		extraVMMemory := arg.
		successFlag := true].
	index = 24 ifTrue: [
		result := shrinkThreshold.
		arg > 0 ifTrue:[
			shrinkThreshold := arg.
			successFlag := true]].
	index = 25 ifTrue: [
		result := growHeadroom.
		arg > 0 ifTrue:[
			growHeadroom := arg.
			successFlag := true]].
	index = 26 ifTrue: [
		arg > 1 ifTrue:[
			result := interruptChecksEveryNms.
			interruptChecksEveryNms := arg.
			successFlag := true]]. 

	successFlag ifTrue: [
		self pop: 3 thenPush: (self integerObjectOf: result).  "return old value"
		^ nil].

	self primitiveFail.  "attempting to write a read-only parameter"



