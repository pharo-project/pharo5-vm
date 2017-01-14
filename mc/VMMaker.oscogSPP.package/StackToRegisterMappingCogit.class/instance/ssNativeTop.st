simulation stack
ssNativeTop
	<option: #LowcodeVM>
	<returnTypeC: #'CogSimStackNativeEntry *'>
	self assert: simNativeStackPtr >= 0.
	^self simNativeStackAt: simNativeStackPtr