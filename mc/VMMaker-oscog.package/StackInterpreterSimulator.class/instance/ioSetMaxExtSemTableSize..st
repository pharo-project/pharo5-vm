process primitive support
ioSetMaxExtSemTableSize: anInteger
	"Inform the VM of the maximum size the image will grow the exernal semaphore table (specialObjectsArray at: 39) to.
	 This allows the VM to allocate storage such that external semaphores can be signalled without locking."
	extSemTabSize := anInteger