message sending
internalExecuteNewMethod
	| localPrimIndex |
	<inline: true>
	localPrimIndex := primitiveIndex.
	localPrimIndex > 0
		ifTrue: [(localPrimIndex > 255
					and: [localPrimIndex < 520])
				ifTrue: ["Internal return instvars"
					localPrimIndex >= 264
						ifTrue: [^ self internalPop: 1 thenPush: (self fetchPointer: localPrimIndex - 264 ofObject: self internalStackTop)]
						ifFalse: ["Internal return constants"
							localPrimIndex = 256 ifTrue: [^ nil].
							localPrimIndex = 257 ifTrue: [^ self internalPop: 1 thenPush: trueObj].
							localPrimIndex = 258 ifTrue: [^ self internalPop: 1 thenPush: falseObj].
							localPrimIndex = 259 ifTrue: [^ self internalPop: 1 thenPush: nilObj].
							^ self internalPop: 1 thenPush: (self integerObjectOf: localPrimIndex - 261)]]
				ifFalse: [
					self externalizeIPandSP.
					self internalPrimitiveResponse.
					self internalizeIPandSP.
					successFlag
						ifTrue: [self browserPluginReturnIfNeeded.
							^ nil]]].
	"if not primitive, or primitive failed, activate the method"
	self internalActivateNewMethod.
	"check for possible interrupts at each real send"
	self internalQuickCheckForInterrupts