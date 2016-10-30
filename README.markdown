Introduction
============
Automatically create direcories that don't exist yet when writing a file.

This allows you to do:

    vim ~/a/dir/tree/that/doesnt/exist/new-file.txt

and then just use `:w` (or `ZZ`, or `:up`, etc.) to create the directory tree.

This is basically the same as the "auto_mkdir" plugin, although it was
developed independently. This version has the option to confirm directory
creation and includes a bugfix:
http://www.vim.org/scripts/script.php?script_id=3352

Options
=======
`g:auto_mkdir2_confirm`                 (Boolean, default: 1)
Ask for confirmation before automatically creating a directory.

Commands
========
MkdirP [directory]                                                   `:MkdirP`

Like `mkdir -p` from the shell: it will create all intermediate directories
and will not show an error if the [directory] already exists and is a
directory.

The [directory] is `expand()`-ed. The parameter is optional and [%:h:p] is used
if it is empty.
