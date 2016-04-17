bytecode generators
genBlockReturn
	"Return from block, assuming result already loaded into ReceiverResultReg."
	super genBlockReturn.
	deadCode := true. "can't fall through"
	^0