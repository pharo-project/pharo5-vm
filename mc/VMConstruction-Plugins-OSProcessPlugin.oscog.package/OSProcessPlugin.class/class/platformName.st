version dependent
platformName 
	"After Squeak version 3.6, #platformName was moved to SmalltalkImage "

	^ ((Smalltalk classNamed: 'SmalltalkImage')
		ifNil: [^ Smalltalk platformName]) current platformName