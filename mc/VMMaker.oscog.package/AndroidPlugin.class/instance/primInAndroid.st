system primitives
primInAndroid
	"return true if running in Android. outside Android this primitive fails"

	<export: true>
	interpreterProxy pop: 1; pushBool: true.