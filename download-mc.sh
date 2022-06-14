while getopts p:v:b:n:w:d: flag
do
    case "${flag}" in
        p) PROJECT=${OPTARG};;
        v) VERSION=${OPTARG};;
        b) BUILD=${OPTARG};;
        n) NAMED=${OPTARG};;
	w) WORLD_LEVEL=${OPTARG};;
	d) PORT_SERVER=${OPTARG};;
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

if [ -z "$PORT_SERVER" ]
then
	echo "Which port do you want to run the server on:"
	read PORT_SERVER
fi

if [ -z "$WORLD_LEVEL" ]
then
	echo "What world do you want to play: "
	read WORLD_LEVEL
fi

sed -i "s/server-port=.*/server-port=$PORT_SERVER/" $( pwd )/server.properties
sed -i "s/level-name=.*/level-name=$WORLD_LEVEL/" $( pwd )/server.properties

java -Xms2G -Xmx2G -jar $( pwd )/$NAMED.jar --nogui

