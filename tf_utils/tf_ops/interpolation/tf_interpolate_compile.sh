# TF1.2
#g++ -std=c++11 tf_interpolate.cpp -o tf_interpolate_so.so -shared -fPIC -I /usr/local/lib/python2.7/dist-packages/tensorflow/include -I /usr/local/cuda-8.0/include -lcudart -L /usr/local/cuda-8.0/lib64/ -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# TF1.4
#g++ -std=c++11 tf_interpolate.cpp -o tf_interpolate_so.so -shared -fPIC -I /home/jmydurant/anaconda3/envs/pointsift/lib/python3.5/site-packages/tensorflow/include -I /usr/local/cuda-8.0/include -I /home/jmydurant/anaconda3/envs/pointsift/lib/python3.5/site-packages/tensorflow/include/external/nsync/public -lcudart -L /usr/local/cuda-8.0/lib64/ -L/home/jmydurant/anaconda3/envs/pointsift/lib/python3.5/site-packages/tensorflow -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0

TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')
CUDA_PATH=/common/homes/all/pohl/install/cuda-9.0

/usr/bin/g++-6 -std=c++11 -shared -o tf_interpolate_so.so tf_interpolate.cpp -I $TF_INC -I$TF_INC/external/nsync/public -I $CUDA_PATH/include -fPIC \
	-lcudart -lcublas -L $CUDA_PATH/lib64 -L$TF_LIB -ltensorflow_framework -D_GLIBCXX_USE_CXX11_ABI=0
