frame access
markCogMethodsAndReferentsOnPage: thePage
	<var: #thePage type: #'StackPage *'>
	| theFP callerFP |
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<inline: false>
	self assert: (stackPages isFree: thePage) not.
	self assert: (self ifCurrentStackPageHasValidHeadPointers: thePage).
	theFP := thePage headFP.
	"Skip the instruction pointer on top of stack of inactive pages."
	[(self isMachineCodeFrame: theFP) ifTrue:
		[cogit markMethodAndReferents: (self mframeCogMethod: theFP)].
	(callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
		[theFP := callerFP]