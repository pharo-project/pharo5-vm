I interpret only the long-form bytecodes, making room for lots of additional bytecodes.



Misc notes:
 I do not need to reimplement booleanCheat: to only check for long jumps since it only gets called by the inlined arithmetic primitives which I don't implement.