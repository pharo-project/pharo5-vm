frame access
divorceMachineCodeFramesWithMethod: methodObj
	| cogMethod divorcedSome |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := self cogMethodOf: methodObj.
	[stackPage ~= 0 ifTrue: "This is needed for the assert in externalDivorceFrame:andContext:"
		[stackPages markStackPageMostRecentlyUsed: stackPage].
	 "Slang can't currently cope with the lack of the variable here.
	  Something to do with the preceding statement.  Take it out
	  and the code is good.  leave it in and we get do { ... } while(l1:)"
	 divorcedSome := self divorceSomeMachineCodeFramesWithMethod: cogMethod.
	 divorcedSome] whileTrue