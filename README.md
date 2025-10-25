# vtex — Vim Terminal Executor

vtex lets you instantly run the contents of your current Vim buffer inside the first open terminal buffer — no leaving the editor, no switching windows.
Just press Shift + F8, and your script runs.

## Features

- Run the current buffer in an existing terminal buffer

- Automatically detects file type and uses the right interpreter

- Saves the current buffer to a temporary file before execution

- Tested with Vim versions on Debian Bullseye, Bookworm and Trixie

#### Supports:

- Python (.py)

- JavaScript (.js)

- Shell (.sh)

- Ruby (.rb)

- Perl (.pl)

- PHP (.php)

- Lua (.lua)

## Installation

#### Using vim-plug

Add `Plug 'hwblx/vsnt'` to your .vimrc.

Install with `:PlugInstall`.

#### Using packages (built-in)

git clone https://github.com/hwblx/vtex ~/.vim/pack/plugins/start/vtex

## Setup

If you’re configuring manually, just add this to your .vimrc:

`nnoremap <S-F8> :call vtex#run()<CR>`

`inoremap <S-F8> <C-o>:call vtex#run()<CR>`

## Usage

Open a script file (.py, .js, .sh, etc.).

Open a terminal buffer (:term).

Press Shift + F8 to execute the current buffer in that terminal.

Your code will run in the first open terminal buffer listed by :echo term_list().
