span functions
isPushNil: descriptor pc: pc nExts: nExts method: aMethodObj
	<inline: true>
	<var: #descriptor type: #'BytecodeDescriptor *'>
	^self perform: numPushNilsFunction
		with: descriptor
		with: pc
		with: nExts
		with: aMethodObj