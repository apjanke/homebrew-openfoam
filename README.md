# homebrew-openfoam

An attempt to get OpenFOAM installing using Homebrew.

This repo is a short-term project for experimentation and initial implementation. If this works, the intent is to submit the formula to Homebrew Core and then this separate tap repo can go away.

This is not working yet! It's still in the initial development phase.

## Usage

This repo is a ["custom tap"](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap) for Homebrew.

To install OpenFOAM using this tap, first install Homebrew, and then:

```bash
brew tap apjanke/openfoam
brew install openfoam
```

## References

* [Foad's tweet expressing interest in an OpenFOAM Homebrew formula](https://twitter.com/fsfarimani/status/1470143618505744392)

### OpenFOAM References

* [Build-from-source instructions](https://develop.openfoam.com/Development/openfoam/-/blob/master/doc/Build.md)
* [System Requirements](https://develop.openfoam.com/Development/openfoam/blob/develop/doc/Requirements.md)
* [Software for Compilation](https://openfoam.org/download/source/software-for-compilation/) which lists dependencies
* [Wiki section on installing OpenFOAM on Mac](https://openfoamwiki.net/index.php/Installation/Mac_OS)
  * [Wiki page on installing OpenFOAM 2.3.x on Mac](https://openfoamwiki.net/index.php/Installation/Mac_OS/OpenFOAM_2.3.x)
  * (The Wiki page on installing OpenFOAM 3.0.x on Mac just has broken links.)
* [OpenFOAM v9 source repo](https://github.com/OpenFOAM/OpenFOAM-9)

### Homebrew References

There's an old request for this in the Homebrew issue tracker at <https://github.com/Homebrew/homebrew-core/issues/34327>.

## Contributor Stuff

### Open Questions

* What's the right way to pull in `wmake`? This appears to be a custom tool distributed as part of OpenFOAM itself.
* Should we include the "Third Party" stuff that comes in a separate download?
  * I think no? This looks like it's just build scripts for the auxiliary programs like Paraview and Scotch.
* How does OpenFOAM versioning work? The doco I see has references to versions 2.x, 3.x, and the like, but the current source download 

### Contributor notes

I can't find a full list of the actual dependencies for OpenFOAM. (The list [here in System Requirements](https://develop.openfoam.com/Development/openfoam/blob/develop/doc/Requirements.md)) seems to only call out version requirements for some selected deps. I'm basing our deps list off of the Mac ports it tells you to install in [the Installing 2.3.x on Mac wiki page](https://openfoamwiki.net/index.php/Installation/Mac_OS/OpenFOAM_2.3.x).

OpenFOAM seems to have a weird build system where there's no `make install` step. Instead, they want you to [dump the source code into the final destination location and do a build in-place](https://openfoam.org/download/source/downloading-source-code/) (see also <https://openfoam.org/download/source/compiling-openfoam/>). That's not going to play well with the Homebrew packaging model (or any "normal" Unix-style packaging & deployment tools). We'll probably have to hack together our own `make install` equivalent. And even if we get that working, this might be a problem for getting the formula accepted into Homebrew Core.

Paraview is only available in Homebrew as a cask (.app installation). I'm not sure how that interacts with a non-cask formula, and if & how the OpenFOAM software interacts with it: maybe you're supposed to just use it interactively; maybe OpenFOAM calls it directly. If OpenFOAM is supposed to call it, I don't know how it will locate the Paraview .app installation.

## Author

This `openfoam` formula was written by [Andrew Janke](https://apjanke.net).

The project home page is <https://github.com/apjanke/homebrew-openfoam>.

## Acknowledgments

Coding powered by _Romanian Christmas Carols_ by the Madrigal Chamber Choir.
