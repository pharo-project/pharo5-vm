process primitive support
deferStackLimitSmashAround: functionSymbol
	"Defer smashes of the stackLimit around the call of functionSymbol (for assert checks).	

	 N.B. SYNCHRONIZE WITH forceInterruptCheckFromHeartbeat"

	<var: #functionSymbol declareC: 'void (*functionSymbol)(void)'>
	deferSmash := true.
	self perform: functionSymbol.
	deferSmash := false.
	deferredSmash ifTrue:
		[deferredSmash := false.
		 self forceInterruptCheck.
		 self checkVMOwnershipFromHeartbeat].
	^true "called from assert"