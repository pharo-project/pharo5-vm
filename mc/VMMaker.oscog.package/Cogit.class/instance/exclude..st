simulation only
exclude: aMethodObj
	"For debugging, allow excluding methods based on selector or methodClass.  Answer if the mehtod should be excluded."
	<inline: true>
	self cCode: [] inSmalltalk: "for debugging, allow excluding methods based on selector or methodClass"
		[self class initializationOptions
			at: #DoNotJIT
			ifPresent:
				[:excluded| 
				(excluded anySatisfy: [:exclude| aMethodObj = exclude]) ifTrue:
					[coInterpreter transcript
						ensureCr; nextPutAll: 'EXCLUDING ';
						nextPutAll: aMethodObj; nextPutAll: ' (compiled block)';
						cr; flush.
					 ^true]].
		 (compilationTrace anyMask: 1) ifTrue:
			[| methodClass |
			 methodClass := coInterpreter nameOfClass: (coInterpreter methodClassOf: aMethodObj).
			 coInterpreter transcript
				ensureCr;
				nextPutAll: 'compiling compiled block in ';
				nextPutAll: methodClass;
				cr; flush]].
	^false