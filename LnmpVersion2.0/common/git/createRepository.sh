#!/bin/bash
echo "--------------------------------------------------"
echo "the base repository path is : /windows/GitRepository/"
echo "unit directory name :"
read unitDirectoryName leftover
echo "git work tree ( example : /windows/website/chunio ) :"
read gitWorkTree leftover
baseRepositoryPath='/windows/GitRepository/'
unitGitRepository=$baseRepositoryPath$unitDirectoryName
#-----
ls $unitGitRepository &> /dev/null
if [ $? -ne 0 ];then
	mkdir -p $unitGitRepository
fi
#-----
ls $gitWorkTree &> /dev/null
if [ $? -ne 0 ];then
	mkdir -p $gitWorkTree
fi
#-----
cd $unitGitRepository
git init --bare
git config receive.denyCurrentBranch ignore
#hooks,start-----
echo '#!/bin/sh
echo ".git/hooks/post-receive,start--------------------"
GIT_DIR='$unitGitRepository/'
GIT_WORK_TREE='$gitWorkTree' git checkout -f
git fetch --all
git reset --hard
date
echo ".git/hooks/post-receive,end--------------------"' > $unitGitRepository/hooks/post-receive
chmod -R 777 $gitWorkTree
chown -R git:git $gitWorkTree
chmod -R 777 $unitGitRepository
chown -R git:git $unitGitRepository
#hooks,end-----
echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"
exit 0