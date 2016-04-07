converting
asUnsignedIntAccessor

	^ self asPluggableAccessor
		atBlock: [:obj :index | obj unsignedIntAt: index]
		atPutBlock: [:obj :index :value | obj unsignedIntAt: index put: value]