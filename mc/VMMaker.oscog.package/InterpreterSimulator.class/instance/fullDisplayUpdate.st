debug support
fullDisplayUpdate
	"Preserve successFlag when call asynchronously from Simulator"
	| s |
	s := successFlag.
	successFlag := true.
	super fullDisplayUpdate.
	successFlag := s