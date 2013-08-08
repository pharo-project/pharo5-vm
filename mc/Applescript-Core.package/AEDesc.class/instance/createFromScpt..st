private
createFromScpt: aCompiledApplescriptData

	(aCompiledApplescriptData class = CompiledApplescript) ifFalse:
		[^self error: 'textType Data Not From CompiledApplescriptData'].
	(self 
		primAECreateDesc: (DescType of: 'scpt')
		from: aCompiledApplescriptData) isZero ifTrue: [^self].
	self error: 'failed to create aeDesc'.
	^nil