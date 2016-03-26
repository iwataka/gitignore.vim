# Gitignore.vim

Allows you to make .gitignore easily!
This uses [gitignore collection hosted by GitHub](https://github.com/github/gitignore).

## Related projects

+ [gibo](https://github.com/simonwhitaker/gibo)
+ [gitignore.io](https://www.gitignore.io/)

## Usage

+ `:Gitignore [foo...]` means to add the patterns for `foo` filetype to `.gitignore` in the project root.
+ `:Gitignore` is almost the same as the above, but infers the filetype by the current buffer's filetype.
+ `:Gitignore! [foo...]` is almost the same as above, but discard the existing `.gitignore` content before.
+ `:GitignoreUpdate` means to update the gitignore collection.

## Configuration

+ `g:gitignore_template_dir = ~/.gitignore-boilerplates` (same as [gibo](https://github.com/simonwhitaker/gibo))
