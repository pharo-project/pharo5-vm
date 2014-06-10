I am an abstract superclass for constraints having two possible output variables.

Instance variables:
	v1, v2		possible output variables <Variable>
	direction		one of:
					#forward (v2 is output)
					#backward (	v1 is output)
					nil (not satisfied)