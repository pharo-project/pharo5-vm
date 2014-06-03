frame access
convertToMachineCodeFrame: cogHomeMethod bcpc: bcpc
	"(minBackwardJumpCountForCompile ~= MinBackwardJumpCountForCompile
	 and: [(self stringOf: (self penultimateLiteralOf: cogHomeMethod methodObject)) = #repeat]) ifTrue:
		[self printExternalHeadFrame.
		self print: bcpc; cr.
		self halt]."
	^super convertToMachineCodeFrame: cogHomeMethod bcpc: bcpc