span functions
v3: descriptor Num: pc Push: nExts Nils: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	^descriptor generator == #genPushConstantNilBytecode
		ifTrue: [1]
		ifFalse: [0]