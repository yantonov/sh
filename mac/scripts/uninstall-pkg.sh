#!/bin/sh

# this script allow you to uninstall given pkg file

# ATTENTIONS!
# all delete operation are interactive, but in any way
# USE THIS SCRIPT FOR YOUR OWN RISK

SCRIPT=`basename $0`

WD=`pwd`

PACKAGE_NAME=$1

if [ -z "$PACKAGE_NAME" ]; then
    echo "[ERROR] - package is not defined"
    echo "Usage: $SCRIPT <package-name>"
    exit 0
fi

installed_packages=`pkgutil --pkgs | grep $PACKAGE_NAME`
if [ -z "$installed_packages" ]; then
    echo "[ERROR] - package '$PACKAGE_NAME' not found"
    exit 0
fi

for p in `pkgutil --pkgs | grep $PACKAGE_NAME`; do
    echo "Delete package: '$p' [y/n/other key to break] ?:"
    read -n 1 selection
    echo ""
    case "$selection" in
        y)
            echo "[INFO] - Process package: '$p'"
            volume=`pkgutil --pkg-info $p | grep -E 'volume:' | cut -d ' ' -f 2`
            location=`pkgutil --pkg-info $p | grep -E 'location:' | cut -d ' ' -f 2`
            package_path="$volume$location"
            echo '[INFO] - Go to package install location: $package_path'
            cd $package_path
            echo '[INFO] - Iterate package files:'
            for f in `pkgutil --only-files --files $p`; do
                echo 'Delete file: '$f' ? [y/n/other key to skip package]:'
                read -n 1 file_cmd
                echo ""
                case "$file_cmd" in
                    y)
                        sudo rm -i $f
                        echo "[INFO] - file '$f' deleted."
                    ;;
                    n)
                        echo "[INFO] - file '$f' skipped"
                    ;;
                    *)
                        echo "[INFO] - skip all files in package '$p'"
                        break
                    ;;
                esac
            done
            ;;
        n)
            echo '[INFO] - ok, i will skip package '%p''
            ;;
        *)
            echo '[INFO] - quit'
            exit 0
            ;;
    esac
done

cd $WD
