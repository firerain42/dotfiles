#!/usr/bin/env python3
import argparse
import tempfile
import os
import shutil
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--source-directory', required=True, type=Path, nargs='+', help='Path in which the files are sought')
    parser.add_argument('-f', '--file', required=True, type=Path, nargs='+', help='Path in which the files are sought')
    parser.add_argument('--no_absolute', action='store_true', help='Use relative paths for the links')

    cmd_args = parser.parse_args()

    relink_files(vars(cmd_args))


def relink_files(args):
    source_dirs = args['source_directory']
    files = args['file']
    relative_links = args['no_absolute']

    for file in files:
        file = file.resolve()

        assert file.exists(), f"File {file} does not exists"

        candidates = [(sd / file.name) for sd in source_dirs if (sd / file.name).exists()]

        if len(candidates) == 0:
            print(f"Could not find {file.name} in {[str(sd) for sd in source_dirs]}")
            exit(1)
        elif len(candidates) > 1:
            print(f"Found more than one {file.name}: {[str(c) for c in candidates]}")
            exit(1)

        link_target = candidates[0]

        if relative_links:
            link_target = link_target.resolve()

        assert file != link_target.resolve(), f"Link name and target are the same: {file}"

        # Create temp link to copy all file stats from the original
        _, temp_link = tempfile.mkstemp(suffix=file.name, dir=file.parent)
        temp_link = Path(temp_link)
        temp_link.unlink()
        temp_link.symlink_to(link_target)
        shutil.copystat(file, temp_link, follow_symlinks=False)

        os.replace(temp_link, file)


if __name__ == "__main__":
    main()
