jit - api
setSelectorOf: cogMethod to: aSelectorOop
	<api>
	"If a method is compiled to machine code via a block entry it won't have a selector.
	 A subsequent send can find the method and hence fill in the selector."
	<var: #cogMethod type: #'CogMethod *'>
	"self disassembleMethod: cogMethod"
	coInterpreter
		compilationBreak: aSelectorOop
		point: (objectMemory lengthOf: aSelectorOop).
	self assert: cogMethod cmType = CMMethod.
	cogMethod selector: aSelectorOop.
	(cogMethod cmRefersToYoung not
	 and: [objectMemory isYoung: aSelectorOop]) ifTrue:
		[self assert: (methodZone occurrencesInYoungReferrers: cogMethod) = 0.
		 cogMethod cmRefersToYoung: true.
		 methodZone addToYoungReferrers: cogMethod]