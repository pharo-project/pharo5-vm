simulation only
selectorForSendBefore: bcpc in: aCompiledMethod
	<doNotGenerate>
	| is sel |
	"sends map to the following pc.  need to find the selector for the previous pc"
	is := InstructionStream on: aCompiledMethod.
	is pc: (aCompiledMethod pcPreviousTo: bcpc + 1). "bcpc is 0-rel"
	^(sel := is selectorToSendOrSelf) ~~ is ifTrue: [sel]