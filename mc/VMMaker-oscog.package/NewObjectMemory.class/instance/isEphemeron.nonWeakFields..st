ephemerons
isEphemeron: oop nonWeakFields: nonWeakCnt

	"
	Check if given oop is an ephemeron.
	At this point it is already known that object format == 4 (having weak slots)

	An object is ephemeron if:
	 - having at least 2 intance variables (and two weak slots, but this check is omitted for performance reasons)
	 - first instance variable points to the instance of  ClassWeakFinalizer
	- an instance of ClassWeakFinalizer having second slot == true (see WeakFinalizationList class on language-side)
	"

	| listOop |
	
	nonWeakCnt >= 2 ifTrue: [
		listOop := self fetchPointer: 0 ofObject: oop.
		(self fetchClassOf: listOop) == (self splObj: ClassWeakFinalizer) ifTrue: [
		
		"a list oop must have at least 2 instance variables and second one must be set to true"
		(self sizeBitsOfSafe: listOop) >= (2*BytesPerWord) ifTrue: [
			^ (self fetchPointer: 1 ofObject: listOop) == self trueObject.   
		]
	]].
	^ false