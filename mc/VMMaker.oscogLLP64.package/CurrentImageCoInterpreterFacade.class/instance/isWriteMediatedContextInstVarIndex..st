frame access
isWriteMediatedContextInstVarIndex: index
	"Writing any inst vars of a context must take account of potentially married contexts
	 and set the state in the frame. Inst vars in subclasses don't need mediation; subclasses
	 can't marry."
	^index <= ReceiverIndex