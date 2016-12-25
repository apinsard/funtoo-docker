flavor="$1"
shift
mixins="$@"

echo -n "Syncing portage tree..."
emerge --sync > /dev/null 2>&1
echo "Done"

echo -n "Configuring system..."
echo "" > /etc/fstab
sed -e 's/#rc_sys=""/rc_sys="docker"/g' -i /etc/rc.conf
cat > /etc/portage/make.conf <<EOT
MAKEOPTS="-j$(( $(nproc) + 1 ))"
CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="${CFLAGS}"
EOT
echo " Done"

echo -n "Setting up profile..."
ego profile set flavor "$flavor" > /dev/null
if [ -n "$mixins" ]; then
  ego profile mix-ins $mixins > /dev/null
fi
echo " Done"
