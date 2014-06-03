message sending
executeCoggedNewMethod: inInterpreter methodHeader: aRawMethodHeader

	"Execute newMethod when newMethod has been cogged, 
	in contrast to #activateCoggedNewMethod: we are entering method from its entry point (and so, letting method to invoke own primitive, if any),
	we also don't need to manually setup the method's frame, because method can take care about it by itself"
	
	| cogMethod rcvr |
	<var: #cogMethod type: #'CogMethod *'>

	"save instruction pointer"
	instructionPointer asUnsignedInteger >= objectMemory startOfMemory ifTrue: [
		self iframeSavedIP: framePointer put: instructionPointer asInteger.
		instructionPointer := cogit ceReturnToInterpreterPC].

	cogMethod := self cCoerceSimple: aRawMethodHeader to: #'CogMethod *'.
	rcvr := self stackValue: cogMethod cmNumArgs. "could new rcvr be set at point of send?"
	self push: instructionPointer.
	
	cogit numRegArgs > 0
		ifTrue:
			[cogMethod cmNumArgs <= cogit numRegArgs ifTrue:
				[self enterRegisterArgCogMethod: cogMethod at: cogit noCheckEntryOffset receiver: rcvr]].
	self push: cogMethod asInteger + cogit noCheckEntryOffset.
	self push: rcvr.
	cogit ceEnterCogCodePopReceiverReg.
	self error: 'should not be reached'.
