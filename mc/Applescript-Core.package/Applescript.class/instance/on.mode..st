private
on: aString mode: anInteger

	^self on: aString mode: anInteger onErrorDo: 
		[ApplescriptError 
			syntaxErrorFor: aString 
			withComponent: ApplescriptGeneric]