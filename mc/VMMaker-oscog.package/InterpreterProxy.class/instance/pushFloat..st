stack access
pushFloat: f
	<var: #f type: 'double '>
	f class == Float ifFalse:[^self error:'Not a Float'].
	self push: f.