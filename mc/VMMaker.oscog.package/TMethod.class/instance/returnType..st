accessing
returnType: aString
	"Set the type of the values returned by this method.
	 This string will be used in the C declaration of this function.
	 If the type exists as a symbol, use that."

	returnType := (Symbol findInterned: aString) ifNil: [aString]