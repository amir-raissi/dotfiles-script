#!/bin/sh

backupPaths="./backup.conf"

homeDir=~

sameLine="\e[1A\e[K"

echo -e "Starting Backup 🐎🐎🐎"

sed '/^[ \t]*$/d' $backupPaths | while read filePath; do
    echo -e "Backing-up $filePath"

    findThis="~/"
    replaceWith="$homeDir/"
    originalFile="${filePath//${findThis}/${replaceWith}}"

    rsync -av $originalFile .dotfiles/

    sleep 0.05
done

echo -e "Done ✅"

echo -e "Generating installed package lists ✍️✍️✍️"

./getPackages.sh

now=$(date +%D)

cd .dotfiles/

git add .
git commit -m "$now"
git push

echo -e "All done 🎉🎉🎉"
