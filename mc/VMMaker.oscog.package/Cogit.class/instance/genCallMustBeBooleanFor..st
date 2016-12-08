trampoline support
genCallMustBeBooleanFor: boolean
	^self CallRT: (boolean = objectMemory falseObject
					ifTrue: [ceSendMustBeBooleanAddFalseTrampoline]
					ifFalse: [ceSendMustBeBooleanAddTrueTrampoline])