Implement the serial port primitives.  Since it requires platform support it will only be built when supported on your platform.

IMPORTANT: So far, we are converting everytime a string into a char* and then we look for it in the ports array. That can be optimized a lot by just answering the external handler (the position in the array perhaps) after open and using it instead the name.
Also, using open by id functions doesn't help because internally they are also converted into a char* (using sprintf).

If needed, that can be optimized then. 