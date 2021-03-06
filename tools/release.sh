CURR_DIR=${PWD##*/}

if [ "$CURR_DIR" != "build" ];then
    echo "Run this script from 'build' directory"
    exit;
fi

TYPE=`uname | tr '[:upper:]' '[:lower:]'`
MAJOR=`grep 'RESIDUE_MAJOR' ../CMakeLists.txt | grep -o [0-9] | tr -d '\n'`
MINOR=`grep 'RESIDUE_MINOR' ../CMakeLists.txt | grep -o [0-9] | tr -d '\n'`
PATCH=`grep 'RESIDUE_PATCH' ../CMakeLists.txt | grep [0-9] | awk '{print $3}' | cut -d "\"" -f2`
VERSION="$MAJOR.$MINOR.$PATCH"
echo "Releasing $VERSION on $TYPE. Continue (y/n)?"
read confirm
if [ "$confirm" = "y" ]; then
    rm -rf *
    sh ../tools/package.sh $TYPE $VERSION OFF ON && sh ../tools/package.sh $TYPE-debug $VERSION ON ON
    rm residue-extensions-$VERSION-$TYPE-debug-x86_64.tar.gz
fi
    
