# README

*unite-command* is unite source for piping shell commands.

## Usage:

### *pipecommand* Actions:

#### run

Run and echo selected command.
This command is default action of *pipecommand* kind.


#### push(add)

Push selected command to stack.
This action has alias name "add", so you can use this command by holding *a* key down.


#### pop(undo)

Pop last command from stack.
This action has alias name "undo", so you can use this command by holding *u* key down.


#### remove(delete)

Delete selected command from storage.
This action has alias name "delete", so you can use this command by holding *d* key down.


#### rename

Rename selected command.


#### echo

Run and echo results of stacked commands.


#### view

View results of stacked commands on new buffer.


#### yank

Yank results of stacked commands.


#### register

Register stacked commands as new command.


## Requirements:

## Install:

    NeoBundle 'git://github.com/kmnk/unite-pipe-command.git'

## License:

MIT Licence

## Author:

kmnk <kmnknmk+vim@gmail.com>
