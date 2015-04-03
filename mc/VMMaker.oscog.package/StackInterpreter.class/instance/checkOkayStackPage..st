debug support
checkOkayStackPage: thePage
	| theSP theFP ok frameRcvrOffset callerFP oop |
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #frameRcvrOffset type: #'char *'>
	<var: #callerFP type: #'char *'>
	<inline: false>
	theSP := thePage headSP.
	theFP := thePage  headFP.
	ok := true.
	"Skip the instruction pointer on top of stack of inactive pages."
	thePage = stackPage ifFalse:
		[theSP := theSP + objectMemory wordSize].
	[frameRcvrOffset := self frameReceiverLocation: theFP.
	 [theSP <= frameRcvrOffset] whileTrue:
		[oop := stackPages longAt: theSP.
		 (objectMemory isIntegerObject: oop) ifFalse:
			[ok := ok & (self checkOkayFields: oop)].
		 theSP := theSP + objectMemory wordSize].
	(self frameHasContext: theFP) ifTrue:
		[self assert: (objectMemory isContext: (self frameContext: theFP)).
		 ok := ok & (self checkOkayFields: (self frameContext: theFP))].
	ok := ok & (self checkOkayFields: (self frameMethodObject: theFP)).
	(callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
		[theSP := theFP + FoxCallerSavedIP + objectMemory wordSize.
		 theFP := callerFP].
	theSP := self isCog
				ifTrue: [theFP + FoxCallerSavedIP + objectMemory wordSize] "caller ip is ceBaseReturnPC"
				ifFalse: [theFP + FoxCallerSavedIP]. "caller ip is frameCallerContext in a base frame"
	[theSP <= thePage baseAddress] whileTrue:
		[oop := stackPages longAt: theSP.
		 (objectMemory isIntegerObject: oop) ifFalse:
			[ok := ok & (self checkOkayFields: oop)].
		 theSP := theSP + objectMemory wordSize].
	^ok