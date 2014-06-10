instance creation
new: aName
	| timer |
	
	timer := super new.
	timer name: aName.
	
	^timer