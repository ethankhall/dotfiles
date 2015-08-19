if [ "$(uname)" == "Darwin" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew install ansible
    ansible-galaxy install --ignore-errors --role-file requirements.yml
    ansible-playbook -i "localhost," -c local playbook.yml
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under Linux platform
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Nope."
fi
