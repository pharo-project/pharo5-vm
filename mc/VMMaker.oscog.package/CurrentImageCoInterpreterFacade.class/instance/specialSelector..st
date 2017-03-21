accessing
specialSelector: index 
	^self oopForObject: (self specialSelectors at: index * 2 + 1)