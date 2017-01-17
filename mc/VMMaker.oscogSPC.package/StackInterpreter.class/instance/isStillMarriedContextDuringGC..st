frame access
isStillMarriedContextDuringGC: aContext
	"Answer if aContext is married or widowed and still married.
	 If a context is widowed then turn it into a single dead context.
	This version is for use during scavenging when stack references may be forwarded.
	 Following what appear to be references to forwarded objects on the stack is dangerous;
	 an instruction ponter may be correctly aligned and may point to bytes that just happen
	 to look like a forwarder. So it is only safe to follow fields that we know are frameContext
	 fields; hence the stack page is walked to check that aOnceMarriedContext is pointing to
	 a live frame.  This only has to happen during scavenging because after a become: all
	 frameContext fields have been followed and so there is no need to follow forwarders."
	^(self isMarriedOrWidowedContext: aContext)
	    and: [(self isWidowedContextDuringGC: aContext) not]