accessing
allMethodPrototypes 
	^ self class allMethods
		select: [ :each | each category = 'method prototypes' ]