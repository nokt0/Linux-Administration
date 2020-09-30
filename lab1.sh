#!/bin/sh
dir_name='test'

function checkDiff() {
  if [[  -z $(diff -q $1 $2 2>&1) ]];
  then echo "YES"
  else echo "NO"
  fi
}

#Deleting
echo 'print y/n for delete all created files'
read is_delete
if [[ "$is_delete" -eq "y" ]]
then
rm -rf ~/$dir_name
rm -rf ~/list1
rm -rf ~/man.dir
rm -rf ~/list_conf
rm -rf ~/list_d
rm -rf ~/man.txt
echo 'deleted'
fi

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


#BREAKPOINT
echo 'links and folders created'
read


#Task 7
ls -l ~/$dir_name/links | grep 'list_slink' | awk '{print $2}'
ls -l ~/$dir_name/links | grep 'list_hlink' | awk '{print $2}'
ls -l ~/$dir_name/ | grep 'list' | awk '{print $2}'

#BREAKPOINT: list_hlink=1 так как указывает только сам на себя на list указывает list и list_hlink
#            list_slink выдает то же что и list
echo 'links count'
read

#Task 8
wc -l ~/$dir_name/list | awk '{print $1}' >> ~/$dir_name/links/list_hlink
#Task 9
checkDiff ~/$dir_name/links/list_hlink ~/$dir_name/links/list_slink

#BREAKPOINT: diff = Yes так как в hlink указывает на link
#            и при изменении hlink тоже меняется
echo 'hlink == link'
read

#Task 10
mv ~/$dir_name/list ~/$dir_name/list1
#Task 11
echo 'list_hlink and list_slink' is equal:
checkDiff ~/$dir_name/links/list_hlink ~/$dir_name/links/list_slink

#BREAKPOINT: No так как файл не находится и поток ошибок направлен в поток вывода,
#            условие проверяет строку на пустоту
read

#Task 12
ln ~/$dir_name/links/list_hlink ~/list1 
#Task 13
find /etc -name "*.conf" > ~/list_conf
#Task 14
find /etc -type d -name "*.d" > ~/list_d
#Task 15
touch ~/list_conf_d
cat ~/list_conf > ~/list_conf_d
cat ~/list_d >> ~/list_conf_d

#BREAKPOINT
echo 'Check created files'
read

#Task 16
mkdir ~/$dir_name/.sub
#Task 17
cp ~/list_conf_d ~/$dir_name/.sub/
#Task 18
cp -b ~/list_conf_d ~/$dir_name/.sub/
#Task 19
ls ~/test -A -R

#BREAKPOINT
echo 'All catalogs'
read

#Task 20
man man > ~/man.txt
#Task 21
cd ~
split -b 1k ~/man.txt man_
#Task 22
mkdir ~/man.dir
#Task 23
find ~ -name "*man_*" 2>/dev/null -type f -exec mv {} ~/man.dir \;
#Task 24 
cat ~/man.dir/man_* > ~/man.dir/man.txt
#Task 25
echo 'Is files equal?'
checkDiff ~/man.txt ~/man.dir/man.txt

#BREAKPOINT: yes так как файлы правильно были склеены правильно
#            и в итоге оказались идентичны
read

#Task 26
sed -i '1iBEGIN\nBEGIN\nBEGIN\n' ~/man.txt
echo "END\nEND\nEND" >> ~/man.txt
#Task 27
diff -u ~/man.txt ~/man.dir/man.txt > ~/man-patch
#Task 28
mv ~/man-patch ~/man.dir/
#Task 29
patch  ~/man.dir/man.txt < ~/man.dir/man-patch
#Task 30
echo 'Is files equal?'
checkDiff ~/man.txt ~/man.dir/man.txt

#BREAKPOINT: yes так как применился патч
read