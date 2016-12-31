initialize-release
socketInit
	openSocketHandles := Set new.
	externalSemaphores := Set new.
	hostSocketToSimSocketMap := Dictionary new.
	simSocketToHostSocketMap := Dictionary new.
	fakeAddressCounter := 16r50C4E70. "Socket, if you squint at it right..."
	"Set all the security functions to zero so simulation does't need to work fully."
	sDSAfn := sHSAfn := sCCTPfn := sCCLOPfn := sCCSOTfn := 0.
	"for now..."
	ipv6support := false.
	^true