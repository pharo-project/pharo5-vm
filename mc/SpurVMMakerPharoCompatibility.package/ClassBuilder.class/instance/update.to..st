class mutation
update: oldClass to: newClass
	"Convert oldClass, all its instances and possibly its meta class into newClass, instances of newClass and possibly its meta class. The process is surprisingly simple in its implementation and surprisingly complex in its nuances and potentially bad side effects. 
	We can rely on two assumptions (which are critical):
		#1: The method #updateInstancesFrom: will not create any lasting pointers to 'old' instances ('old' is quote on quote since #updateInstancesFrom: will do a become of the old vs. the new instances and therefore it will not create pointers to *new* instances before the #become: which are *old* afterwards)
		#2: The non-preemptive execution of the critical piece of code guarantees that nobody can get a hold by 'other means' (such as process interruption and reflection) on the old instances.
	Given the above two, we know that after #updateInstancesFrom: there are no pointer to any old instances. After the forwarding become there will be no pointers to the old class or meta class either. Meaning that if we throw in a nice fat GC at the end of the critical block, everything will be gone (but see the comment right there). There's no need to worry.
	"
	| meta |
	meta := oldClass isMeta.
	"Note: Everything from here on will run without the ability to get interrupted
	to prevent any other process to create new instances of the old class."
	[
		"Note: The following removal may look somewhat obscure and needs an explanation. When we mutate the class hierarchy we create new classes for any existing subclass. So it may look as if we don't have to remove the old class from its superclass. However, at the top of the hierarchy (the first class we reshape) that superclass itself is not newly created so therefore it will hold both the oldClass and newClass in its (obsolete or not) subclasses. Since the #become: below will transparently replace the pointers to oldClass with newClass the superclass would have newClass in its subclasses TWICE. With rather unclear effects if we consider that we may convert the meta-class hierarchy itself (which is derived from the non-meta class hierarchy).
		Due to this problem ALL classes are removed from their superclass just prior to converting them. Here, breaking the superclass/subclass invariant really doesn't matter since we will effectively remove the oldClass (become+GC) just a few lines below."

		oldClass superclass removeSubclass: oldClass.
		oldClass superclass removeObsoleteSubclass: oldClass.

		"make sure that the VM cache is clean"
		oldClass selectorsDo: [:aSelector | aSelector flushCache].
		
		"Convert the instances of oldClass into instances of newClass"
		newClass updateInstancesFrom: oldClass.

		meta
			ifTrue:[oldClass becomeForward: newClass]
			ifFalse:[(Array with: oldClass with: oldClass class)
						elementsForwardIdentityTo:
							(Array with: newClass with: newClass class)].

		Smalltalk garbageCollect.

		"Warning: Read this before you even think about removing the GC. Yes, it slows us down. Quite heavily if you have a large image. However, there's no good and simple alternative here, since unfortunately, #become: does change class pointers. What happens is that after the above become all of the instances of the old class will have a class pointer identifying them as instances of newClass. If we get our hands on any of these instances we will break immediately since their expected instance layout (that of its class, e.g., newClass) will not match their actual instance layout (that of oldClass). And getting your hands on any of those instances is really simple - just reshaping one class two times in rapid succession will do it. Reflection techniques, interrupts, etc. will only add to this problem. In the case of Metaclass things get even worse since when we recompile the entire class hierarchy we will recompile both, Metaclass and its instances (and some of its instances will have the old and some the new layout).

		The only easy solution to this problem would be to 'fix up' the class pointers of the old instances to point to the old class (using primitiveChangeClassTo:). But this won't work either - as we do a one-way become we would have to search the entire object memory for the oldClass and couldn't even clearly identify it unless we give it some 'special token' which sounds quite error-prone. If you really need to get rid of the GC here are some alternatives:

		On the image level, one could create a copy of the oldClass before becoming it into the new class and, after becoming it, 'fix up' the old instances. That would certainly work but it sounds quite complex, as we need to make sure we're not breaking any of the superclass/subclass meta/non-meta class variants.

		Alternatively, fix up #becomeForward on the VM-level to 'dump the source objects' of #become. This would be quite doable (just 'convert' them into a well known special class such as bitmap) yet it has problems if (accidentally or not) one of the objects in #become: appears on 'both sides of the fence' (right now, this will work ... in a way ... even though the consequences are unclear).

		Another alternative is to provide a dedicated primitive for this (instead of using it implicitly in become) which would allow us to dump all the existing instances right here. This is equivalent to a more general primitiveChangeClassTo: and might be worthwhile but it would likely have to keep in mind the differences between bits and pointer thingies etc.

		Since all of the alternatives seem rather complex and magical compared to a straight-forward GC it seems best to stick with the GC solution for now. If someone has a real need to fix this problem, that person will likely be motivated enough to check out the alternatives. Personally I'd probably go for #1 (copy the old class and remap the instances to it) since it's a solution that could be easily reverted from within the image if there's any problem with it."

	] valueUnpreemptively.
