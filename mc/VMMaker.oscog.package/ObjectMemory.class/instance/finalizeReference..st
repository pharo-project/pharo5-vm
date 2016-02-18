finalization
finalizeReference: oop 
	"During sweep phase we have encountered a weak reference. Check if its object
	 has gone away (or is about to) and if so, signal a semaphore.  Do *not* inline
	 this in sweepPhase - it is quite an unlikely case to run into a weak reference"
	| weakOop oopGone chunk numFields firstField lastField |
	<inline: false>
	<var: #oop type: #usqInt>
	<var: #weakOop type: #usqInt>
	numFields := self nonWeakFieldsOf: oop. "so nonWeakFieldsOf: may be inlined"
	firstField := self baseHeaderSize + (numFields << self shiftForWord).
	lastField := self lastPointerOf: oop.
	firstField to: lastField by: self wordSize do:
		[:i|
		weakOop := self longAt: oop + i.
		"ar 1/18/2005: Added oop < youngStart test to make sure we're not testing
		objects in non-GCable region. This could lead to a forward reference in
		old space with the oop pointed to not being marked and thus treated as free."
		(weakOop = nilObj or: [(self isIntegerObject: weakOop) or:[weakOop < youngStart]]) ifFalse:
			["Check if the object is being collected. 
			If the weak reference points  
			* backward: check if the weakOops chunk is free
			* forward: check if the weakOoop has been marked by GC"
			weakOop < oop
				ifTrue: [chunk := self chunkFromOop: weakOop.
						oopGone := ((self longAt: chunk) bitAnd: TypeMask) = HeaderTypeFree]
				ifFalse: [oopGone := (self isMarked: weakOop) not].
			oopGone ifTrue: "Store nil in the pointer and signal the  interpreter"
				[self longAt: oop + i put: nilObj.
				self 
					cppIf: PharoVM 
					ifTrue: [ numFields >= 2 ifTrue: [ self weakFinalizerCheck: oop ] ].
				self signalFinalization: oop]]]