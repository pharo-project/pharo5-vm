AioPlugin provides a primitive interface to asynchronous input/output events. Different
classes are required for various operating system platforms. All implementations are expected
to use the module name "AioPlugin" regardless of their class name. This provides a uniform
primitive interface for asynchronous events on all supported platforms.

Aio events are externally occuring events such as "data is now available on an IO channel"
or "an IO channel is now available for writing". These events occur asynchronously with
respect to the Squeak VM. AioPlugin arranges for event forwarding such that each event
causes a corresponding Smalltalk semaphore to be signalled.

To create an event handler in Squeak, register an external semaphore, establish event
forwarding to the semaphore, and start a Smalltalk process to wait on the semaphore. The
process should loop on the semaphore wait, taking appropriate action when the event is
signalled, and terminating when the event forwarding is disabled.

The supported primitives are:
  primitiveAioEnable - Enable asynchronous notification for a descriptor.
  primitiveAioHandle - Handle asynchronous event notification for a descriptor.
  primitiveAioSuspend - Temporarily suspend asynchronous event notification for a descriptor.
  primitiveAioDisable - Definitively disable asynchronous event notification for a descriptor.
  primitiveOSFileHandle - Answer the handle (Unix file number) for a FileStream.
  primitive OSSocketHandle - Answer the handle (Unix file number) for a Socket.

Currently the Unix VM supports aio event notification, and class UnixAioPlugin provides
the required primitive support.
