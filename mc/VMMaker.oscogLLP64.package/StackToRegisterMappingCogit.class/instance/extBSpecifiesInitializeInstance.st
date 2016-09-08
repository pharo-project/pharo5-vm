testing
extBSpecifiesInitializeInstance
	"This is a negative; do not intialize if 1 is present in extB.  This is also the no-store-check bit."
	<inline: true>
	^ extB noMask: 1