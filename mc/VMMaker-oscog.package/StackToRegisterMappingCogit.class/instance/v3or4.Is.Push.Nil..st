span functions
v3or4: descriptor Is: pc Push: nExts Nil: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	^(self v3: descriptor Is: pc Push: nExts Nil: aMethodObj)
	  or: [self v4: descriptor Is: pc Push: nExts Nil: aMethodObj]