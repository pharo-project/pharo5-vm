process primitive support
setOwnerIndexOfProcess: aProcess to: anIndex bind: bind
	| threadId |
	threadId := anIndex = 0
				ifTrue: [objectMemory nilObject]
				ifFalse: [objectMemory integerObjectOf: (anIndex << 1) + (bind ifTrue: [1] ifFalse: [0])].
	objectMemory storePointerUnchecked: ThreadIdIndex ofObject: aProcess withValue: threadId