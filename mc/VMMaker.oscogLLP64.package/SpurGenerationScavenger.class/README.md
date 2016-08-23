SpurGenerationScavenger is an implementation of David Ungar's Generation Scavenging garbage collection algorithm.  See
	Generation Scavenging, A Non-disruptive, High-Performance Storage Reclamation Algorithm
	David Ungar
	Proceeding
	SDE 1 Proceedings of the first ACM SIGSOFT/SIGPLAN software engineering symposium on Practical software development environments
	Pages 157 - 167 
	ACM New York, NY, USA ©1984 

Also relevant are
	An adaptive tenuring policy for generation scavengers
	David Ungar & Frank Jackson
	ACM Transactions on Programming Languages and Systems (TOPLAS) TOPLAS Homepage archive
	Volume 14 Issue 1, Jan. 1992 
	Pages 1 - 27 
	ACM New York, NY, USA ©1992
and
	Ephemerons: a new finalization mechanism
	Barry Hayes
	Proceedings of the 12th ACM SIGPLAN conference on Object-oriented programming, systems, languages, and applications
	Pages 176-183 
	ACM New York, NY, USA ©1997

See text below the variable definitions and explanation below for a full explanation of weak and ephemeron processing.

Instance Variables
	coInterpreter:					<StackInterpreterSimulator|CogVMSimulator>
	eden:							<SpurNewSpaceSpace>
	ephemeronList:					<Integer|nil>
	futureSpace:					<SpurNewSpaceSpace>
	futureSurvivorStart:				<Integer address>
	manager:						<SpurMemoryManager|Spur32BitMMLESimulator et al>
	numRememberedEphemerons:	<Integer>
	pastSpace:						<SpurNewSpaceSpace>
	previousRememberedSetSize:	<Integer>
	rememberedSet:				<CArrayAccessor on: Array>
	rememberedSetSize:			<Integer>
	tenuringProportion:				<Float>
	tenuringThreshold:				<Integer address>
	weakList:						<Integer|nil>

coInterpreter
	- the interpreter/vm, in this context, the mutator

manager
	- the Spur memory manager

eden
	- the space containing newly created objects

futureSpace
	- the space to which surviving objects are copied during a scavenge

futureSurvivorStart
	- the allocation pointer into futureSpace

pastSpace
	- the space surviving objects live in until the next scavenge

rememberedSet
	- the root old space objects that refer to objects in new space; a scavenge starts form these roots and the interpreter's stack

rememberedSetSize
	- the size of the remembered set, also the first unused index in the rememberedSet

previousRememberedSetSize:
	- the size of the remembered set before scavenging objects in future space.

numRememberedEphemerons
	- the number of unscavenged ephemerons at the front of the rememberedSet.

ephemeronList
	- the head of the list of corpses of unscavenged ephemerons reached in the current phase

weakList
	- the head of the list of corpses of weak arrays reached during the scavenge.

tenuringProportion
	- the amount of pastSpace below which the system will not tenure unless futureSpace fills up, and above which it will eagerly tenure

tenuringThreshold
	- the pointer into pastSpace below which objects will be tenured

Weakness and Ephemerality in the Scavenger.
Weak arrays should not hold onto their referents (except from their strong fileds, their named inst vars).  Ephemerons are objects that implement instance-based finalization; attaching an ephemeron to an object keeps that object alive and causes the ephemeron to "fire" when the object is only reachable from the ephemeron (or other ephemerons & weak arrays).  They are a special kind of Associations that detect when their keys are about to die, i.e. when an ephemeron's key is not reachable from the roots except from weak arrays and other ephemerons with about-to-die keys.  Note that if an ephemeron's key is not about to die then references from the rest of the ephemeron can indeed prevent ephemeron keys from dying.

The scavenger is concerned with collecting objects in new space, therefore it ony deals with weak arrays and ephemerons that are either in the remembered set or in new space.  By deferring scanning these objects until other reachable objects have been scavenged, the scavenger can detect dead or dying references.

Weak Array Processing
In the case of weak arrays this is simple.  The scavenger refuses to scavenge the referents of weak arrays in scavengeReferentsOf: until the entire scavenge is over.  It then scans the weak arrays in the remembered set and in future space and nils all fields in them that are referring to unforwarded objects in eden and past space, because these objects have not survived the scavenge.  The root weak arrays remaining to be scavenged are in the remembered table.  Surviving weak arrays in future space are collected on a list.  The list is threaded through the corpses of weak arrays in eden and/or past space.  weakList holds the slot offset of the first weak array found in eden and/or past space.  The next offset is stored in the weak array corpse's identityHash and format fields (22 bits & 5 bits of allocationUnits, for a max new space size of 2^28 bytes, 256Mb).  The list is threaded throguh corpses, but the surviving arrays are pointed to by the corpses' forwarding pointers.

Ephemeron Processing
The case of ephemerons is a little more complicated because an ephemeron's key should survive.  The scavenger is cyclical.  It scavenges the remembered set, which may copy and forward surviving objects in past and/or eden spaces to future space.  It then scavenges those promoted objects in future space until no more are promoted, which may in turn remember more objects.  The cycles continue until no more objects get promoted to future space and no more objects get remembered.  At this point all surviving objecta are in futureSpace.

So if the scavenger does not scan ephemerons in the remembered set or in future space until the scavenger finishes cycling, it can detect ephemerons whose keys are about to die because these will be unforwarded objects in eden and/or past space.  Ephemerons encountered in the remembered set are either processed like ordinary objects if their keys have been promoted to futureSpace, or are moved to the front of the rememberedSet (because, dear reader, it is a sequence) if their keys have not been promoted.  Ephemerons encountered in scavengeReferentsOf: are either scanned like normal objects if their keys have been promoted, or added to the ephemeronList, organized identically to the weakList, if their keys are yet to be promoted.  Since references from other ephemerons with surviving keys to ephemeron keys can and should prevent the ephemerons whose keys they are from firing the scavenger does not fire ephemerons unless all unscavenged ephemerons have unscavenged keys.  So the unscavenged ephemerons (the will be at the beginning of the remembered set and on the ephemeronList) are scanned and any that have promoted keys are scavenged.  But if no unscavenged ephemerons have surviving keys then all the unscavenged ephemerons are fired and then scavenged.  This in turn may remember more objects and promote more objects to future space, and encounter more unscavenged ephemerons.  So the scavenger continues until no more objects are remembered, no more objects are promoted to future space and no more unscavenged ephemerons exist.