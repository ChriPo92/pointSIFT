#/bin/bash
#/usr/local/cuda-8.0/bin/nvcc pointSIFT.cu -o pointSIFT_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

# TF1.4
#g++ -std=c++11 main.cpp pointSIFT_g.cu.o -o tf_pointSIFT_so.so -shared -fPIC -I /home/jmydurant/anaconda3/envs/pointsift/lib/python3.5/site-packages/tensorflow/include -I /usr/local/cuda-8.0/include -I /home/jmydurant/anaconda3/envs/pointsift/lib/python3.5/site-packages/tensorflow/include/external/nsync/public -lcudart -L /usr/local/cuda-8.0/lib64/ -L/home/jmydurant/anaconda3/envs/pointsift/lib/python3.5/site-packages/tensorflow -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# TF1.12
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')
CUDA_PATH=/common/homes/all/pohl/install/cuda-9.0

nvcc -std=c++11 -c -o pointSIFT_g.cu.o pointSIFT.cu \
	-I $TF_INC -I$TF_INC/external/nsync/public -D GOOGLE_CUDA=1 \
	-x cu -Xcompiler -fPIC -arch=sm_50 -ccbin /usr/bin/g++-6 -D_GLIBCXX_USE_CXX11_ABI=0
/usr/bin/g++-6 -std=c++11 -shared -o tf_pointSIFT_so.so main.cpp \
	pointSIFT_g.cu.o -I $TF_INC -I$TF_INC/external/nsync/public -I $CUDA_PATH/include -fPIC \
	-lcudart -lcublas -L $CUDA_PATH/lib64 -L$TF_LIB -ltensorflow_framework -D_GLIBCXX_USE_CXX11_ABI=0
