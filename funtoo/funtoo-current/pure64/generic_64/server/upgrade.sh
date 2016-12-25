echo -n "Upgrading system..."
emerge -uDN --with-bdeps=y --complete-graph=y @world > /dev/null
emerge -c > /dev/null
revdep-rebuild > /dev/null
echo " Done"
