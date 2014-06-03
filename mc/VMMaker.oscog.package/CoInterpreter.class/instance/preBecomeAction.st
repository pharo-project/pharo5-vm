object memory support
preBecomeAction
	"Need to set gcMode var (to avoid passing the flag through a lot of the updating code)"
	super preBecomeAction.
	gcMode := GCModeBecome