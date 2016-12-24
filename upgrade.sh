echo -n "Upgrading system..."
emerge -uDN --with-bdeps=y --complete-graph=y @world
echo " Done"
