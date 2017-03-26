simulation stack
ssNativeTop
	<option: #LowcodeVM>
	<inline: true>
	<returnTypeC: #'CogSimStackNativeEntry *'>
	self assert: simNativeStackPtr >= 0.
	^self simNativeStackAt: simNativeStackPtr