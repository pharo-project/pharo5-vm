version dependent
getSystemAttribute: attributeID 
	"After Squeak version 3.6, #getSystemAttribute was moved to SmalltalkImage "

	^ ((Smalltalk classNamed: 'SmalltalkImage')
		ifNil: [^ Smalltalk getSystemAttribute: attributeID]) current getSystemAttribute: attributeID