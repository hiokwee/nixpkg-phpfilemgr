source $stdenv/setup

PATH=$clamav/bin:$composer/bin:$PATH

# Alternatively, get composer.json from remote repository
#cp $src ./composer.json
#chmod 777 composer.json

# Create composer.json from cli
composer init --require="hiokwee/filemanager:dev-master" -n
composer config vendor-dir $out
composer config preferred-install dist
composer install --prefer-dist
