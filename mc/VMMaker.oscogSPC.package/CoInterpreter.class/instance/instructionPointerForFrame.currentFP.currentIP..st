frame access
instructionPointerForFrame: spouseFP currentFP: currentFP currentIP: instrPtr
	"Answer the bytecode pc object (i.e. SmallInteger) for an active frame.  The bytecode
	 pc is derived from the frame's pc.  If the frame is the top frame on the current stack
	 the frame pc is whatever the current instruction pointer is.  If the frame is the top
	 frame on some other stack the frame pc is the value on top of stack.  Otherwise the
	 frame pc is the saved pc of the frame above.  Once the frame pc is found it must be
	 mapped to a bytecode pc."
	<var: #spouseFP type: #'char *'>
	<var: #currentFP type: #'char *'>
	| value theIP thePage theFPAbove |
	<var: #thePage type: #'StackPage *'>
	<var: #theFPAbove type: #'char *'>
	spouseFP = currentFP
		ifTrue: [theIP := self oopForPointer: instrPtr]
		ifFalse:
			[thePage := stackPages stackPageFor: spouseFP.
			 theFPAbove := self findFrameAbove: spouseFP inPage: thePage.
			 theIP := theFPAbove == 0
						ifTrue: [stackPages longAt: thePage headSP]
						ifFalse:[self oopForPointer: (self frameCallerSavedIP: theFPAbove)]].
	value := self contextInstructionPointer: theIP frame: spouseFP.
	^value signedIntFromLong < 0
		ifTrue: [self mustMapMachineCodePC: (objectMemory integerValueOf: value)
					context: (self frameContext: spouseFP)]
		ifFalse: [value]