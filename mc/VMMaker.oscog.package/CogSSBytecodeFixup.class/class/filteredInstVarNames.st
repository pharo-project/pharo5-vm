translation
filteredInstVarNames
	"Override to add ifdef LowcodeVM around the native stack info.
	 self typedef"
	^super filteredInstVarNames
		copyReplaceAll: #('simNativeStackPtr' 'simNativeStackSize')
		with: #('#if LowcodeVM' 'simNativeStackPtr' 'simNativeStackSize' '#endif')