sudo apt-get build-dep mecab
wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE" -O mecab-0.996.tar.gz
tar xvf mecab-0.996.tar.gz
cd mecab-0.996
./configure && make -j4 && sudo make install
sudo ldconfig
cd
wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM" -O mecab-ipadic-2.7.0-20070801.tar.gz
tar xvf mecab-ipadic-2.7.0-20070801.tar.gz
cd mecab-ipadic-2.7.0-20070801
./configure && make -j4 && sudo make install
cd
wget https://pypi.python.org/packages/86/e7/bfeba61fb1c5d1ddcd92bc9b9502f99f80bf71a03429a2b31218fc2d4da2/mecab-python-0.996.tar.gz
tar xvf mecab-python-0.996.tar.gz
cd mecab-python-0.996
python setup.py build
python setup.py install
cd
rm -rf mecab*.tar.gz
