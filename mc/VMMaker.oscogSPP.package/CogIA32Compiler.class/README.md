I generate IA32 (x86) instructions from CogAbstractInstructions.  For reference see
1. IA-32 Intel® Architecture Software Developer's Manual Volume 2A: Instruction Set Reference, A-M
2. IA-32 Intel® Architecture Software Developer's Manual Volume 2A: Instruction Set Reference, N-Z
	http://www.intel.com/products/processor/manuals/
(® is supposed to be the Unicode "registered  sign".

This class does not take any special action to flush the instruction cache on instruction-modification, trusting that Intel and AMD processors correctly invalidate the instruction cache via snooping.  According to the manuals, this will work on systems where code and data have the same virtual address.  The CogICacheFlushingIA32Compiler subclass exists to use the CPUID instruction to serialize instruction-modification for systems with code and data at different virtual addresses.