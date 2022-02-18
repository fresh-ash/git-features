#!/bin/bash


#Create merge config file
echo "
#!/bin/bash 
echo \"-o merge_request.create
-o merge_request.target=master
-o merge_request.merge_when_pipeline_succeeds
-o merge_request.title=<title>
-o merge_request.description=<description>
-o merge_request.label=<label>
-o merge_request.assign=<user>
-o merge_request.unassign=<user>
-o merge_request.should_remove_source_branch
-o merge_request.unlabel=<label>
origin \$1 \" > config
vi config
" > $HOME/merge_config.sh
sudo chmod 777 $HOME/merge_config.sh
#Create custom .gitconfig file

echo "
[user]
	email = $1
	name = $2
[core]
	editor = vi
[alias]
	c = config
	cg = config --global
	branches = branch -l
	brs = branch -l
	myhelp = \"!echo cg - config --global; echo brs - branch -l; echo pb - checkout previous branch; echo h - help custom commands; echo fl - formatted log; echo mr - merge request\"
	h = myhelp
	pb = checkout @{-1}
	fl = log -p --pretty=format:'--------------------------------------%n%Cred%h %Creset%cd %n%Cblue%s%d%n[%an] | %Cgreen[%cn]'
	mr = \"!\$HOME/merge_config.sh \$(git branch --show-current); git push \$(cat config); rm config\"
" > $HOME/.gitconfig
