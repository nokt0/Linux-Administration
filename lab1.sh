#!/bin/sh
dir_name='test'

function checkDiff() {
  if [[  -z $(diff -q $1 $2) ]];
  then echo "YES"
  fi
}

#Task 1
mkdir ~/$dir_name
#Task 2
touch ~/$dir_name/list
ls -p -A /etc > ~/$dir_name/list
#Task 3
grep '/' ~/$dir_name/list | wc -l >> ~/$dir_name/list
grep '^\.' ~/$dir_name/list | wc -l >> ~/$dir_name/list
#Task 4
mkdir ~/$dir_name/links
#Task 5
ln ~/$dir_name/list ~/$dir_name/links/list_hlink
#Task 6
ln -s ~/$dir_name/list ~/$dir_name/links/list_slink
#Task 7
ls -l ~/$dir_name/links | grep 'list_slink' | awk '{print $2}'
ls -l ~/$dir_name/links | grep 'list_hlink' | awk '{print $2}'
ls -l ~/$dir_name/ | grep 'list' | awk '{print $2}'
#Task 8
wc -l ~/$dir_name/list | awk '{print $1}' >> ~/$dir_name/links/list_hlink
#Task 9
checkDiff ~/$dir_name/links/list_hlink ~/$dir_name/links/list_slink
#Task 10
mv ~/$dir_name/list ~/$dir_name/list1
#Task 11
checkDiff ~/$dir_name/links/list_hlink ~/$dir_name/links/list_slink
#Task 12
ln ~/$dir_name/list1 ~/$dir_name/links/list_link
#Task 13
find /etc -name "*.conf" > ~/list_conf
#Task 14
find /etc -type d -name "*.d" > ~/list_d
#Task 15
touch ~/list_conf_d
cat ~/list_conf > ~/list_conf_d
cat ~/list_d >> ~/list_conf_d
#Task 16
mkdir ~/$dir_name/.sub
#Task 17
mv ~/list_conf_d ~/$dir_name/.sub/
#Task 18
mv -b ~/list_conf_d ~/$dir_name/.sub/
#Task 19
ls ~/test -a -R
#Task 20
man man > ~/man.txt
#Task 21
cd ~
split -b 1k ~/man.txt man_
#Task 22
mkdir ~/man.dir
#Task 23
find ~ -name "*man_*" -type f -exec mv {} ~/man.dir \;
#Task 24 
cat ~/man.dir/man_* > ~/man.dir/man.txt
#Task 25
checkDiff ~/man.txt ~/man.dir/man.txt
#Task 26
sed -i '1iBEGIN\nBEGIN\nBEGIN\n' ~/man.txt
echo 'END\nEND\nEND' >> ~/man.txt
#Task 27
diff -u ~/man.txt ~/man.dir/man.txt > ~/man-patch
#Task 28
mv ~/man-patch ~/man.dir/
#Task 29
patch  ~/man.dir/man.txt < ~/man.dir/man-patch
#Task 30
checkDiff ~/man.txt ~/man.dir/man.txt