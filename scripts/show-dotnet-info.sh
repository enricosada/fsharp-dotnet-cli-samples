
which dotnet
if [ $? -e 0 ]; then
	echo "Using dotnet:"
	dotnet --version
else
	echo "dotnet.exe not found"
fi
