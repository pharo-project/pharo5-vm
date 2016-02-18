accessing
packageForMissingClassNamed: className
	(className = #BoxedFloat64
	 or: [className = #SmallFloat64]) ifTrue:
		[^PackageInfo named: 'Kernel'].
	self error: 'unknown missing class'