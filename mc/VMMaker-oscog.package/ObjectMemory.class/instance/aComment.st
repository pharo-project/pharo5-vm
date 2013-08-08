gc -- mark and sweep
aComment
	"The mark phase is based on a pointer reversing traversal. This is a little tricky because the class, which is needed by the traversal, may be in either the header (as a compact class index) or in the word above the header. See memo 'Revised object format'.
	Compact classes are marked and traced separately.
	How do you know that you are returning from having marked a class? Parent pointer has 10 in low bits.

Here are the states an object may be in, followed by what to do next in brackets []:

  Start Object: parentField is set, [obj := child]:
	obj is pointed at by a field in parent that is being traced now. obj is marked.
		[(parent goes up to the next field) field addr := obj. go to Upward]
	obj is pointed at by a field in parent that is being traced now. obj is unmarked. obj has no pointers.
		[put 10 into low bits of header. field addr := obj. go to Start Field (to process class word)]
	obj is pointed at by a field in parent that is being traced now. obj is unmarked. obj has pointers.
		[put 10 into low bits of header. point to last field. go to Start Field]

  Start Field: 
	Field ends in 10. It is the header. Short Class is not 0.
		[Set low bits to correct value. (have parent pointer) go to Upward]
	Field ends in 10. It is the header. Short Class is 0.
		[child := word above header. low bits of child := 01. class word := parentField. parentField := loc of class word. go to Start Obj]
	Field is Integer.
		[point one word up, go to Start Field]
	Field is oop.
		[child := field. field := parentField. parentField := loc of field. go to Start Obj]

  Upward [restore low bits of header (at field addr)]:
	parentField is 3. (bits 11, int 1).
		[done!]
	parentField ends in 00.
		[child := field addr. field addr := parentField. parentField := field addr contents.
		field addr contents := child (addr of prev object. its oop). field addr - 4. go to Start Field]
	parentField ends in 01. We're tracing the class.
		[child := field addr. field addr := parentField (loc of class word). parentField := field addr contents.
		field addr contents := child (addr of prev object. its oop). field addr + 4 (header). go to Upward]
"