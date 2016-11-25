simulation only
exclude: aMethodObj selector: aSelectorOop
	"For debugging, allow excluding methods based on selector or methodClass.  Answer if the mehtod should be excluded."
	<inline: true>
	self cCode: [] inSmalltalk:
		[| methodClass selector |
		 self class initializationOptions
			at: #DoNotJIT
			ifPresent:
				[:excluded|
				methodClass := coInterpreter nameOfClass: (coInterpreter methodClassOf: aMethodObj).
				selector := coInterpreter stringOf: aSelectorOop.
				(excluded anySatisfy: [:exclude| selector = exclude or: [methodClass = exclude]]) ifTrue:
					[coInterpreter transcript
						ensureCr; nextPutAll: 'EXCLUDING ';
						nextPutAll: methodClass; nextPutAll: '>>#'; nextPutAll: selector;
						cr; flush.
					 ^true]].
		 (compilationTrace anyMask: 1) ifTrue:
			[methodClass := coInterpreter nameOfClass: (coInterpreter methodClassOf: aMethodObj).
			 selector := coInterpreter stringOf: aSelectorOop.
			 selector isEmpty ifTrue:
				[selector := coInterpreter stringOf: (coInterpreter maybeSelectorOfMethod: aMethodObj)].
			 coInterpreter transcript
				ensureCr; nextPutAll: 'compiling ';
				nextPutAll: methodClass; nextPutAll: '>>#'; nextPutAll: selector;
				cr; flush]].
	^false