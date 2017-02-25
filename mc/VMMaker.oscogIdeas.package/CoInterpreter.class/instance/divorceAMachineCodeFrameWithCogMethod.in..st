frame access
divorceAMachineCodeFrameWithCogMethod: cogMethod in: aStackPage
	"Divorce at most one frame in the current page (since the divorce may cause the page to be split)
	 and answer whether a frame was divorced."
	<var: #cogMethod type: #'CogMethod *'>
	<var: #aStackPage type: #'StackPage *'>
	| theFP calleeFP theSP theContext |
	<var: #aStackPage type: #'StackPage *'>
	<var: #theFP type: #'char *'>
	<var: #calleeFP type: #'char *'>
	<var: #theSP type: #'char *'>

	theFP := aStackPage headFP.
	theSP := aStackPage headSP.
	theSP := theSP + objectMemory wordSize. "theSP points at hottest item on frame's stack"

	[((self isMachineCodeFrame: theFP)
	  and: [cogMethod = (self mframeHomeMethod: theFP)]) ifTrue:
		[theContext := self ensureFrameIsMarried: theFP SP: theSP.
		 self externalDivorceFrame: theFP andContext: theContext.
		 ^true].
	 calleeFP := theFP.
	 theFP := self frameCallerFP: theFP.
	 theFP ~= 0] whileTrue:
		["theSP points at stacked hottest item on frame's stack"
		 theSP := self frameCallerSP: calleeFP].

	^false