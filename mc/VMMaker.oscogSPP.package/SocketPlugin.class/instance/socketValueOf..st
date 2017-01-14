primitives
socketValueOf: socketOop 
	"Return a pointer to the first byte of of the socket record within the  
	 given Smalltalk object, or nil if socketOop is not a socket record."
	<returnTypeC: 'SocketPtr'>
	interpreterProxy success: ((interpreterProxy isBytes: socketOop)
			and: [(interpreterProxy byteSizeOf: socketOop)
					= self socketRecordSize]).
	^interpreterProxy failed
		ifTrue: [nil]
		ifFalse: [self cCoerce: (interpreterProxy firstIndexableField: socketOop) to: 'SocketPtr']