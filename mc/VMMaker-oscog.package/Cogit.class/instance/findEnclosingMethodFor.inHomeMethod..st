method map
findEnclosingMethodFor: mcpc inHomeMethod: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	<returnTypeC: #'CogBlockMethod *'>
	<api>
	"Find the CMMethod or CMBlock that encloses mcpc.
	 If the method contains blocks then, because block dispatch is not in order,
	 enumerate the block dispatch and find the nearest preceeding entry."
	self assert: cogMethod cmType = CMMethod.
	cogMethod blockEntryOffset = 0 ifTrue:
		[^self cCoerceSimple: cogMethod to: #'CogBlockMethod *'].
	maxMethodBefore := self cCoerceSimple: cogMethod to: #'CogBlockMethod *'.
	self blockDispatchTargetsFor: cogMethod perform: #findMinAndMaxMethodsPC:around: arg: mcpc.
	^maxMethodBefore