##############################################################
# Creator: Necrolord
# Version: 0.0.1
# Date: 12/10/2018
# Goal: LAMP Server installation.
# Additional Notes: Please refer the ADDITIONAL NOTES file.
##############################################################
#!/usr/bin/bash

echo "Welcome to Gitlab Installation script"

Checkroot()
{
if [ $(id -u) != "0" ]; then
		echo "You are not root , Exiting"
		exit 1;
	fi
}

Menu()
{
echo "Would you like to install Gitlab?"
select fire in "Yes" "No"
	do
	case $fire in
		Yes)
	GitlabIns
		;;
		No)
	echo "Are you sure ? "
		;;
		*)
		 echo "Please enter a Valid Selection"
	 esac
 done
}

GitlabIns()
{
  echo "Which distro you'll want to install Gitlab? "
  select distro in "Debian" "Centos7"
    do
    case $distro in
      Debian)
      DebGitIns
      ;;
      Centos7)
      CentosGitIns
      ;;
      *)
        echo "Please enter a Valid selection"
    esac
  done
}

DebGitIns()
{
  echo "Welcome to Debian Git installation script !"
  echo "Let's just make sure your on Debian/Ubuntu Distro"
  ans=$(cat /etc/*-release |grep 'ID='|grep -v 'VERSION*'|awk -F= '{ print $2}')
  if [[ $ans = debian ]]; then
  	:
  else
    echo "Are you sure your using Debian distro?"
    GitlabIns
		:
  fi
  apt-get install -y curl openssh-server ca-certificates
  apt-get install -y postfix
  echo "We will need to add GitLab to the package repo "
  sleep 5
  curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh
  read -p "Please enter the domain name you'd like to gitlab configure access (eg. gitlab.example.com)" labans
  echo "Now we will put the domain name on the link and Install gitlab"
  EXTERNAL_URL="$labans" apt-get install gitlab-ee
  if [[ $? = 0 ]]; then
    echo "Hurray ! you have gitlab installed on $labans now just open your browser and start using it"
    echo "Don't forget the username is root and you'll need to make a password on your first login."
  exit 0
  fi
}

sleep 5
  CentosGitIns()
  {
  cat /etc/*-release |grep ID |cut  -d '=' -f '2' |egrep "^\"centos\"$"
  if [[ $? -eq 0 ]]; then
    :
  else
    echo "Are you sure your using Centos Distro?"
    GitlabIns
  fi
  yum install postfix
  echo "We will need to add GitLab to the package repo "
  sleep 5
  curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh
  read -p "Please enter the domain name you'd like to gitlab configure access (eg. gitlab.example.com)" labans
  echo "Now we will put the domain name on the link and Install gitlab"
  EXTERNAL_URL="$labans" apt-get install gitlab-ee
  if [[ $? = 0 ]]; then
    echo "Hurray ! you have gitlab installed on $labans now just open your browser and start using it"
    echo "Don't forget the username is root and you'll need to make a password on your first login."
  sleep 5
  exit 0
  fi
}

Checkroot
Menu
