My instances automate the translation of a Squeak interpreter for use with GCC.  In the specified FileDirectory, I copy 'interp.c' to 'interp.c.old'; translate a gnuified interpreter back into 'interp.c'; and save a working copy of sqGnu.h.

To gnuify an interpreter, try something like one of the following:

	(Gnuifier on: 
		((FileDirectory default 
			directoryNamed: 'src') 
				directoryNamed: 'vm') pathName) gnuify

	(Gnuifier on: 
		'powercow X:Users:werdna:Desktop:squeak:Squeak3.2a-4599 Folder:src:vm') gnuify


Structure:
 directory		FileDirectory -- specifying where I should do my gnuification

I can attempt to undo my damage with #deGnuify.