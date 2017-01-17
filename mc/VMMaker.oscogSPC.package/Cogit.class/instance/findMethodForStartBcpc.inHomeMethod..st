method map
findMethodForStartBcpc: startbcpc inHomeMethod: cogMethod
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	<returnTypeC: #'CogBlockMethod *'>
	"Find the CMMethod or CMBlock that has zero-relative startbcpc as its first bytecode pc.
	 As this is for cannot resume processing and/or conversion to machine-code on backward
	 branch, it doesn't have to be fast.  Enumerate block returns and map to bytecode pcs."
	self assert: cogMethod cmType = CMMethod.
	startbcpc = (coInterpreter startPCOfMethodHeader: cogMethod methodHeader) ifTrue:
		[^self cCoerceSimple: cogMethod to: #'CogBlockMethod *'].
	self assert: cogMethod blockEntryOffset ~= 0.
	^self cCoerceSimple: (self blockDispatchTargetsFor: cogMethod
								perform: #findBlockMethodWithEntry:startBcpc:
								arg: startbcpc)
		to: #'CogBlockMethod *'