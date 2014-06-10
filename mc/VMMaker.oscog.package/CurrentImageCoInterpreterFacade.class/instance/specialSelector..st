accessing
specialSelector: index 
	^self oopForObject: (Smalltalk specialSelectors at: index * 2 + 1)