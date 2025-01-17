Eclipse / NXP's S32 Design Studio / S32DS console tools
=======================================================

This repo contains various tools I developed while being forced to work with
NXP's [S32 Design Studio][1], a modded version of [Eclipse CDT][2].

I would personally like if all companies stop forcing devs to use their own
shitty IDEs and let them use whatever they want.

This repo is the result of my work towards the goal of using the tools I fancy
the most, namely the console.

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

<!--
vim: textwidth=80
--!>
