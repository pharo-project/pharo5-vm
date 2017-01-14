trampoline support
genCallMustBeBooleanFor: boolean
	self assert: ((self generatorAt: byte0) numBytes between: 1 and: 2).
	^self CallRT: ((self generatorAt: byte0) numBytes = 1
					ifTrue:
						[boolean = objectMemory falseObject
							ifTrue: [ceSendMustBeBooleanAddFalseTrampoline]
							ifFalse: [ceSendMustBeBooleanAddTrueTrampoline]]
					ifFalse:
						[boolean = objectMemory falseObject
							ifTrue: [ceSendMustBeBooleanAddFalseLongTrampoline]
							ifFalse: [ceSendMustBeBooleanAddTrueLongTrampoline]])