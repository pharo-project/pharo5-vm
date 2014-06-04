I generate ARM instructions from CogAbstractInstructions.  For reference see
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.set.architecture/index.html

The Architecture Reference Manual used is that of version 5, which includes some version 6 instructions. Of those, only pld is used(for PrefetchAw).

This class does not take any special action to flush the instruction cache on instruction-modification.