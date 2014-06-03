debug support
fullDisplayUpdate
	"Preserve successFlag when call asynchronously from Simulator"
	| s |
	s := primFailCode.
	primFailCode := true.
	super fullDisplayUpdate.
	primFailCode := s