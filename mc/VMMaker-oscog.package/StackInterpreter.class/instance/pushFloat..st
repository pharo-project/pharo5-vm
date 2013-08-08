primitive support
pushFloat: f

	<var: #f type: #double>
	self push: (self floatObjectOf: f).