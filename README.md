Builds and packages Ardour (currently v8.12.0) for AMD64 Debian in a Docker container. Presumably, it works with other versions as well; I just haven't tried.

If you think it's worth it, maybe you should [pay](https://community.ardour.org/download?type=compiled) instead of doing this. Or why not do both?

## How to use

Just run `build.sh` in the project root.

## What it does

`build.sh` first downloads the sources specified by the `DOWNLOAD_URL` variable in each `build/env/*` file, if they don't already exist. It then creates and starts a Docker container.

The Docker container installs a whole bunch of dependencies and then runs `build/build-dep.sh` for all the `build/env/*` files. This will build some dependencies that differ from the versions in the Debian repos, and lastly build Ardour itself (which takes a lot of time - an hour on my machine! - so be patient).

Lastly, an "application bundle" will be created according to https://ardour.org/building_linux.html, which is then copied to the `out` directory on the host.

## Environment files

The `docker/build/env/*` files may contain these variables:

* `DOWNLOAD_URL` (mandatory; get them from https://nightly.ardour.org/list.php#build_deps)
* `ARCHIVE_NAME` (name of the downloaded file; will be extracted from `DOWNLOAD_URL` if not set)
* `SUB_DIR` (name of the directory created by the archive; will be extracted from `ARCHIVE_NAME` if not set)
* `BUILD_SCRIPT` (name of a build script in `build/scripts/`; will be same as the environment filename if not set)
