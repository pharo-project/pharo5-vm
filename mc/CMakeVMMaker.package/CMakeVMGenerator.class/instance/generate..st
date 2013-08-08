code generation
generate: aConfigOrClass
	
	config := aConfigOrClass isBehavior ifTrue: [ aConfigOrClass new ] ifFalse: [aConfigOrClass].
	^ self generate