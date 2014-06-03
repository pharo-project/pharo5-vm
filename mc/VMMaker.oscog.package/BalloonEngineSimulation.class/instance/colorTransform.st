simulation
colorTransform
	^super colorTransform asPluggableAccessor:
		(Array 
			with:[:obj :index| obj floatAt: index]
			with:[:obj :index :value| obj floatAt: index put: value])