accessing
constantNumbericValueOrNil
	(#(* // + -) includes: selector) ifTrue:
		[receiver constantNumbericValueOrNil ifNotNil:
			[:rval|
			arguments first constantNumbericValueOrNil ifNotNil:
				[:aval|
				^rval perform: selector with: aval]]].
	^nil