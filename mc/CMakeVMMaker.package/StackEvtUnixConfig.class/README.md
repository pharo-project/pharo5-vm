This is a concrete class which generates an event-driven StackVM for Unix.

Usage: 
StackEvtUnixConfig generateWithSources

An event-driven Stack VM is an experiment to make VM return to the host process each time it asks for an event.
If there are events to process, the host resumes VM, otherwise VM does not get control until any event is available.

Fore more information, check the class comments of all the superclasses.
