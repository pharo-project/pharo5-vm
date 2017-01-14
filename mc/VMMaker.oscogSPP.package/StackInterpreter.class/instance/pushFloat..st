primitive support
pushFloat: f

	<var: #f type: #double>
	self push: (objectMemory floatObjectOf: f).