tests
structureOfACogMethod
	"A CogMethod is the machine code for executable code in the Cog VM, and in the simulator these are
	 instances of CogMethod.  In actuality they are structures in memory in the CogMethodZone..  There
	 are four real kinds, defined by the cmType field, free space: CMFree, methods: CMMethod, closed
	 PICs: CMClosedPIC (finite polymorphic inline caches with up to 6 entries), and open PICs: CMOpenPIC
	 (infinite megamorphicinline caches that probe the first-level method lookup cache).  There is a fifth
	 kind of method, which is merely a header, for blocks: CMBlock, one which exists only within CMMethods,
	 and exist only to allow block activations to refer to something that looks like a CogMethod.

	 The blockSize field in a CogMethod is the size in bytes of the entire method, including the header.
	 Methods are aligned to an 8 byte boundary in the CogMethodZone.  The size is used to iterate over
	 the methods in the zone.

	 Follwing the header is the abort and entry code.  Starting immediately after the header is the call to
	 the abort routine called when either a send fails or a stack limit check fails.  Following that is the
	 checked entry point that checks the receiver is of the right class, and this code ends in the unchecked
	 entry point.  Following this is either primitive code, followed by frame building code, or frame-building
	 code, or, for frameless methods, the code for the frameless method.  Following that is the code for the
	 method.  If the method contains blocks  then followng the method code will be a CMBlock header,
	 followed by code for the block, for each block, and following this will be the block dispatch code,
	 which is indexed by the blockEntryOffset field in the CogMethod.

	 Following either the return in the method, or the block dispatch, is the method map, the meta data which
	 identifies interesting points in the machine code.  The map starts at the end of the structure and is read
	 backwards towards the last instruftion of the method, and is terminated by a null byte.  So the blockSize
	 is used to find the start of the map.  The map reveals where object references, sends and pc-mapping
	 points exist in the machine code.  The map is parsed when garbage collecting to find and update object
	 references, and when unlinking sends for method cache flushing, and to convert between bytecode and
	 machine code pcs by scanning both bytecode and machine code looking for matching points in the map."