inline primitive ffi abi
reloadLowcodeStateAfterCallout
	<option: #LowcodeVM>
	<var: #initialShadowCallStackPointer type: #'char*' >
	
	| calloutStateSize initialShadowCallStackPointer |
	calloutStateSize := self sizeof: #'sqLowcodeCalloutState'.
	initialShadowCallStackPointer := (self shadowCallStackPointerIn: localFP) - 1.
	
	initialShadowCallStackPointer := self cCoerce: ((self cCoerce: initialShadowCallStackPointer - calloutStateSize to: 'size_t') bitAnd: -16) to: 'char*'.
	lowcodeCalloutState := self cCoerce: initialShadowCallStackPointer to: #'sqLowcodeCalloutState*'.