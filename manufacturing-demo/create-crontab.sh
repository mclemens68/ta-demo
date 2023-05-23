vensim_path=$(which vensim | sed 's|/[^/]*$||')

echo "# Make sure vensim is in path" > crontab-temp.txt
echo "PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:"$vensim_path >> crontab-temp.txt
echo >> crontab-temp.txt
echo "# Set variables" >> crontab-temp.txt
echo "TARGET_DIR="$PWD >> crontab-temp.txt

cat crontab.txt >> crontab-temp.txt
