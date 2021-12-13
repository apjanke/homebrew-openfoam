# homebrew-openfoam

An attempt to get OpenFOAM installing using [Homebrew](https://brew.sh).

This repo is a short-term project for experimentation and initial implementation. If this works, the intent is to submit the formula to Homebrew Core and then this separate tap repo can go away.

| This is not working yet! It's still in the initial development phase. |
| ---- |

## Usage

This repo is a ["custom tap"](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap) for Homebrew.

To install OpenFOAM using this tap, first install Homebrew, and then:

```bash
brew tap apjanke/openfoam
brew install openfoam
```

## Requirements

This is targeting macOS 10.15 and later. Homebrew no longer supports macOS 10.14 and earlier, so getting it working well there is kinda hopeless.

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
* There's an existing [mrklein/homebrew-foam Tap](https://github.com/mrklein/homebrew-foam), but that only has formulae for some dependencies, not OpenFOAM itself.

### Homebrew References

There's an old request for this in the Homebrew issue tracker at <https://github.com/Homebrew/homebrew-core/issues/34327>.

## Contributor Stuff

### Status

Currently, the build isn't even working. It's failing with a bunch of errors related to basic C++ stuff, like this:

```text
xcrun c++ -std=c++14 -m64 -pthread -ftrapping-math -DOPENFOAM=2106 -DWM_DP -DWM_LABEL_SIZE=32 -Wall -Wextra -Wold-style-cast -Wnon-virtual-dtor -Wno-unused-parameter -Wno-invalid-offsetof -Wno-undefined-var-template -Wno-unknown-warning-option  -O3  -DNoRepository -ftemplate-depth-100  -iquote. -IlnInclude -I/Users/janke/tmp/openfoam/OpenFOAM-v2106/src/OpenFOAM/lnInclude -I/Users/janke/tmp/openfoam/OpenFOAM-v2106/src/OSspecific/POSIX/lnInclude   -fPIC -c POSIX.C -o /Users/janke/tmp/openfoam/OpenFOAM-v2106/build/darwin64ClangDPInt32Opt/src/OSspecific/POSIX/POSIX.o
In file included from POSIX.C:37:
In file included from /Users/janke/tmp/openfoam/OpenFOAM-v2106/src/OpenFOAM/lnInclude/OSspecific.H:42:
In file included from /Users/janke/tmp/openfoam/OpenFOAM-v2106/src/OpenFOAM/lnInclude/fileNameList.H:49:
In file included from /Users/janke/tmp/openfoam/OpenFOAM-v2106/src/OpenFOAM/lnInclude/fileName.H:51:
In file included from /Users/janke/tmp/openfoam/OpenFOAM-v2106/src/OpenFOAM/lnInclude/word.H:46:
In file included from /Users/janke/tmp/openfoam/OpenFOAM-v2106/src/OpenFOAM/lnInclude/string.h:56:
/Applications/Xcode-11.3.1.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1/cstring:70:9: error: no member
      named 'memcpy' in the global namespace
using ::memcpy;
      ~~^
/Applications/Xcode-11.3.1.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1/cstring:71:9: error: no member
      named 'memmove' in the global namespace
using ::memmove;
      ~~^
```

This was on macOS 10.14, which I'm using bc it's what my main Mac is running. Going to try this on 10.15+ and see if a newer Xcode does anything.

### TODO

The first thing we need to do is get the basic OpenFOAM 9.x/v2106 build working on macOS against Homebrew dependencies. I'm doing this with interactive builds in an OpenFOAM source checkout, instead of under `brew`, because IMHO it's easier to see errors and iterate on that way when you're still having basic build issues.

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
