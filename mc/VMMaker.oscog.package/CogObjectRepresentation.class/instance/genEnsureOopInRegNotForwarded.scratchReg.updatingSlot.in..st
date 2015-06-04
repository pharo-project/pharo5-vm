compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch updatingSlot: index in: objReg
	"Make sure that the oop in reg is not forwarded, updating the slot in objReg with the value."
	<inline: true>
	^self genEnsureOopInRegNotForwarded: reg
		scratchReg: scratch
		updatingMw: index * objectMemory wordSize + objectMemory baseHeaderSize
		r: objReg