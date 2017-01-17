process primitive support
deferStackLimitSmashAround: functionSymbol with: arg
	"Defer smashes of the stackLimit around the call of functionSymbol (for assert checks).	

	 N.B. SYNCHRONIZE WITH forceInterruptCheckFromHeartbeat"

	<var: #functionSymbol declareC: 'void (*functionSymbol)(sqInt)'>
	deferSmash := true.
	self sqLowLevelMFence.
	self perform: functionSymbol with: arg.
	deferSmash := false.
	self sqLowLevelMFence.
	deferredSmash ifTrue:
		[deferredSmash := false.
		 self sqLowLevelMFence.
		 self forceInterruptCheck.
		 self checkVMOwnershipFromHeartbeat].
	^true "called from assert"