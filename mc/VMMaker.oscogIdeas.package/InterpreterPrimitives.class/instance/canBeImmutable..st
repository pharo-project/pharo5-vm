object access primitives
canBeImmutable: oop
	<option: #IMMUTABILITY>
	| scheduler processLists |
	
	self assert: (objectMemory isNonImmediate: oop).
	
	"For now we fail the primitive for contexts to we ensure there are no immutable contexts.
	Later we can consider having immutable contexts and send cannotReturn callback
	when returning to an immutable context. That would mean that setting a context 
	to immutable would require a divorce and returns to immutable context are 
	necessarily across stack pages"
	(objectMemory isContext: oop) ifTrue: [ ^ false ].
	
	"Weak structures can't be immutable"
	(objectMemory isEphemeron: oop) ifTrue: [^ false].
	(objectMemory isWeakNonImm: oop) ifTrue: [^ false].
	
	"No clue what is going on for semaphores so they can't be immutable"
	(objectMemory isSemaphoreObj: oop) ifTrue: [^ false].
	
	"Simple version of process management: we forbid Process and LinkedList instances to be immutable 
	 as well as the Processor and the array of activeProcess"
	scheduler := self fetchPointer: ValueIndex ofObject: (self splObj: SchedulerAssociation).
	processLists := objectMemory fetchPointer: ProcessListsIndex ofObject: scheduler.
	oop = scheduler ifTrue: [ ^ false ].
	oop = processLists ifTrue: [ ^ false ].
	"Is it a linkedList ?"
	(objectMemory classIndexOf: (objectMemory fetchPointer: 1 ofObject: processLists)) = (objectMemory classIndexOf: oop) ifTrue: [ ^ false ].
	"is it a Process ?"
	(objectMemory classIndexOf: (objectMemory fetchPointer: ActiveProcessIndex ofObject: scheduler)) =  (objectMemory classIndexOf: oop) ifTrue: [ ^ false ].
	
	"The rest of the code is relative to process management: the Processor (the active 
	process scheduler) can't be immutable, as well as all the objects relative to Process management "
	"scheduler := self fetchPointer: ValueIndex ofObject: (self splObj: SchedulerAssociation).
	processLists := objectMemory fetchPointer: ProcessListsIndex ofObject: scheduler.
	((objectMemory formatOf: oop) = objectMemory nonIndexablePointerFormat)
		ifFalse: 
			[ (objectMemory isArrayNonImm: oop) ifFalse: [ ^ true ].
			  ^ (oop = processLists) not ].
	(objectMemory numSlotsOf: oop) >= 2 ifFalse: [ ^ true ].
	""is the oop the scheduler itself ?""
	oop = scheduler ifTrue: [ ^ false ].
	1 to: (objectMemory numSlotsOf: processLists) do: [ :i |
		""is the oop one of the linked lists ?""
		(list := processLists at: i) = oop ifTrue: [^ false].
		""is the oop one of the runnable process ?""
		first := objectMemory fetchPointer: FirstLinkIndex ofObject: list.
		first = objectMemory nilObject ifFalse: 
			[ last := objectMemory fetchPointer: LastLinkIndex ofObject: list.
			  link := first.
			  [ link = last ] whileFalse: 
				[ link = oop ifTrue: [ ^ false ]. 
				  link := objectMemory fetchPointer: NextLinkIndex ofObject: link. ] ] ]."
	^ true