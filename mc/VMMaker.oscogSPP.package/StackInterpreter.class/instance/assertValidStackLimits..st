process primitive support
assertValidStackLimits: ln
	<returnTypeC: #void>
	"Order in the stackLimit checks is important because stackLimit is smashed by
	 interrupts. So always check for unsmashed value first to avoid race condition."
	self assert: (stackLimit = stackPage realStackLimit
				or: [stackLimit = self allOnesAsCharStar])
		l: ln.
	self assert: (stackPage stackLimit = stackPage realStackLimit
				or: [stackPage stackLimit = self allOnesAsCharStar])
		l: ln