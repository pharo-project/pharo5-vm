callouts
int: aString with: arg1 with: arg2 with: arg3 with: arg4 
	^ self 
		int: aString
		withArguments: (Array 
				with: arg1
				with: arg2
				with: arg3
				with: arg4)