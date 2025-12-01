# bgreenwell's Homebrew Tap

A collection of CLI tools and developer utilities (mostly built in Rust).

## Installation

To add this tap to your Homebrew installation:

```bash
brew tap bgreenwell/tap
````

## Currently available tools

| Tool | Description | Install Command |
| :--- | :--- | :--- |
| **[xleak](https://github.com/bgreenwell/xleak)** | A fast terminal Excel viewer with an interactive TUI. | `brew install xleak` |
| **[doxx](https://github.com/bgreenwell/doxx)** | Expose the contents of .docx files without leaving your terminal. | `brew install doxx` |
| **[lstr](https://github.com/bgreenwell/lstr)** | A fast, minimalist directory tree viewer, written in Rust. | `brew install lstr` |

## Quick start (all-in-One)

If you want to tap and install a specific tool in one go:

```bash
brew install bgreenwell/tap/xleak
```

## Troubleshooting

**"Formula not found"**
If you recently tapped the repo but can't find a tool, try updating:

```bash
brew update
```

**"Permission denied"**
Ensure you have the standard Homebrew permissions set up.

