span functions
v4: descriptor Num: pc Push: nExts Nils: aMethodObj
	"*	77			01001101		Push false [* 1:true, 2:nil, 3:thisContext, ..., -N: pushExplicitOuter: N, N = Extend B]"
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	^(descriptor generator == #genExtPushPseudoVariableOrOuterBytecode
	   and: [self assert: (objectMemory fetchByte: pc ofObject: aMethodObj) = 77.
			nExts = 1
	   and: [(objectMemory fetchByte: pc - 1 ofObject: aMethodObj) = 2]])
		ifTrue: [1]
		ifFalse: [0]