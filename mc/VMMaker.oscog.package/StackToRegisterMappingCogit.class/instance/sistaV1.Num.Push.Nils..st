span functions
sistaV1: descriptor Num: pc Push: nExts Nils: aMethodObj
	"230		11100110	iiiiiiii		PushNClosureTemps iiiiiiii"
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	^descriptor generator == #genPushClosureTempsBytecode
		ifTrue: [objectMemory fetchByte: pc + 1 ofObject: aMethodObj]
		ifFalse: [0]