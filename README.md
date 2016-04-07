# gitignore.vim

[Git](https://git-scm.com/) is now must-have version control system and you
write .gitignore files when using it. Sometimes they become large and
complicated, but GitHub provides the official collection of .gitignore
templates in
[https://github.com/github/gitignore](https://github.com/github/gitignore), so
why don't you use them?

You can use them in Vim with great ease.

## Usage

+ `:Gitignore [Foo...]`

    This adds the patterns for `Foo` filetype to `.gitignore` in the
    project root.

+ `:Gitignore! [Foo...]`

    This is almost the same as the above, but discard the existing `.gitignore`
    content before.

+ `:GitignoreUpdate`

    This updates the .gitignore template collection in `g:gitignore_dir`.

## Installation

This can be installed by using any plugin-managers like
[Vundle.vim](https://github.com/VundleVim/Vundle.vim), but if you don't have
your favorite one, I recommend
[vim-plug](https://github.com/junegunn/vim-plug).

Install it and write the below line in your `.vimrc`:

```vim
Plug 'iwataka/gitignore.vim'
```

For other plugin-managers, please see their own documents.

## Configuration

+ `g:gitignore_dir` (default value: `~/.gitignore-boilerplates`)

    This specify the directory which contains the .gitignore template
    collection. By default, this uses the same directory as
    [gibo](https://github.com/simonwhitaker/gibo), which means no additional
    downloading even if using [gibo](https://github.com/simonwhitaker/gibo).

## Additional features

+ You'll see no duplicated patterns even if running `Gitignore Foo` twice!

## Related projects

+ [gibo](https://github.com/simonwhitaker/gibo)

+ [gitignore.io](https://www.gitignore.io/)

+ [rdolgushin/gitignore.vim](https://github.com/rdolgushin/gitignore.vim)

    Syntax highlighting, code snippets and
    [tComment](https://github.com/tomtom/tcomment_vim) support

+ [euclio/gitignore.vim](https://github.com/euclio/gitignore.vim)

    Automatically add the entries in a .gitignore file to `wildignore`
