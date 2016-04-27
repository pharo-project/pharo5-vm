simulation only
exclude: aMethodObj selector: aSelectorOop
	"For debugging, allow excluding methods based on selector or methodClass.  Answer if the mehtod should be excluded."
	<inline: true>
	^self
		cCode: [false]
		inSmalltalk:
			[self class initializationOptions
				at: #DoNotJIT
				ifPresent:
					[:excluded| | methodClass selector |
					methodClass := coInterpreter nameOfClass: (coInterpreter methodClassOf: aMethodObj).
					selector := coInterpreter stringOf: aSelectorOop.
					(excluded anySatisfy: [:exclude| selector = exclude or: [methodClass = exclude]]) ifTrue:
						[coInterpreter transcript nextPutAll: 'EXCLUDING '; nextPutAll: methodClass; nextPutAll: '>>#'; nextPutAll: selector; cr; flush.
						 ^true]].
			 ^false]