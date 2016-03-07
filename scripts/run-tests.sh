#make path absolute
RootDir=$(dirname $(dirname $0))

# restore and compile

echo "Testing HelloConsole..."

pushd "$RootDir/HelloConsole"

dotnet restore
if [ $? -ne 0 ]; then
    exit 1
fi

dotnet --verbose build
if [ $? -ne 0 ]; then
    exit 1
fi

popd

# dotnet new

echo "Testing dotnet new..."

rm -rf "$RootDir/test/test-dotnet-new"

mkdir -p "$RootDir/test/test-dotnet-new" && pushd "$RootDir/test/test-dotnet-new"

if [ $? -ne 0 ]; then
    exit 1
fi

dotnet new --lang f#
if [ $? -ne 0 ]; then
    exit 1
fi

dotnet restore
if [ $? -ne 0 ]; then
    exit 1
fi

dotnet --verbose build
if [ $? -ne 0 ]; then
    exit 1
fi

dotnet --verbose run a b
if [ $? -ne 0 ]; then
    exit 1
fi

popd

exit 0
