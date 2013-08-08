accessing
primitivePlatformId
	<export: true>

	"return a platform id code"
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1 thenPush: 
		( interpreterProxy integerObjectOf: PlatformId ).
	
