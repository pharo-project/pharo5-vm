translation
implicitReturnTypeFor: aSelector
	"Answer the return type for methods that don't have an explicit return.
	 Try and use sqInt for the interpreter and whatever ObjectMemory wants
	 (void at time of writing) for ObjectMemory methods."
	^(ObjectMemory canUnderstand: aSelector)
		ifTrue: [ObjectMemory implicitReturnTypeFor: aSelector]
		ifFalse: [#sqInt]