debug support
fullDisplayUpdate
	"Preserve self successful when call asynchronously from Simulator"
	| primFailCodeValue |
	primFailCodeValue := primFailCode.
	self initPrimCall.
	super fullDisplayUpdate.
	primFailCode := primFailCodeValue