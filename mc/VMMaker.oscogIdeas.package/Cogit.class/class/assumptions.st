documentation
assumptions
	"Byte architecture; no 9-bit bit bytes etc.

	 Stacks grow down.  No support for HPPA.

	 No delay slots.  No support for SPARC.

	 Relative jumps.

	 All long conditional branches are of the same size.

	 All long unconditional branches are of the same size.

	 All MoveCwRs are of the same size.

	 A long jump and a call have the same displacement layout so both can be labelled with IsRelativeCall.

	 A PushCw and a MoveCwR have the same constant layout so both can be labelled with IsObjectReference or IsMethodReference.

	 64k of code per method more than enough"