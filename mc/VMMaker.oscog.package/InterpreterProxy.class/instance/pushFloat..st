stack access
pushFloat: f
	<var: #f type: 'double '>
	f isFloat ifFalse:[^self error:'Not a Float'].
	self push: f.