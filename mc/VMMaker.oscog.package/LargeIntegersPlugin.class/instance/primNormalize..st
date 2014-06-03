development primitives
primNormalize: anInteger 
"Parameter specification #(Integer) doesn't convert!"
	self debugCode: [self msg: 'primNormalize: anInteger'].
	self
		primitive: 'primNormalize'
		parameters: #(Integer )
		receiver: #Oop.
	(interpreterProxy isIntegerObject: anInteger)
		ifTrue: [^ anInteger].
	^ self normalize: anInteger