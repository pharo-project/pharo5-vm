This plugin combines a number of primitives needed by Scratch including:

  a. primitives that manipulate 24-bit color images (i.e. 32-bit deep Forms but alpha is ignored)
  b. primitive to open browsers, find the user's documents folder, set the window title and other host OS functions

This plugin includes new serial port primitives, including support for named serial ports. The underlying plugin code can support up to 32 simultaenously open ports.

Port options for Set/GetOption primitives:
  1. baud rate
  2. data bits
  3. stop bits
  4. parity type
  5. input flow control type
  6. output flow control type

Handshake lines (options 20-25 for Set/GetOption primitives):
  20. DTR	(output line)
  21. RTS	(output line)
  22. CTS	(input line)
  23. DSR	(input line)
  24. CD		(input line)
  25. RI		(input line)

