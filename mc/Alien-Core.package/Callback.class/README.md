Callbacks encapsulate callbacks from the outside world.  They allow Smalltalk blocks to be evaluated and answer their results to external (e.g. C) callees.

Instance Variables:
block <BlockContext> - The Smalltalk code to be run in response to external code invoking the callback.
thunk <FFICallbackThunk> - the wrapper around the machine-code thunk that initiates the callback and whose address should be passed to C
argsProxy <Alien> - the wrapper around the thunk's incomming stack pointer, used to extract arguments from the stack.
resultProxy <FFICalbackReturnValue> - the specification of the block's return value and its C type so that the result can be passed back in the right low-level form.

Class Variables:
ThunkToCallbackMap <Dictionary of: thunkAddress <Integer> -> callback <Callback>> - used to lookup the Callback associated with a specific thunk address on callback.  See FFICallbackThunk.