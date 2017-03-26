simulation stack
ssNativeValue: n
	<returnTypeC: #'CogSimStackNativeEntry *'>
	<option: #LowcodeVM>
	^self simNativeStackAt: simNativeStackPtr - n