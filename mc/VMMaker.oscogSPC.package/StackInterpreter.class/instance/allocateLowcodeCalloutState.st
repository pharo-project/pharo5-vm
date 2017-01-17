inline primitive ffi abi
allocateLowcodeCalloutState
	<option: #LowcodeVM>
	| calloutStateSize |
	calloutStateSize := self sizeof: #'sqLowcodeCalloutState'.
	shadowCallStackPointer := self cCoerce: ((self cCoerce: shadowCallStackPointer - calloutStateSize to: 'size_t') bitAnd: -16) to: 'char*'.
	lowcodeCalloutState := self cCoerce: shadowCallStackPointer to: #'sqLowcodeCalloutState*'.
	