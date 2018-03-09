NODE_MODULES_DIR="$(npm root -g)"
readonly NODE_MODULES_DIR
cd $NODE_MODULES_DIR

NODE_MODULES=( "grunt-cli" "gulp-cli" "bower" "cordova" "ionic" "postcss" "csslint" "stylelint" "jshint" "jslint" "eslint" "eslint-plugin-react" )
for i in "${NODE_MODULES[@]}"; do
	if [ ! -d "$i" ]; then
		echo "Installing $i..."
		npm install -g $i &>/dev/null
	else
		echo "Updating $i..."
		npm update -g $i &>/dev/null
	fi
done
