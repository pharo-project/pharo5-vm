stack bytecodes
pushFloat: f

	<var: #f type: 'double '>
	self push: (self floatObjectOf: f).