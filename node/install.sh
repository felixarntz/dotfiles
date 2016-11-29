NODE_MODULES_DIR="$(npm root -g)"
readonly NODE_MODULES_DIR
cd $NODE_MODULES_DIR

NODE_MODULES=( grunt-cli gulp-cli bower cordova ionic )
for i in "${NODE_MODULES[@]}"
do :
	if [ ! -d "$i" ]; then
		npm install -g $i &>/dev/null
	else
		npm update -g $i &>/dev/null
	fi
done
