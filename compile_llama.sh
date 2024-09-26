make -C llama.cpp/ clean &&
# make -C llama.cpp/ -j 32
make -C llama.cpp/ -j 32 AMDGPU_TARGETS=gfx908 \
                        GGML_HIPBLAS=1 \
                        GGML_CUDA_NO_PEER_COPY=1                    
                        
# GGML_CUDA_FORCE_MMQ=1 \
# GGML_DEBUG=1 \
# LLAMA_PERF=1

