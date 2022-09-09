#!/bin/sh

backupPaths="./backup.conf"

homeDir=~
dotfilesDir="$homeDir/.dotfiles"

echo -e "Starting Backup 🐎🐎🐎"

echo -e "Removing old dotfiles 🗑️"
rm -f .dotfiles/*.gz

sed '/^[ \t]*$/d' $backupPaths | while read filePath; do
    echo -e "Backing-up $filePath"

    findThis="~/"
    replaceWith="$homeDir/"
    originalFile="${filePath//${findThis}/${replaceWith}}"

    cp -r $originalFile .dotfiles/
    sleep 0.05
done

echo -e "Done ✅"

echo -e "Generating installed package lists ✍️✍️✍️"

./getPackages.sh

now=$(date +%D)
nowF=${now//\//-}
echo -e "Compressing dotfiles 🗜️"
tar -czf .dotfiles/dotfiles-$nowF.tar.gz .dotfiles/*

echo -e "Cleaning up 🧹"
sed '/^[ \t]*$/d' $backupPaths | while read filePath; do
    findThis="~/"
    replaceWith="$dotfilesDir/"
    originalFile="${filePath//${findThis}/${replaceWith}}"

    rm -fr $originalFile
    sleep 0.05
done
rm -f .dotfiles/*.txt
echo -e "Done ✅"

echo -e "Committing Dotfiles 📝📝📝"
cd .dotfiles
git add .
git commit -m "$nowF"
git push

echo -e "All done 🎉🎉🎉"
