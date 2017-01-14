A CogRASSBytecodeFixup extends CogSSBytecodeFixup with state to merge the stack at control-flow joins, preserving register contents.  By holding onto the entire stack state a CogRASSBytecodeFixup allows RegisterAllocatingCogit to merge individual stack entries, instead of merely spilling to the same height.

Instance Variables
	cogit:					<RegisterAllocatingCogit>
	mergeSimStack:		<Array of: CogRegisterAllocatingSimStackEntry>

cogit
	- the JIT compiler

mergeSimStack
	- the state of the stack at the jump to this fixup