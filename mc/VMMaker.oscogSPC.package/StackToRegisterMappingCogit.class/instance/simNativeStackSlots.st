simulation stack
simNativeStackSlots
	"Answer the number of slots toinclude in a simulated stack.
	 This needs to be big enough to include all slots in a context
	 plus some overflow for safety."
	<inline: true>
	^((LargeContextSlots - CtxtTempFrameStart max: 64) * 11 // 10)