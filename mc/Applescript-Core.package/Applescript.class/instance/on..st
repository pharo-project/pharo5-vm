private
on: aString

	^self on: aString mode: 2 onErrorDo: 
		[ApplescriptError 
			syntaxErrorFor: aString 
			withComponent: ApplescriptGeneric]