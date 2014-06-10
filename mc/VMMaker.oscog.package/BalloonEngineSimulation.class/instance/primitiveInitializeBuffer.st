initialize
primitiveInitializeBuffer

	"Fix an uninitialized variable (should probably go into the real engine too)"
	super primitiveInitializeBuffer.
	self spanEndAAPut: 0.