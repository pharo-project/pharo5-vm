C code generator
cLiteralFor: anObject name: smalltalkName
	"Return a string representing the C literal value for the given object.
	 This version may use hex for integers that are bit masks."
	anObject isInteger ifTrue:
		[| hex dec rep |
		hex := anObject printStringBase: 16.
		dec := anObject printStringBase: 10.
		rep := ((smalltalkName endsWith: 'Mask')
				or: [anObject digitLength > 1
					and: [(hex asSet size * 3) <= (dec asSet size * 2)
					and: [(smalltalkName endsWith: 'Size') not]]])
					ifTrue: [hex first = $- ifTrue: ['-0x', hex allButFirst] ifFalse: ['0x', hex]]
					ifFalse: [dec].
		^anObject > 16rFFFFFFFF
			ifTrue: [rep, ObjectMemory unsignedLongLongSuffix]
			ifFalse: [anObject < 16r7FFFFFFF
				ifTrue: [rep]
				ifFalse: [rep, ObjectMemory unsignedIntegerSuffix]]].
	^self cLiteralFor: anObject