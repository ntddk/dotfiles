#!bin/bash
sudo apt-get install -y build-essential libcap-dev cmake libboost-all-dev libcapstone-dev gcc-multilib
git clone https://github.com/Z3Prover/z3
cd z3
sudo python -E scripts/mk_make.py --python
cd build
make -j $(nproc)
sudo make install
sudo cp libz3.so /usr/local/
cd
wget http://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-71313-gcc.4.4.7-linux.tar.gz
tar xvf pin-2.14-71313-gcc.4.4.7-linux.tar.gz
cd pin-2.14-71313-gcc.4.4.7-linux/source/tools/
git clone https://github.com/JonathanSalwan/Triton.git
cd Triton
mkdir build
cd build
cmake -DPINTOOL=on -DKERNEL4=on ..
make -j $(nproc)
sudo make install
cd
ln -s ~/pin-2.14-71313-gcc.4.4.7-linux pin
ln -s ~/pin-2.14-71313-gcc.4.4.7-linux/source/tools/Triton triton

