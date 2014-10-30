header access
setIsMarkedOf: objOop to: aBoolean
	"objOop = 16rB26020 ifTrue: [self halt]."
	"(#(16r1971D0 16r196EE0 16r197048 16r197148) includes: objOop) ifTrue:
		[self halt]."
	super setIsMarkedOf: objOop to: aBoolean.
	"(aBoolean
	 and: [(self isContextNonImm: objOop)
	 and: [(coInterpreter
			checkIsStillMarriedContext: objOop
			currentFP: coInterpreter framePointer)
	 and: [(coInterpreter stackPages stackPageFor: (coInterpreter frameOfMarriedContext: objOop)) trace = 0]]]) ifTrue:
		[self halt]"