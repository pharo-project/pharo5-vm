converting
asIntAccessor

	^ self asPluggableAccessor
		atBlock: [:obj :index | obj intAt: index]
		atPutBlock: [:obj :index :value | obj intAt: index put: value]