comparing
isFrameTempVar
	"Answer if the receiver is a temporary variable.  This
	 only works in a frameful method, hence the weird name."
	<inline: true>
	^type = SSBaseOffset and: [register = FPReg]