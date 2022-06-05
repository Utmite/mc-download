
while getopts p:v:b:n: flag
do
    case "${flag}" in
        p) PROJECT=${OPTARG};;
        v) VERSION=${OPTARG};;
        b) BUILD=${OPTARG};;
        n) NAMED=${OPTARG};;
    esac
done

if [ -z "$PROJECT" ]
then
	curl https://api.papermc.io/v2/projects
	echo "\nWhat do you want to download?:"
	read PROJECT
	echo "You have selected $PROJECT"
fi
if [ -z "$VERSION" ]
then
	echo "What version do you want?"
	curl https://api.papermc.io/v2/projects/$PROJECT/
	echo ""

	read VERSION
	echo "You have selected $VERSION"
fi
if [ -z "$BUILD" ]
then
	echo "What build do you want?"
	curl https://api.papermc.io/v2/projects/$PROJECT/versions/$VERSION
	echo ""
	read BUILD
fi
if [ -z "$NAMED" ]
then
	echo "how do you want to call the file"
	read NAMED
fi

echo "Download..."
curl -o $NAMED.jar https://api.papermc.io/v2/projects/$PROJECT/versions/$VERSION/builds/$BUILD/downloads/$PROJECT-$VERSION-$BUILD.jar
