callouts
pointer: aString with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 
	^ self 
		pointer: aString
		withArguments: (Array 
			with: arg1
			with: arg2
			with: arg3
			with: arg4) , (Array 
				with: arg5
				with: arg6)