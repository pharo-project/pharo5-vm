documentation
cogToBytecodeMethodMapping
	"When first written the VM maintained a one-to-one mapping between bytecoded methods and cog methods.
	The map is implemented with a direct reference form the methodObject field of a CogMethod to the bytecoded
	method and by setting the header word of the bytecoded method to the CogMethod.  Newspeak forced a change
	in this since Newspeak shares anonymous (nil methodClassAssociation) accessors (setters and getters) amongst
	classes and mixins throughout the system (i.e. these accessors are in dictionaries under selector keys that don't
	match the accessor methods' selectors).  But the inline cacheing relinking/un;linking machinery depends on
	CogMethods having the correct selector, since to unlink/relink the selector is fetched from the inline cache's
	target method.  So the VM has been modified to not insist on a one-to-one mapping.  Instead, when a bytecoded
	method is to be used with a different selector it is attached to the new CogMethod.

	This choice means that CogMethods do refer to a valid bytecoded method, but the bytecoded method might
	not necessarily refer back to a CogMethod referring to it.  So when CogMethods are freed care must be taken
	to reset the bytecoded method's header if it is referring to the freed CogMethod."