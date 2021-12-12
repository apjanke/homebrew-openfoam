# homebrew-openfoam

An attempt to get OpenFOAM installing using Homebrew.

This repo is a short-term project for experimentation and initial implementation. If this works, the intent is to submit the formula to Homebrew Core and then this separate tap repo can go away.

## Usage

This repo is a ["custom tap"](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap) for Homebrew.

To install OpenFOAM using this tap, first install Homebrew, and then:

```bash
brew tap apjanke/openfoam
brew install openfoam
```

## References

There's an old request for this in the Homebrew issue tracker at <https://github.com/Homebrew/homebrew-core/issues/34327>.

## Author

Written by [Andrew Janke](https://apjanke.net).

The project home page is <https://github.com/apjanke/homebrew-openfoam>.
