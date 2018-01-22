#!/usr/bin/env bash
#
# This is only to be used by travis-ci

git clone http://code.transifex.com/transifex-client > /dev/null || exit 1
cd transifex-client || exit 1
python setup.py install --user > /dev/null

echo "[https://www.transifex.com]" > ~/.transifexrc
echo "hostname = https://www.transifex.com" >> ~/.transifexrc
echo "password = $TRANSIFEX" >> ~/.transifexrc
echo "token = " >> ~/.transifexrc
echo "username = tanghus" >> ~/.transifexrc

cd ../translations

~/.local/bin/tx push -s en_GB.ts || exit 1
~/.local/bin/tx pull --all || exit 1

rm  ~/.transifexrc


