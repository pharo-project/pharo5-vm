contexts
argumentCountOfBlock: blockPointer

	| localArgCount |
	localArgCount := self fetchPointer: BlockArgumentCountIndex ofObject: blockPointer.
	^self checkedIntegerValueOf: localArgCount