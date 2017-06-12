source $stdenv/setup 

PATH=$clamav/bin:$composer/bin:$PATH 

composer init --require="hiokwee/filemanager:dev-master" -n
composer config vendor-dir $out 
composer config preferred-install dist
composer install --prefer-dist 
