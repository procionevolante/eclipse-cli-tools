Eclipse / NXP's S32 Design Studio / S32DS console tools
=======================================================

This repo contains various tools I developed while being forced to work with
NXP's [S32 Design Studio][1], a modded version of [Eclipse CDT][2].

I would personally like if all companies stop forcing devs to use their own
shitty IDEs and let them use whatever they want.

This repo is the result of my work towards the goal of minimising the use of
that buggy IDE and relying on using more mature and tested programs.

[1]: https://www.nxp.com/design/design-center/software/automotive-software-and-tools/s32-design-studio-ide:S32-DESIGN-STUDIO-IDE "NXP S32 Design Studio"
[2]: https://projects.eclipse.org/projects/tools.cdt "Eclipse CDT"

eclipsecc
---------

S32DS always generates its own makefiles on the fly and doesn't let you use
them.

To solve this issue the only strategy I found so far was to invoke S32DS from
the console.

gen-compile-commands
--------------------

The tool can be used to generate the `compile_commands.json` file used by
various autocomplete tools like `clangd`.

S32DS may not be able to generate the file by itself, but at least it prints all
the output during compilation.  
This tool uses the compilation output to generate the json file.

autopegdbserver
---------------

Automatically starts PEmicro's GDB server with the correct parameters to be able
to debug an NXP board using their debug probe.

Note that for this to work you need `pegdbserver` available on your PATH.
This binary is automatically installed during S32DS's installation with the name
`pegdbserver_console`.

gdbflash
--------

Flash an MCU using gdb and `autopegdbserver`.

* * *

copyright
---------

Copyright © 2025 Andrea Fanti

This work is free. You can redistribute it and/or modify it under the
terms of the Do What The Fuck You Want To Public License, Version 2,
as published by Sam Hocevar. See the LICENSE.txt file for more details.

<!--
vim: textwidth=80
--!>
