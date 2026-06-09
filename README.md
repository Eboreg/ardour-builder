Builds and packages Ardour (currently v9.7.0) for AMD64 Debian in a Docker container. Presumably, it works with other versions as well; I just haven't tried.

If you think it's worth it, maybe you should [pay](https://community.ardour.org/download?type=compiled) instead of doing this. Or why not do both?

## How to use

First, make sure you have Docker and Curl installed. Then just run `build.sh` in the project root.

## What it does

`build.sh` first loops through the files in `build/env/` and checks for `DOWNLOAD_URL` variables. If found, it downloads the source archive specified, if it doesn't already exist. It then creates and starts a Docker container.

The Docker container installs a whole bunch of dependencies and then runs `build/build-dep.sh` for each of the files in `build/env/`. This will build some dependencies that differ from the versions in the Debian repos, and lastly build Ardour itself (which takes a lot of time - an hour on my machine! - so be patient).

Lastly, an "application bundle" will be created according to https://ardour.org/building_linux.html, which is then copied to the `out` directory on the host.

## Environment files

The files in `build/env/` may contain these variables:

* `DOWNLOAD_URL` - URL of a source archive; get them from https://nightly.ardour.org/list.php#build_deps
* `GIT_REPO` - URL for Git repository
* `GIT_CHECKOUT` - Branch, tag, commit etc. to check out from Git
* `ARCHIVE_NAME` - Name of the downloaded file; will be extracted from `DOWNLOAD_URL` if not set
* `SUB_DIR` - Name of the directory created by the archive; will be extracted from `ARCHIVE_NAME` or `GIT_REPO` if not set
* `BUILD_SCRIPT` - Name of a build script in `build/scripts/`; will be same as the `build/env/` filename if not set

Either `DOWNLOAD_URL` or `GIT_REPO` must be set, with the latter taking priority.

## How to build other versions

1. Find a tag/commit you like at https://github.com/Ardour/ardour, and replace `GIT_CHECKOUT` in `build/env/ardour` with it
2. Probably look through https://nightly.ardour.org/list.php#build_deps and update other `build/env/` files accordingly
3. Try running `build.sh`
4. When it inevitably fails:
   1. Check if the list of installed APT packages in `Dockerfile` needs changing
   2. Do the same for the scripts in `build/scripts/`
   3. Rinse and repeat
