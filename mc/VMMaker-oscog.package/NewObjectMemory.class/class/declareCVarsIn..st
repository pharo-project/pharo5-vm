translation
declareCVarsIn: aCCodeGenerator
	self declareCAsOop: #(freeStart reserveStart scavengeThreshold)
		in: aCCodeGenerator.
	aCCodeGenerator var: #statGCEndUsecs type: #usqLong