simulation stack
ssNativeValue: n
	<returnTypeC: #'CogSimStackNativeEntry *'>
	<option: #LowcodeVM>
	^self simNativeStackAt: simStackPtr - n