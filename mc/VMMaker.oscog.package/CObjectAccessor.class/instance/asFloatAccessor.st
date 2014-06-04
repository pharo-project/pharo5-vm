converting
asFloatAccessor

	^ self asPluggableAccessor
		atBlock: [:obj :index | obj floatAt: index]
		atPutBlock: [:obj :index :value | obj floatAt: index put: value]