instance creation
newFrom: desc
	desc class == self ifTrue: [^ desc].
	^ (super newFrom: desc) setPadding: desc padding