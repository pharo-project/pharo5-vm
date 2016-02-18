stack access
pushFloat: f
	<returnTypeC: #sqInt>
	<var: #f type: 'double '>
	f isFloat ifFalse:[^self error:'Not a Float'].
	self push: f.