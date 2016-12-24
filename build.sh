verify_checksum() {
  a=$(sha256sum "$1" | cut -d' ' -f1)
  b=$(cat "$2" | cut -d' ' -f2)
  [ "$a" = "$b" ]
}


build=current
arch=pure64
subarch=generic_64-pure64

stage3="stage3-latest.tar.xz"
mirrors="http://build.funtoo.org ftp://ftp.osuosl.org/pub/funtoo"

mkdir funtoo; cd funtoo
cp /bin/busybox .

success=false
for mirror in $mirrors; do
  url="${mirror}/funtoo-${build}/${arch}/${subarch}/${stage3}"
  echo -n "Downloading stage3 from ${mirror} ..."
  if wget -q -c "${url}" "${url}.hash.txt"; then
    echo " Done"
  else
    echo " Fail"
    continue
  fi
  echo -n "Verifying checksum..."
  if verify_checksum "${stage3}" "${stage3}.hash.txt"; then
    echo " Done"
  else
    echo " Fail"
    continue
  fi
  success=true
  break
done
if ! $success; then
  echo "Unable to a valid get stage3 from any mirror."
  return 1
fi

echo -n "Extracting ${stage3}..."
tar xpf "${stage3}"
echo " Done"

rm -f "${stage3}"{,.hash.txt}

echo -n "Installing stage3..."
/funtoo/busybox rm -rf /lib* /{usr,var,bin,sbin,opt,mnt,media,root,home,run,tmp}
/funtoo/busybox cp -fRap bin boot home lib* mnt opt root run sbin usr var /
/funtoo/busybox cp -fRap etc/* /etc/
echo " Done"


echo -n "Cleaning..."
cd /
/funtoo/busybox rm -rf /funtoo /build.sh /linuxrc
echo " Done"

echo "Bootstrapped ${stage3} into /:"
ls --color -lah
