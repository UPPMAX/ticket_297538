# ticket_297538

Notes for ticket 297538

## Attempt 8: Use `pip install triton` again

Simple again, with a `pip install triton`. WORKS!

```
Bootstrap: docker
From: condaforge/miniforge3

# From https://geniac.readthedocs.io/en/latest/conda.html#example2-activate-the-conda-environment-at-startup-with-singularity-exec-or-run
%environment
    export LC_ALL=en_US.utf-8
    export LANG=en_US.utf-8
    export BASH_ENV=/root/bashrc

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    # echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    echo "DEBUG 14"

    # Create and activate virtual python environment
    conda create -n dna python=3.8

    echo "DEBUG 19"

    conda init bash

    echo "DEBUG 23"

    echo -e "\nconda activate dna" >> ~/.bashrc
    echo -e "\nconda activate dna" >> /root/bashrc

    echo "DEBUG 28"

    pip install triton
    echo "DEBUG 31"

    pip install cmake

    echo "DEBUG 35"

    # pip install -e .

    echo "DEBUG 39"

    cd /opt
    git clone https://github.com/MAGICS-LAB/DNABERT_2
    cd DNABERT_2

    echo "DEBUG 45"

    python3 -m pip install -r requirements.txt

%runscript
python3 "$@"
```

```
richel@richel-N141CU:~/GitHubs/ticket_297538$ time sudo singularity build dnabert2_with_triton.def dnabert2_with_triton_8.def 
INFO:    Starting build...
INFO:    Fetching OCI image...
119.3MiB / 119.3MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
26.2MiB / 26.2MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Running post scriptlet
+ echo DEBUG 14
DEBUG 14
+ conda create -n dna python=3.8
Channels:
 - conda-forge
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
    current version: 24.3.0
    latest version: 24.7.1

Please update conda by running

    $ conda update -n base -c conda-forge conda



## Package Plan ##

  environment location: /opt/conda/envs/dna

  added / updated specs:
    - python=3.8


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    _libgcc_mutex-0.1          |      conda_forge           3 KB  conda-forge
    _openmp_mutex-4.5          |            2_gnu          23 KB  conda-forge
    bzip2-1.0.8                |       h4bc722e_7         247 KB  conda-forge
    ca-certificates-2024.8.30  |       hbcca054_0         155 KB  conda-forge
    ld_impl_linux-64-2.40      |       hf3520f5_7         691 KB  conda-forge
    libffi-3.4.2               |       h7f98852_5          57 KB  conda-forge
    libgcc-14.1.0              |       h77fa898_1         827 KB  conda-forge
    libgcc-ng-14.1.0           |       h69a702a_1          51 KB  conda-forge
    libgomp-14.1.0             |       h77fa898_1         449 KB  conda-forge
    libnsl-2.0.1               |       hd590300_0          33 KB  conda-forge
    libsqlite-3.46.0           |       hde9e2c9_0         845 KB  conda-forge
    libuuid-2.38.1             |       h0b41bf4_0          33 KB  conda-forge
    libxcrypt-4.4.36           |       hd590300_1          98 KB  conda-forge
    libzlib-1.3.1              |       h4ab18f5_1          60 KB  conda-forge
    ncurses-6.5                |       he02047a_1         868 KB  conda-forge
    openssl-3.3.1              |       hb9d3cd8_3         2.8 MB  conda-forge
    pip-24.2                   |     pyh8b19718_1         1.2 MB  conda-forge
    python-3.8.19              |hd12c33a_0_cpython        21.3 MB  conda-forge
    readline-8.2               |       h8228510_1         275 KB  conda-forge
    setuptools-72.2.0          |     pyhd8ed1ab_0         1.4 MB  conda-forge
    tk-8.6.13                  |noxft_h4845f30_101         3.2 MB  conda-forge
    wheel-0.44.0               |     pyhd8ed1ab_0          57 KB  conda-forge
    xz-5.2.6                   |       h166bdaf_0         409 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        34.9 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge 
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-2_gnu 
  bzip2              conda-forge/linux-64::bzip2-1.0.8-h4bc722e_7 
  ca-certificates    conda-forge/linux-64::ca-certificates-2024.8.30-hbcca054_0 
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.40-hf3520f5_7 
  libffi             conda-forge/linux-64::libffi-3.4.2-h7f98852_5 
  libgcc             conda-forge/linux-64::libgcc-14.1.0-h77fa898_1 
  libgcc-ng          conda-forge/linux-64::libgcc-ng-14.1.0-h69a702a_1 
  libgomp            conda-forge/linux-64::libgomp-14.1.0-h77fa898_1 
  libnsl             conda-forge/linux-64::libnsl-2.0.1-hd590300_0 
  libsqlite          conda-forge/linux-64::libsqlite-3.46.0-hde9e2c9_0 
  libuuid            conda-forge/linux-64::libuuid-2.38.1-h0b41bf4_0 
  libxcrypt          conda-forge/linux-64::libxcrypt-4.4.36-hd590300_1 
  libzlib            conda-forge/linux-64::libzlib-1.3.1-h4ab18f5_1 
  ncurses            conda-forge/linux-64::ncurses-6.5-he02047a_1 
  openssl            conda-forge/linux-64::openssl-3.3.1-hb9d3cd8_3 
  pip                conda-forge/noarch::pip-24.2-pyh8b19718_1 
  python             conda-forge/linux-64::python-3.8.19-hd12c33a_0_cpython 
  readline           conda-forge/linux-64::readline-8.2-h8228510_1 
  setuptools         conda-forge/noarch::setuptools-72.2.0-pyhd8ed1ab_0 
  tk                 conda-forge/linux-64::tk-8.6.13-noxft_h4845f30_101 
  wheel              conda-forge/noarch::wheel-0.44.0-pyhd8ed1ab_0 
  xz                 conda-forge/linux-64::xz-5.2.6-h166bdaf_0 


Proceed ([y]/n)? 

Downloading and Extracting Packages:
                                                                                                                                                                                       
Preparing transaction: done                                                                                                                                                            
Verifying transaction: done                                                                                                                                                            
Executing transaction: done                                                                                                                                                            
#                                                                                                                                                                                      
# To activate this environment, use                                                                                                                                                    
#                                                                                                                                                                                      
#     $ conda activate dna                                                                                                                                                             
#                                                                                                                                                                                      
# To deactivate an active environment, use                                                                                                                                             
#                                                                                                                                                                                      
#     $ conda deactivate                                                                                                                                                               
                                                                                                                                                                                       
+ echo DEBUG 19                                                                                                                                                                        
DEBUG 19                                                                                                                                                                               
+ conda init bash                                                                                                                                                                      
no change     /opt/conda/condabin/conda                                                                                                                                                
no change     /opt/conda/bin/conda                                                                                                                                                     
no change     /opt/conda/bin/conda-env                                                                                                                                                 
no change     /opt/conda/bin/activate                                                                                                                                                  
no change     /opt/conda/bin/deactivate                                                                                                                                                
no change     /opt/conda/etc/profile.d/conda.sh                                                                                                                                        
no change     /opt/conda/etc/fish/conf.d/conda.fish                                                                                                                                    
no change     /opt/conda/shell/condabin/Conda.psm1
no change     /opt/conda/shell/condabin/conda-hook.ps1
no change     /opt/conda/lib/python3.10/site-packages/xontrib/conda.xsh
no change     /opt/conda/etc/profile.d/conda.csh
modified      /root/.bashrc

==> For changes to take effect, close and re-open your current shell. <==

+ echo DEBUG 23
DEBUG 23
+ echo -e \nconda activate dna
+ echo -e \nconda activate dna
+ echo DEBUG 28
DEBUG 28
+ pip install triton
Collecting triton
  Downloading triton-3.0.0-1-cp310-cp310-manylinux2014_x86_64.manylinux_2_17_x86_64.whl.metadata (1.3 kB)
Collecting filelock (from triton)
  Downloading filelock-3.15.4-py3-none-any.whl.metadata (2.9 kB)
Downloading triton-3.0.0-1-cp310-cp310-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (209.4 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 209.4/209.4 MB 6.0 MB/s eta 0:00:00
Downloading filelock-3.15.4-py3-none-any.whl (16 kB)
Installing collected packages: filelock, triton
Successfully installed filelock-3.15.4 triton-3.0.0
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
+ echo DEBUG 31
DEBUG 31
+ pip install cmake
Collecting cmake
  Downloading cmake-3.30.2-py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (6.1 kB)
Downloading cmake-3.30.2-py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (26.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 26.9/26.9 MB 9.4 MB/s eta 0:00:00
Installing collected packages: cmake
Successfully installed cmake-3.30.2
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
+ echo DEBUG 35
DEBUG 35
+ echo DEBUG 39
DEBUG 39
+ cd /opt
+ git clone https://github.com/MAGICS-LAB/DNABERT_2
Cloning into 'DNABERT_2'...
remote: Enumerating objects: 98, done.
remote: Counting objects: 100% (34/34), done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 98 (delta 18), reused 24 (delta 15), pack-reused 64 (from 1)
Unpacking objects: 100% (98/98), 870.86 KiB | 3.51 MiB/s, done.
+ cd DNABERT_2
+ echo DEBUG 45
DEBUG 45
+ python3 -m pip install -r requirements.txt
Collecting einops (from -r requirements.txt (line 1))
  Downloading einops-0.8.0-py3-none-any.whl.metadata (12 kB)
Collecting transformers==4.29.2 (from -r requirements.txt (line 2))
  Downloading transformers-4.29.2-py3-none-any.whl.metadata (112 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 112.3/112.3 kB 4.1 MB/s eta 0:00:00
Collecting peft (from -r requirements.txt (line 3))
  Downloading peft-0.12.0-py3-none-any.whl.metadata (13 kB)
Collecting omegaconf (from -r requirements.txt (line 4))
  Downloading omegaconf-2.3.0-py3-none-any.whl.metadata (3.9 kB)
Collecting torch (from -r requirements.txt (line 5))
  Downloading torch-2.4.0-cp310-cp310-manylinux1_x86_64.whl.metadata (26 kB)
Collecting evaluate (from -r requirements.txt (line 6))
  Downloading evaluate-0.4.2-py3-none-any.whl.metadata (9.3 kB)
Collecting accelerate (from -r requirements.txt (line 7))
  Downloading accelerate-0.33.0-py3-none-any.whl.metadata (18 kB)
Requirement already satisfied: filelock in /opt/conda/lib/python3.10/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (3.15.4)
Collecting huggingface-hub<1.0,>=0.14.1 (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading huggingface_hub-0.24.6-py3-none-any.whl.metadata (13 kB)
Collecting numpy>=1.17 (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading numpy-2.1.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (60 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 60.9/60.9 kB 7.4 MB/s eta 0:00:00
Requirement already satisfied: packaging>=20.0 in /opt/conda/lib/python3.10/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (24.0)
Collecting pyyaml>=5.1 (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading PyYAML-6.0.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (2.1 kB)
Collecting regex!=2019.12.17 (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading regex-2024.7.24-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (40 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 40.5/40.5 kB 2.7 MB/s eta 0:00:00
Requirement already satisfied: requests in /opt/conda/lib/python3.10/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2.31.0)
Collecting tokenizers!=0.11.3,<0.14,>=0.11.1 (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading tokenizers-0.13.3-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (6.7 kB)
Requirement already satisfied: tqdm>=4.27 in /opt/conda/lib/python3.10/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (4.66.2)
Collecting psutil (from peft->-r requirements.txt (line 3))
  Downloading psutil-6.0.0-cp36-abi3-manylinux_2_12_x86_64.manylinux2010_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (21 kB)
Collecting safetensors (from peft->-r requirements.txt (line 3))
  Downloading safetensors-0.4.4-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (3.8 kB)
Collecting antlr4-python3-runtime==4.9.* (from omegaconf->-r requirements.txt (line 4))
  Downloading antlr4-python3-runtime-4.9.3.tar.gz (117 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 117.0/117.0 kB 9.0 MB/s eta 0:00:00
  Preparing metadata (setup.py) ... done
Collecting typing-extensions>=4.8.0 (from torch->-r requirements.txt (line 5))
  Downloading typing_extensions-4.12.2-py3-none-any.whl.metadata (3.0 kB)
Collecting sympy (from torch->-r requirements.txt (line 5))
  Downloading sympy-1.13.2-py3-none-any.whl.metadata (12 kB)
Collecting networkx (from torch->-r requirements.txt (line 5))
  Downloading networkx-3.3-py3-none-any.whl.metadata (5.1 kB)
Collecting jinja2 (from torch->-r requirements.txt (line 5))
  Downloading jinja2-3.1.4-py3-none-any.whl.metadata (2.6 kB)
Collecting fsspec (from torch->-r requirements.txt (line 5))
  Downloading fsspec-2024.6.1-py3-none-any.whl.metadata (11 kB)
Collecting nvidia-cuda-nvrtc-cu12==12.1.105 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cuda_nvrtc_cu12-12.1.105-py3-none-manylinux1_x86_64.whl.metadata (1.5 kB)
Collecting nvidia-cuda-runtime-cu12==12.1.105 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cuda_runtime_cu12-12.1.105-py3-none-manylinux1_x86_64.whl.metadata (1.5 kB)
Collecting nvidia-cuda-cupti-cu12==12.1.105 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cuda_cupti_cu12-12.1.105-py3-none-manylinux1_x86_64.whl.metadata (1.6 kB)
Collecting nvidia-cudnn-cu12==9.1.0.70 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cudnn_cu12-9.1.0.70-py3-none-manylinux2014_x86_64.whl.metadata (1.6 kB)
Collecting nvidia-cublas-cu12==12.1.3.1 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cublas_cu12-12.1.3.1-py3-none-manylinux1_x86_64.whl.metadata (1.5 kB)
Collecting nvidia-cufft-cu12==11.0.2.54 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cufft_cu12-11.0.2.54-py3-none-manylinux1_x86_64.whl.metadata (1.5 kB)
Collecting nvidia-curand-cu12==10.3.2.106 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_curand_cu12-10.3.2.106-py3-none-manylinux1_x86_64.whl.metadata (1.5 kB)
Collecting nvidia-cusolver-cu12==11.4.5.107 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cusolver_cu12-11.4.5.107-py3-none-manylinux1_x86_64.whl.metadata (1.6 kB)
Collecting nvidia-cusparse-cu12==12.1.0.106 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_cusparse_cu12-12.1.0.106-py3-none-manylinux1_x86_64.whl.metadata (1.6 kB)
Collecting nvidia-nccl-cu12==2.20.5 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_nccl_cu12-2.20.5-py3-none-manylinux2014_x86_64.whl.metadata (1.8 kB)
Collecting nvidia-nvtx-cu12==12.1.105 (from torch->-r requirements.txt (line 5))
  Downloading nvidia_nvtx_cu12-12.1.105-py3-none-manylinux1_x86_64.whl.metadata (1.7 kB)
Requirement already satisfied: triton==3.0.0 in /opt/conda/lib/python3.10/site-packages (from torch->-r requirements.txt (line 5)) (3.0.0)
Collecting nvidia-nvjitlink-cu12 (from nvidia-cusolver-cu12==11.4.5.107->torch->-r requirements.txt (line 5))
  Downloading nvidia_nvjitlink_cu12-12.6.68-py3-none-manylinux2014_x86_64.whl.metadata (1.5 kB)
Collecting datasets>=2.0.0 (from evaluate->-r requirements.txt (line 6))
  Downloading datasets-2.21.0-py3-none-any.whl.metadata (21 kB)
Collecting dill (from evaluate->-r requirements.txt (line 6))
  Downloading dill-0.3.8-py3-none-any.whl.metadata (10 kB)
Collecting pandas (from evaluate->-r requirements.txt (line 6))
  Downloading pandas-2.2.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (19 kB)
Collecting xxhash (from evaluate->-r requirements.txt (line 6))
  Downloading xxhash-3.5.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (12 kB)
Collecting multiprocess (from evaluate->-r requirements.txt (line 6))
  Downloading multiprocess-0.70.16-py310-none-any.whl.metadata (7.2 kB)
Collecting numpy>=1.17 (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading numpy-1.26.4-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (61 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 61.0/61.0 kB 5.2 MB/s eta 0:00:00
Collecting pyarrow>=15.0.0 (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading pyarrow-17.0.0-cp310-cp310-manylinux_2_28_x86_64.whl.metadata (3.3 kB)
Collecting requests (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading requests-2.32.3-py3-none-any.whl.metadata (4.6 kB)
Collecting tqdm>=4.27 (from transformers==4.29.2->-r requirements.txt (line 2))
  Downloading tqdm-4.66.5-py3-none-any.whl.metadata (57 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 57.6/57.6 kB 5.7 MB/s eta 0:00:00
Collecting aiohttp (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading aiohttp-3.10.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (7.5 kB)
Requirement already satisfied: charset-normalizer<4,>=2 in /opt/conda/lib/python3.10/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (3.3.2)
Requirement already satisfied: idna<4,>=2.5 in /opt/conda/lib/python3.10/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (3.6)
Requirement already satisfied: urllib3<3,>=1.21.1 in /opt/conda/lib/python3.10/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2.2.1)
Requirement already satisfied: certifi>=2017.4.17 in /opt/conda/lib/python3.10/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2024.2.2)
Collecting MarkupSafe>=2.0 (from jinja2->torch->-r requirements.txt (line 5))
  Downloading MarkupSafe-2.1.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (3.0 kB)
Collecting python-dateutil>=2.8.2 (from pandas->evaluate->-r requirements.txt (line 6))
  Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl.metadata (8.4 kB)
Collecting pytz>=2020.1 (from pandas->evaluate->-r requirements.txt (line 6))
  Downloading pytz-2024.1-py2.py3-none-any.whl.metadata (22 kB)
Collecting tzdata>=2022.7 (from pandas->evaluate->-r requirements.txt (line 6))
  Downloading tzdata-2024.1-py2.py3-none-any.whl.metadata (1.4 kB)
Collecting mpmath<1.4,>=1.1.0 (from sympy->torch->-r requirements.txt (line 5))
  Downloading mpmath-1.3.0-py3-none-any.whl.metadata (8.6 kB)
Collecting aiohappyeyeballs>=2.3.0 (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading aiohappyeyeballs-2.4.0-py3-none-any.whl.metadata (5.9 kB)
Collecting aiosignal>=1.1.2 (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading aiosignal-1.3.1-py3-none-any.whl.metadata (4.0 kB)
Collecting attrs>=17.3.0 (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading attrs-24.2.0-py3-none-any.whl.metadata (11 kB)
Collecting frozenlist>=1.1.1 (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading frozenlist-1.4.1-cp310-cp310-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (12 kB)
Collecting multidict<7.0,>=4.5 (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading multidict-6.0.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (4.2 kB)
Collecting yarl<2.0,>=1.0 (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading yarl-1.9.7-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (39 kB)
Collecting async-timeout<5.0,>=4.0 (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6))
  Downloading async_timeout-4.0.3-py3-none-any.whl.metadata (4.2 kB)
Collecting six>=1.5 (from python-dateutil>=2.8.2->pandas->evaluate->-r requirements.txt (line 6))
  Downloading six-1.16.0-py2.py3-none-any.whl.metadata (1.8 kB)
Downloading transformers-4.29.2-py3-none-any.whl (7.1 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.1/7.1 MB 8.6 MB/s eta 0:00:00
Downloading einops-0.8.0-py3-none-any.whl (43 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 43.2/43.2 kB 3.8 MB/s eta 0:00:00
Downloading peft-0.12.0-py3-none-any.whl (296 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 296.4/296.4 kB 9.4 MB/s eta 0:00:00
Downloading omegaconf-2.3.0-py3-none-any.whl (79 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 79.5/79.5 kB 7.6 MB/s eta 0:00:00
Downloading torch-2.4.0-cp310-cp310-manylinux1_x86_64.whl (797.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 797.2/797.2 MB 1.6 MB/s eta 0:00:00
Downloading nvidia_cublas_cu12-12.1.3.1-py3-none-manylinux1_x86_64.whl (410.6 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 410.6/410.6 MB 3.2 MB/s eta 0:00:00
Downloading nvidia_cuda_cupti_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (14.1 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 14.1/14.1 MB 9.9 MB/s eta 0:00:00
Downloading nvidia_cuda_nvrtc_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (23.7 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 23.7/23.7 MB 9.4 MB/s eta 0:00:00
Downloading nvidia_cuda_runtime_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (823 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 823.6/823.6 kB 8.4 MB/s eta 0:00:00
Downloading nvidia_cudnn_cu12-9.1.0.70-py3-none-manylinux2014_x86_64.whl (664.8 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 664.8/664.8 MB 1.8 MB/s eta 0:00:00
Downloading nvidia_cufft_cu12-11.0.2.54-py3-none-manylinux1_x86_64.whl (121.6 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 121.6/121.6 MB 4.4 MB/s eta 0:00:00
Downloading nvidia_curand_cu12-10.3.2.106-py3-none-manylinux1_x86_64.whl (56.5 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 56.5/56.5 MB 7.1 MB/s eta 0:00:00
Downloading nvidia_cusolver_cu12-11.4.5.107-py3-none-manylinux1_x86_64.whl (124.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 124.2/124.2 MB 5.2 MB/s eta 0:00:00
Downloading nvidia_cusparse_cu12-12.1.0.106-py3-none-manylinux1_x86_64.whl (196.0 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 196.0/196.0 MB 4.0 MB/s eta 0:00:00
Downloading nvidia_nccl_cu12-2.20.5-py3-none-manylinux2014_x86_64.whl (176.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 176.2/176.2 MB 4.4 MB/s eta 0:00:00
Downloading nvidia_nvtx_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (99 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 99.1/99.1 kB 4.4 MB/s eta 0:00:00
Downloading evaluate-0.4.2-py3-none-any.whl (84 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 84.1/84.1 kB 4.0 MB/s eta 0:00:00
Downloading accelerate-0.33.0-py3-none-any.whl (315 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 315.1/315.1 kB 5.4 MB/s eta 0:00:00
Downloading datasets-2.21.0-py3-none-any.whl (527 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 527.3/527.3 kB 8.4 MB/s eta 0:00:00
Downloading dill-0.3.8-py3-none-any.whl (116 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 116.3/116.3 kB 2.6 MB/s eta 0:00:00
Downloading fsspec-2024.6.1-py3-none-any.whl (177 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 177.6/177.6 kB 3.3 MB/s eta 0:00:00
Downloading huggingface_hub-0.24.6-py3-none-any.whl (417 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 417.5/417.5 kB 7.2 MB/s eta 0:00:00
Downloading numpy-1.26.4-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (18.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 18.2/18.2 MB 7.3 MB/s eta 0:00:00
Downloading PyYAML-6.0.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (751 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 751.2/751.2 kB 7.6 MB/s eta 0:00:00
Downloading regex-2024.7.24-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (776 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 776.5/776.5 kB 6.5 MB/s eta 0:00:00
Downloading requests-2.32.3-py3-none-any.whl (64 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 64.9/64.9 kB 2.0 MB/s eta 0:00:00
Downloading safetensors-0.4.4-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (435 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 435.5/435.5 kB 7.7 MB/s eta 0:00:00
Downloading tokenizers-0.13.3-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (7.8 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.8/7.8 MB 6.9 MB/s eta 0:00:00
Downloading tqdm-4.66.5-py3-none-any.whl (78 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 78.4/78.4 kB 4.6 MB/s eta 0:00:00
Downloading typing_extensions-4.12.2-py3-none-any.whl (37 kB)
Downloading jinja2-3.1.4-py3-none-any.whl (133 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 133.3/133.3 kB 4.5 MB/s eta 0:00:00
Downloading multiprocess-0.70.16-py310-none-any.whl (134 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.8/134.8 kB 4.0 MB/s eta 0:00:00
Downloading networkx-3.3-py3-none-any.whl (1.7 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.7/1.7 MB 7.0 MB/s eta 0:00:00
Downloading pandas-2.2.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (13.0 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 13.0/13.0 MB 7.6 MB/s eta 0:00:00
Downloading psutil-6.0.0-cp36-abi3-manylinux_2_12_x86_64.manylinux2010_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (290 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 290.5/290.5 kB 6.8 MB/s eta 0:00:00
Downloading sympy-1.13.2-py3-none-any.whl (6.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6.2/6.2 MB 7.1 MB/s eta 0:00:00
Downloading xxhash-3.5.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (194 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 194.1/194.1 kB 3.7 MB/s eta 0:00:00
Downloading aiohttp-3.10.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.2/1.2 MB 7.4 MB/s eta 0:00:00
Downloading MarkupSafe-2.1.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (25 kB)
Downloading mpmath-1.3.0-py3-none-any.whl (536 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 536.2/536.2 kB 5.3 MB/s eta 0:00:00
Downloading pyarrow-17.0.0-cp310-cp310-manylinux_2_28_x86_64.whl (39.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 39.9/39.9 MB 6.1 MB/s eta 0:00:00
Downloading python_dateutil-2.9.0.post0-py2.py3-none-any.whl (229 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 229.9/229.9 kB 6.0 MB/s eta 0:00:00
Downloading pytz-2024.1-py2.py3-none-any.whl (505 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 505.5/505.5 kB 5.8 MB/s eta 0:00:00
Downloading tzdata-2024.1-py2.py3-none-any.whl (345 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 345.4/345.4 kB 6.9 MB/s eta 0:00:00
Downloading nvidia_nvjitlink_cu12-12.6.68-py3-none-manylinux2014_x86_64.whl (19.7 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 19.7/19.7 MB 6.3 MB/s eta 0:00:00
Downloading aiohappyeyeballs-2.4.0-py3-none-any.whl (12 kB)
Downloading aiosignal-1.3.1-py3-none-any.whl (7.6 kB)
Downloading async_timeout-4.0.3-py3-none-any.whl (5.7 kB)
Downloading attrs-24.2.0-py3-none-any.whl (63 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 63.0/63.0 kB 3.5 MB/s eta 0:00:00
Downloading frozenlist-1.4.1-cp310-cp310-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (239 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 239.5/239.5 kB 6.0 MB/s eta 0:00:00
Downloading multidict-6.0.5-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (124 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 124.3/124.3 kB 5.6 MB/s eta 0:00:00
Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Downloading yarl-1.9.7-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (467 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 467.3/467.3 kB 6.1 MB/s eta 0:00:00
Building wheels for collected packages: antlr4-python3-runtime
  Building wheel for antlr4-python3-runtime (setup.py) ... done
  Created wheel for antlr4-python3-runtime: filename=antlr4_python3_runtime-4.9.3-py3-none-any.whl size=144554 sha256=0f5403cfe10303c1ab1da94dc217fc1c1d1e76e45929c4bcb6ae4d2fa817b7a9
  Stored in directory: /root/.cache/pip/wheels/12/93/dd/1f6a127edc45659556564c5730f6d4e300888f4bca2d4c5a88
Successfully built antlr4-python3-runtime
Installing collected packages: tokenizers, pytz, mpmath, antlr4-python3-runtime, xxhash, tzdata, typing-extensions, tqdm, sympy, six, safetensors, requests, regex, pyyaml, psutil, nvidia-nvtx-cu12, nvidia-nvjitlink-cu12, nvidia-nccl-cu12, nvidia-curand-cu12, nvidia-cufft-cu12, nvidia-cuda-runtime-cu12, nvidia-cuda-nvrtc-cu12, nvidia-cuda-cupti-cu12, nvidia-cublas-cu12, numpy, networkx, multidict, MarkupSafe, fsspec, frozenlist, einops, dill, attrs, async-timeout, aiohappyeyeballs, yarl, python-dateutil, pyarrow, omegaconf, nvidia-cusparse-cu12, nvidia-cudnn-cu12, multiprocess, jinja2, huggingface-hub, aiosignal, transformers, pandas, nvidia-cusolver-cu12, aiohttp, torch, datasets, accelerate, peft, evaluate
  Attempting uninstall: tqdm
    Found existing installation: tqdm 4.66.2
    Uninstalling tqdm-4.66.2:
      Successfully uninstalled tqdm-4.66.2
  Attempting uninstall: requests
    Found existing installation: requests 2.31.0
    Uninstalling requests-2.31.0:
      Successfully uninstalled requests-2.31.0
Successfully installed MarkupSafe-2.1.5 accelerate-0.33.0 aiohappyeyeballs-2.4.0 aiohttp-3.10.5 aiosignal-1.3.1 antlr4-python3-runtime-4.9.3 async-timeout-4.0.3 attrs-24.2.0 datasets-2.21.0 dill-0.3.8 einops-0.8.0 evaluate-0.4.2 frozenlist-1.4.1 fsspec-2024.6.1 huggingface-hub-0.24.6 jinja2-3.1.4 mpmath-1.3.0 multidict-6.0.5 multiprocess-0.70.16 networkx-3.3 numpy-1.26.4 nvidia-cublas-cu12-12.1.3.1 nvidia-cuda-cupti-cu12-12.1.105 nvidia-cuda-nvrtc-cu12-12.1.105 nvidia-cuda-runtime-cu12-12.1.105 nvidia-cudnn-cu12-9.1.0.70 nvidia-cufft-cu12-11.0.2.54 nvidia-curand-cu12-10.3.2.106 nvidia-cusolver-cu12-11.4.5.107 nvidia-cusparse-cu12-12.1.0.106 nvidia-nccl-cu12-2.20.5 nvidia-nvjitlink-cu12-12.6.68 nvidia-nvtx-cu12-12.1.105 omegaconf-2.3.0 pandas-2.2.2 peft-0.12.0 psutil-6.0.0 pyarrow-17.0.0 python-dateutil-2.9.0.post0 pytz-2024.1 pyyaml-6.0.2 regex-2024.7.24 requests-2.32.3 safetensors-0.4.4 six-1.16.0 sympy-1.13.2 tokenizers-0.13.3 torch-2.4.0 tqdm-4.66.5 transformers-4.29.2 typing-extensions-4.12.2 tzdata-2024.1 xxhash-3.5.0 yarl-1.9.7
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
INFO:    Adding environment to container
INFO:    Adding runscript
INFO:    Creating SIF file...
INFO:    Build complete: dnabert2_with_triton.def

real	11m18.047s
user	0m0.155s
sys	0m0.472s
```

## Attempt 7: start from Docker with Triton, use rocm/oai-triton

This failed based on the Docker container already, as no debug output is ever shown

```
Bootstrap: docker
From: rocm/oai-triton:latest

# From https://geniac.readthedocs.io/en/latest/conda.html#example2-activate-the-conda-environment-at-startup-with-singularity-exec-or-run
%environment
    export LC_ALL=en_US.utf-8
    export LANG=en_US.utf-8
    export BASH_ENV=/root/bashrc

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    # echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    echo "DEBUG 14"

    # Create and activate virtual python environment
    conda create -n dna python=3.8

    echo "DEBUG 19"

    conda init bash

    echo "DEBUG 23"

    echo -e "\nconda activate dna" >> ~/.bashrc
    echo -e "\nconda activate dna" >> /root/bashrc

    # Already installed (but how to check this?)
    # pip install triton

    echo "DEBUG 31"

    pip install cmake

    echo "DEBUG 35"

    pip install -e .

    echo "DEBUG 39"

    cd /opt
    git clone https://github.com/MAGICS-LAB/DNABERT_2
    cd DNABERT_2

    echo "DEBUG 45"

    python3 -m pip install -r requirements.txt

%runscript
python3 "$@"
```

```
richel@richel-N141CU:~/GitHubs/ticket_297538$ sudo time singularity build dnabert2_with_triton.def dnabert2_with_triton_7.def 
INFO:    Starting build...
INFO:    Fetching OCI image...
396.1MiB / 396.1MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
86.2KiB / 86.2KiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
27.3MiB / 27.3MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
2.1GiB / 2.1GiB [====================================================================================================================================================] 100 % 0.0 b/s 0s
1.3GiB / 1.3GiB [====================================================================================================================================================] 100 % 0.0 b/s 0s
2.9GiB / 2.9GiB [====================================================================================================================================================] 100 % 0.0 b/s 0s
1.1MiB / 1.1MiB [====================================================================================================================================================] 100 % 0.0 b/s 0s
97.4MiB / 97.4MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
292.2MiB / 292.2MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
6.1GiB / 6.1GiB [====================================================================================================================================================] 100 % 0.0 b/s 0s
1.6GiB / 1.6GiB [====================================================================================================================================================] 100 % 0.0 b/s 0s
115.8MiB / 115.8MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
209.1MiB / 209.1MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
15.2MiB / 15.2MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
INFO:    Extracting OCI image...
FATAL:   While performing build: packer failed to pack: while unpacking tmpfs: error unpacking rootfs: unpack entry: opt/conda/pkgs/numpy-base-1.18.5-py38h2f8d375_0/lib/python3.8/site-packages/numpy-1.18.5-py3.8.egg-info/PKG-INFO: link: no such file or directory
Command exited with non-zero status 255
615.23user 135.66system 11:43.80elapsed 106%CPU (0avgtext+0avgdata 211344maxresident)k
29990064inputs+84837160outputs (0major+54375minor)pagefaults 0swaps
```

## Attempt 6: start from Docker with Triton, use dustynv/openai-triton:r36.3.0

```
richel@richel-N141CU:~/GitHubs/ticket_297538$ sudo singularity build dnabert2_with_triton.def dnabert2_with_triton_6.def 
INFO:    Starting build...
INFO:    Fetching OCI image...
1.5GiB / 1.5GiB [==================================================================================================================================================] 100 % 4.8 MiB/s 0s
114.4KiB / 114.4KiB [==============================================================================================================================================] 100 % 4.8 MiB/s 0s
26.1MiB / 26.1MiB [================================================================================================================================================] 100 % 4.8 MiB/s 0s
214.6MiB / 214.6MiB [==============================================================================================================================================] 100 % 4.8 MiB/s 0s
3.2GiB / 3.2GiB [==================================================================================================================================================] 100 % 4.8 MiB/s 0s
20.8MiB / 20.8MiB [================================================================================================================================================] 100 % 4.8 MiB/s 0s
13.5MiB / 13.5MiB [================================================================================================================================================] 100 % 4.8 MiB/s 0s
16.3MiB / 16.3MiB [================================================================================================================================================] 100 % 4.8 MiB/s 0s
24.7MiB / 24.7MiB [================================================================================================================================================] 100 % 4.8 MiB/s 0s
315.1MiB / 315.1MiB [==============================================================================================================================================] 100 % 4.8 MiB/s 0s
211.0MiB / 211.0MiB [==============================================================================================================================================] 100 % 4.8 MiB/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Running post scriptlet
FATAL:   image targets 'arm64', cannot run on 'amd64'
FATAL:   While performing build: while running engine: exit status 255
```

```
Bootstrap: docker
From: dustynv/openai-triton:r36.3.0

# From https://geniac.readthedocs.io/en/latest/conda.html#example2-activate-the-conda-environment-at-startup-with-singularity-exec-or-run
%environment
    export LC_ALL=en_US.utf-8
    export LANG=en_US.utf-8
    export BASH_ENV=/root/bashrc

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    # echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    # Create and activate virtual python environment
    conda create -n dna python=3.8

    conda init bash

    echo -e "\nconda activate dna" >> ~/.bashrc
    echo -e "\nconda activate dna" >> /root/bashrc

    # Already installed (but how to check this?)
    # pip install triton

    pip install cmake

    echo "DEBUG 1"

    pip install -e .

    echo "DEBUG 2"

    cd /opt
    git clone https://github.com/MAGICS-LAB/DNABERT_2
    cd DNABERT_2

    echo "DEBUG 713"

    python3 -m pip install -r requirements.txt

%runscript
python3 "$@"
```

## Attempt 5: start from a Docker with Triton

From [here](https://github.com/MAGICS-LAB/DNABERT_2/issues/47#issuecomment-1849464182).

From `Zhihan1996`:

> The triton package is a bit tricky. If you fail to install from source, can you try pip install triton==2.0.0.dev20221103?

`@Zhihan1996`, I tried this, it does not work anymore (maybe it worked in the past..?):

```bash
pip install triton==2.0.0.dev20221103
ERROR: Could not find a version that satisfies the requirement triton==2.0.0.dev20221103 (from versions: 2.0.0, 2.1.0, 2.2.0, 2.3.0, 2.3.1, 3.0.0)
ERROR: No matching distribution found for triton==2.0.0.dev20221103
```

With Singularity script here for reference:

- [dnabert2_with_triton_5.def](dnabert2_with_triton_5.def)

Shared at [this DNABERT_2 Issue](https://github.com/MAGICS-LAB/DNABERT_2/issues/47#issuecomment-2323822519).

## Attempt 4: fixing new error


## Attempt 3: fixing new error until `socket.gaierror: [Errno -3] Temporary failure in name resolution`

```
Bootstrap: docker
From: condaforge/miniforge3

# From https://geniac.readthedocs.io/en/latest/conda.html#example2-activate-the-conda-environment-at-startup-with-singularity-exec-or-run
%environment
    export LC_ALL=en_US.utf-8
    export LANG=en_US.utf-8
    export BASH_ENV=/root/bashrc

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    # echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    # Create and activate virtual python environment
    conda create -n dna python=3.8

    # Must be done before a conda create
    # Error: CondaError: Run 'conda init' before 'conda activate'                                                                                                                                   
    # Use 'bash' at the end, from https://geniac.readthedocs.io/en/latest/conda.html#example2-activate-the-conda-environment-at-startup-with-singularity-exec-or-run 

    conda init bash

    # From https://stackoverflow.com/a/78456992
    # Error: 'source: not found'
    # source activate base
    #./activate base
    # Error: './activate: not found'
    # . activate base


    # From https://geniac.readthedocs.io/en/latest/conda.html#example1
    echo -e "\nconda activate dna" >> ~/.bashrc
    echo -e "\nconda activate dna" >> /root/bashrc
    # Gives error
    # conda activate dna

    # install triton from source
    cd /opt
    git clone https://github.com/openai/triton.git
    cd triton/python

    # Fixes 'No CMAKE_C_COMPILER could be found'
    # pip install gcc
    
    # apt-cache search gcc
    # apt search gcc
    # apt install gcc-10-base
    # apt-get install "g++"
    # apt-get install gcc
    # gcc --version
    # g++ --version
    # cd / ; find . | grep "g\\+\\+"
    # cd / ; find . | grep "gcc"

    pip install cmake
    pip install -e .

    # install required packages
    cd /opt
    git clone https://github.com/MAGICS-LAB/DNABERT_2
    cd DNABERT_2
    python3 -m pip install -r requirements.txt

%runscript
python3 "$@"
```

```
richel@richel-N141CU:~/GitHubs/ticket_297538$ ./create.sh 
[sudo] password for richel: 
INFO:    Starting build...
INFO:    Fetching OCI image...
119.3MiB / 119.3MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
26.2MiB / 26.2MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Running post scriptlet
+ conda create -n dna python=3.8
Channels:
 - conda-forge
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
    current version: 24.3.0
    latest version: 24.7.1

Please update conda by running

    $ conda update -n base -c conda-forge conda



## Package Plan ##

  environment location: /opt/conda/envs/dna

  added / updated specs:
    - python=3.8


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    _libgcc_mutex-0.1          |      conda_forge           3 KB  conda-forge
    _openmp_mutex-4.5          |            2_gnu          23 KB  conda-forge
    bzip2-1.0.8                |       h4bc722e_7         247 KB  conda-forge
    ca-certificates-2024.7.4   |       hbcca054_0         151 KB  conda-forge
    ld_impl_linux-64-2.40      |       hf3520f5_7         691 KB  conda-forge
    libffi-3.4.2               |       h7f98852_5          57 KB  conda-forge
    libgcc-14.1.0              |       h77fa898_1         827 KB  conda-forge
    libgcc-ng-14.1.0           |       h69a702a_1          51 KB  conda-forge
    libgomp-14.1.0             |       h77fa898_1         449 KB  conda-forge
    libnsl-2.0.1               |       hd590300_0          33 KB  conda-forge
    libsqlite-3.46.0           |       hde9e2c9_0         845 KB  conda-forge
    libuuid-2.38.1             |       h0b41bf4_0          33 KB  conda-forge
    libxcrypt-4.4.36           |       hd590300_1          98 KB  conda-forge
    libzlib-1.3.1              |       h4ab18f5_1          60 KB  conda-forge
    ncurses-6.5                |       he02047a_1         868 KB  conda-forge
    openssl-3.3.1              |       hb9d3cd8_3         2.8 MB  conda-forge
    pip-24.2                   |     pyhd8ed1ab_0         1.2 MB  conda-forge
    python-3.8.19              |hd12c33a_0_cpython        21.3 MB  conda-forge
    readline-8.2               |       h8228510_1         275 KB  conda-forge
    setuptools-72.2.0          |     pyhd8ed1ab_0         1.4 MB  conda-forge
    tk-8.6.13                  |noxft_h4845f30_101         3.2 MB  conda-forge
    wheel-0.44.0               |     pyhd8ed1ab_0          57 KB  conda-forge
    xz-5.2.6                   |       h166bdaf_0         409 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        34.9 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge 
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-2_gnu 
  bzip2              conda-forge/linux-64::bzip2-1.0.8-h4bc722e_7 
  ca-certificates    conda-forge/linux-64::ca-certificates-2024.7.4-hbcca054_0 
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.40-hf3520f5_7 
  libffi             conda-forge/linux-64::libffi-3.4.2-h7f98852_5 
  libgcc             conda-forge/linux-64::libgcc-14.1.0-h77fa898_1 
  libgcc-ng          conda-forge/linux-64::libgcc-ng-14.1.0-h69a702a_1 
  libgomp            conda-forge/linux-64::libgomp-14.1.0-h77fa898_1 
  libnsl             conda-forge/linux-64::libnsl-2.0.1-hd590300_0 
  libsqlite          conda-forge/linux-64::libsqlite-3.46.0-hde9e2c9_0 
  libuuid            conda-forge/linux-64::libuuid-2.38.1-h0b41bf4_0 
  libxcrypt          conda-forge/linux-64::libxcrypt-4.4.36-hd590300_1 
  libzlib            conda-forge/linux-64::libzlib-1.3.1-h4ab18f5_1 
  ncurses            conda-forge/linux-64::ncurses-6.5-he02047a_1 
  openssl            conda-forge/linux-64::openssl-3.3.1-hb9d3cd8_3 
  pip                conda-forge/noarch::pip-24.2-pyhd8ed1ab_0 
  python             conda-forge/linux-64::python-3.8.19-hd12c33a_0_cpython 
  readline           conda-forge/linux-64::readline-8.2-h8228510_1 
  setuptools         conda-forge/noarch::setuptools-72.2.0-pyhd8ed1ab_0 
  tk                 conda-forge/linux-64::tk-8.6.13-noxft_h4845f30_101 
  wheel              conda-forge/noarch::wheel-0.44.0-pyhd8ed1ab_0 
  xz                 conda-forge/linux-64::xz-5.2.6-h166bdaf_0 


Proceed ([y]/n)? 

Downloading and Extracting Packages:
                                                                                                                                                                                       
Preparing transaction: done                                                                                                                                                            
Verifying transaction: done                                                                                                                                                            
Executing transaction: done                                                                                                                                                            
#                                                                                                                                                                                      
# To activate this environment, use                                                                                                                                                    
#                                                                                                                                                                                      
#     $ conda activate dna                                                                                                                                                             
#                                                                                                                                                                                      
# To deactivate an active environment, use                                                                                                                                             
#                                                                                                                                                                                      
#     $ conda deactivate                                                                                                                                                               
                                                                                                                                                                                       
+ conda init bash                                                                                                                                                                      
no change     /opt/conda/condabin/conda                                                                                                                                                
no change     /opt/conda/bin/conda                                                                                                                                                     
no change     /opt/conda/bin/conda-env                                                                                                                                                 
no change     /opt/conda/bin/activate                                                                                                                                                  
no change     /opt/conda/bin/deactivate                                                                                                                                                
no change     /opt/conda/etc/profile.d/conda.sh                                                                                                                                        
no change     /opt/conda/etc/fish/conf.d/conda.fish                                                                                                                                    
no change     /opt/conda/shell/condabin/Conda.psm1                                                                                                                                     
no change     /opt/conda/shell/condabin/conda-hook.ps1                                                                                                                                 
no change     /opt/conda/lib/python3.10/site-packages/xontrib/conda.xsh
no change     /opt/conda/etc/profile.d/conda.csh
modified      /root/.bashrc

==> For changes to take effect, close and re-open your current shell. <==

+ echo -e \nconda activate dna
+ echo -e \nconda activate dna
+ cd /opt
+ git clone https://github.com/openai/triton.git
Cloning into 'triton'...
^[[D^[[Cremote: Enumerating objects: 138933, done.
remote: Counting objects: 100% (470/470), done.
remote: Compressing objects: 100% (259/259), done.
remote: Total 138933 (delta 221), reused 410 (delta 192), pack-reused 138463 (from 1)
Receiving objects: 100% (138933/138933), 334.98 MiB | 28.63 MiB/s, done.
Resolving deltas: 100% (96577/96577), done.
+ cd triton/python
+ pip install cmake
Collecting cmake
  Downloading cmake-3.30.2-py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (6.1 kB)
Downloading cmake-3.30.2-py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (26.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 26.9/26.9 MB 25.2 MB/s eta 0:00:00
Installing collected packages: cmake
Successfully installed cmake-3.30.2
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
+ pip install -e .
Obtaining file:///opt/triton/python
  Installing build dependencies ... done
  Checking if build backend supports build_editable ... done
  Getting requirements to build editable ... error
  error: subprocess-exited-with-error
  
  × Getting requirements to build editable did not run successfully.
  │ exit code: 1
  ╰─> [59 lines of output]
      downloading and extracting https://anaconda.org/nvidia/cuda-nvcc/12.4.99/download/linux-64/cuda-nvcc-12.4.99-0.tar.bz2 ...
      Traceback (most recent call last):
        File "/opt/conda/lib/python3.10/urllib/request.py", line 1348, in do_open
          h.request(req.get_method(), req.selector, req.data, headers,
        File "/opt/conda/lib/python3.10/http/client.py", line 1283, in request
          self._send_request(method, url, body, headers, encode_chunked)
        File "/opt/conda/lib/python3.10/http/client.py", line 1329, in _send_request
          self.endheaders(body, encode_chunked=encode_chunked)
        File "/opt/conda/lib/python3.10/http/client.py", line 1278, in endheaders
          self._send_output(message_body, encode_chunked=encode_chunked)
        File "/opt/conda/lib/python3.10/http/client.py", line 1038, in _send_output
          self.send(msg)
        File "/opt/conda/lib/python3.10/http/client.py", line 976, in send
          self.connect()
        File "/opt/conda/lib/python3.10/http/client.py", line 1448, in connect
          super().connect()
        File "/opt/conda/lib/python3.10/http/client.py", line 942, in connect
          self.sock = self._create_connection(
        File "/opt/conda/lib/python3.10/socket.py", line 824, in create_connection
          for res in getaddrinfo(host, port, 0, SOCK_STREAM):
        File "/opt/conda/lib/python3.10/socket.py", line 955, in getaddrinfo
          for res in _socket.getaddrinfo(host, port, family, type, proto, flags):
      socket.gaierror: [Errno -3] Temporary failure in name resolution
      
      During handling of the above exception, another exception occurred:
      
      Traceback (most recent call last):
        File "/opt/conda/lib/python3.10/site-packages/pip/_vendor/pyproject_hooks/_in_process/_in_process.py", line 353, in <module>
          main()
        File "/opt/conda/lib/python3.10/site-packages/pip/_vendor/pyproject_hooks/_in_process/_in_process.py", line 335, in main
          json_out['return_val'] = hook(**hook_input['kwargs'])
        File "/opt/conda/lib/python3.10/site-packages/pip/_vendor/pyproject_hooks/_in_process/_in_process.py", line 132, in get_requires_for_build_editable
          return hook(config_settings)
        File "/tmp/pip-build-env-7p64a85d/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 464, in get_requires_for_build_editable
          return self.get_requires_for_build_wheel(config_settings)
        File "/tmp/pip-build-env-7p64a85d/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 332, in get_requires_for_build_wheel
          return self._get_build_requires(config_settings, requirements=[])
        File "/tmp/pip-build-env-7p64a85d/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 302, in _get_build_requires
          self.run_setup()
        File "/tmp/pip-build-env-7p64a85d/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 503, in run_setup
          super().run_setup(setup_script=setup_script)
        File "/tmp/pip-build-env-7p64a85d/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 318, in run_setup
          exec(code, locals())
        File "<string>", line 472, in <module>
        File "<string>", line 293, in download_and_copy
        File "<string>", line 216, in open_url
        File "/opt/conda/lib/python3.10/urllib/request.py", line 216, in urlopen
          return opener.open(url, data, timeout)
        File "/opt/conda/lib/python3.10/urllib/request.py", line 519, in open
          response = self._open(req, data)
        File "/opt/conda/lib/python3.10/urllib/request.py", line 536, in _open
          result = self._call_chain(self.handle_open, protocol, protocol +
        File "/opt/conda/lib/python3.10/urllib/request.py", line 496, in _call_chain
          result = func(*args)
        File "/opt/conda/lib/python3.10/urllib/request.py", line 1391, in https_open
          return self.do_open(http.client.HTTPSConnection, req,
        File "/opt/conda/lib/python3.10/urllib/request.py", line 1351, in do_open
          raise URLError(err)
      urllib.error.URLError: <urlopen error [Errno -3] Temporary failure in name resolution>
      [end of output]
  
  note: This error originates from a subprocess, and is likely not a problem with pip.
error: subprocess-exited-with-error

× Getting requirements to build editable did not run successfully.
│ exit code: 1
╰─> See above for output.

note: This error originates from a subprocess, and is likely not a problem with pip.
FATAL:   While performing build: while running engine: exit status 1
```

## Attempt 2: after googling a lot

```
Bootstrap: docker
From: condaforge/miniforge3

# From https://geniac.readthedocs.io/en/latest/conda.html#example2-activate-the-conda-environment-at-startup-with-singularity-exec-or-run
%environment
    export LC_ALL=en_US.utf-8
    export LANG=en_US.utf-8
    export BASH_ENV=/root/bashrc

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    # echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    # Create and activate virtual python environment
    conda create -n dna python=3.8

    # Must be done before a conda create
    # Error: CondaError: Run 'conda init' before 'conda activate'                                                                                                                                   
    # Use 'bash' at the end, from https://geniac.readthedocs.io/en/latest/conda.html#example2-activate-the-conda-environment-at-startup-with-singularity-exec-or-run 

    conda init bash

    # From https://stackoverflow.com/a/78456992
    # Error: 'source: not found'
    # source activate base
    #./activate base
    # Error: './activate: not found'
    # . activate base


    # From https://geniac.readthedocs.io/en/latest/conda.html#example1
    echo -e "\nconda activate dna" >> ~/.bashrc
    echo -e "\nconda activate dna" >> /root/bashrc
    # Gives error
    # conda activate dna

    # (optional if you would like to use flash attention)
    # install triton from source
    cd /opt
    git clone https://github.com/openai/triton.git
    cd triton/python
    pip install cmake; # build-time dependency
    pip install -e .

    # install required packages
    cd /opt
    git clone https://github.com/MAGICS-LAB/DNABERT_2
    cd DNABERT_2
    python3 -m pip install -r requirements.txt

%runscript
python3 "$@"
```

Run:

```
./create.se
```

Gives:

```
[sudo] password for richel: 
INFO:    Starting build...
INFO:    Fetching OCI image...
119.3MiB / 119.3MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
26.2MiB / 26.2MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Running post scriptlet
+ conda create -n dna python=3.8
Channels:
 - conda-forge
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
    current version: 24.3.0
    latest version: 24.7.1

Please update conda by running

    $ conda update -n base -c conda-forge conda



## Package Plan ##

  environment location: /opt/conda/envs/dna

  added / updated specs:
    - python=3.8


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    _libgcc_mutex-0.1          |      conda_forge           3 KB  conda-forge
    _openmp_mutex-4.5          |            2_gnu          23 KB  conda-forge
    bzip2-1.0.8                |       h4bc722e_7         247 KB  conda-forge
    ca-certificates-2024.7.4   |       hbcca054_0         151 KB  conda-forge
    ld_impl_linux-64-2.40      |       hf3520f5_7         691 KB  conda-forge
    libffi-3.4.2               |       h7f98852_5          57 KB  conda-forge
    libgcc-14.1.0              |       h77fa898_1         827 KB  conda-forge
    libgcc-ng-14.1.0           |       h69a702a_1          51 KB  conda-forge
    libgomp-14.1.0             |       h77fa898_1         449 KB  conda-forge
    libnsl-2.0.1               |       hd590300_0          33 KB  conda-forge
    libsqlite-3.46.0           |       hde9e2c9_0         845 KB  conda-forge
    libuuid-2.38.1             |       h0b41bf4_0          33 KB  conda-forge
    libxcrypt-4.4.36           |       hd590300_1          98 KB  conda-forge
    libzlib-1.3.1              |       h4ab18f5_1          60 KB  conda-forge
    ncurses-6.5                |       he02047a_1         868 KB  conda-forge
    openssl-3.3.1              |       hb9d3cd8_3         2.8 MB  conda-forge
    pip-24.2                   |     pyhd8ed1ab_0         1.2 MB  conda-forge
    python-3.8.19              |hd12c33a_0_cpython        21.3 MB  conda-forge
    readline-8.2               |       h8228510_1         275 KB  conda-forge
    setuptools-72.2.0          |     pyhd8ed1ab_0         1.4 MB  conda-forge
    tk-8.6.13                  |noxft_h4845f30_101         3.2 MB  conda-forge
    wheel-0.44.0               |     pyhd8ed1ab_0          57 KB  conda-forge
    xz-5.2.6                   |       h166bdaf_0         409 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        34.9 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge 
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-2_gnu 
  bzip2              conda-forge/linux-64::bzip2-1.0.8-h4bc722e_7 
  ca-certificates    conda-forge/linux-64::ca-certificates-2024.7.4-hbcca054_0 
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.40-hf3520f5_7 
  libffi             conda-forge/linux-64::libffi-3.4.2-h7f98852_5 
  libgcc             conda-forge/linux-64::libgcc-14.1.0-h77fa898_1 
  libgcc-ng          conda-forge/linux-64::libgcc-ng-14.1.0-h69a702a_1 
  libgomp            conda-forge/linux-64::libgomp-14.1.0-h77fa898_1 
  libnsl             conda-forge/linux-64::libnsl-2.0.1-hd590300_0 
  libsqlite          conda-forge/linux-64::libsqlite-3.46.0-hde9e2c9_0 
  libuuid            conda-forge/linux-64::libuuid-2.38.1-h0b41bf4_0 
  libxcrypt          conda-forge/linux-64::libxcrypt-4.4.36-hd590300_1 
  libzlib            conda-forge/linux-64::libzlib-1.3.1-h4ab18f5_1 
  ncurses            conda-forge/linux-64::ncurses-6.5-he02047a_1 
  openssl            conda-forge/linux-64::openssl-3.3.1-hb9d3cd8_3 
  pip                conda-forge/noarch::pip-24.2-pyhd8ed1ab_0 
  python             conda-forge/linux-64::python-3.8.19-hd12c33a_0_cpython 
  readline           conda-forge/linux-64::readline-8.2-h8228510_1 
  setuptools         conda-forge/noarch::setuptools-72.2.0-pyhd8ed1ab_0 
  tk                 conda-forge/linux-64::tk-8.6.13-noxft_h4845f30_101 
  wheel              conda-forge/noarch::wheel-0.44.0-pyhd8ed1ab_0 
  xz                 conda-forge/linux-64::xz-5.2.6-h166bdaf_0 


Proceed ([y]/n)? 

Downloading and Extracting Packages:
                                                                                                                                                                                       
Preparing transaction: done                                                                                                                                                            
Verifying transaction: done                                                                                                                                                            
Executing transaction: done                                                                                                                                                            
#                                                                                                                                                                                      
# To activate this environment, use                                                                                                                                                    
#                                                                                                                                                                                      
#     $ conda activate dna                                                                                                                                                             
#                                                                                                                                                                                      
# To deactivate an active environment, use                                                                                                                                             
#                                                                                                                                                                                      
#     $ conda deactivate                                                                                                                                                               
                                                                                                                                                                                       
+ conda init bash                                                                                                                                                                      
no change     /opt/conda/condabin/conda                                                                                                                                                
no change     /opt/conda/bin/conda                                                                                                                                                     
no change     /opt/conda/bin/conda-env                                                                                                                                                 
no change     /opt/conda/bin/activate                                                                                                                                                  
no change     /opt/conda/bin/deactivate                                                                                                                                                
no change     /opt/conda/etc/profile.d/conda.sh                                                                                                                                        
no change     /opt/conda/etc/fish/conf.d/conda.fish                                                                                                                                    
no change     /opt/conda/shell/condabin/Conda.psm1                                                                                                                                     
no change     /opt/conda/shell/condabin/conda-hook.ps1                                                                                                                                 
no change     /opt/conda/lib/python3.10/site-packages/xontrib/conda.xsh
no change     /opt/conda/etc/profile.d/conda.csh
modified      /root/.bashrc

==> For changes to take effect, close and re-open your current shell. <==

+ echo -e \nconda activate dna
+ echo -e \nconda activate dna
+ cd /opt
+ git clone https://github.com/openai/triton.git
Cloning into 'triton'...
remote: Enumerating objects: 138933, done.
remote: Counting objects: 100% (470/470), done.
remote: Compressing objects: 100% (259/259), done.
remote: Total 138933 (delta 221), reused 410 (delta 192), pack-reused 138463 (from 1)
Receiving objects: 100% (138933/138933), 334.98 MiB | 27.59 MiB/s, done.
Resolving deltas: 100% (96577/96577), done.
+ cd triton/python
+ pip install cmake
Collecting cmake
  Downloading cmake-3.30.2-py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (6.1 kB)
Downloading cmake-3.30.2-py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (26.9 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 26.9/26.9 MB 25.1 MB/s eta 0:00:00
Installing collected packages: cmake
Successfully installed cmake-3.30.2
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
+ pip install -e .
Obtaining file:///opt/triton/python
  Installing build dependencies ... done
  Checking if build backend supports build_editable ... done
  Getting requirements to build editable ... done
  Preparing editable metadata (pyproject.toml) ... done
Building wheels for collected packages: triton
  Building editable for triton (pyproject.toml) ... error
  error: subprocess-exited-with-error
  
  × Building editable for triton (pyproject.toml) did not run successfully.
  │ exit code: 1
  ╰─> [225 lines of output]
      /tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py:260: UserWarning: Unknown distribution option: 'test_suite'
        warnings.warn(msg)
      copy /root/.triton/nvidia/ptxas/bin/ptxas to /opt/triton/python/../third_party/nvidia/backend/bin/ptxas ...
      copy /root/.triton/nvidia/cuobjdump/bin/cuobjdump to /opt/triton/python/../third_party/nvidia/backend/bin/cuobjdump ...
      copy /root/.triton/nvidia/nvdisasm/bin/nvdisasm to /opt/triton/python/../third_party/nvidia/backend/bin/nvdisasm ...
      copy /root/.triton/nvidia/cudacrt/include to /opt/triton/python/../third_party/nvidia/backend/include ...
      copy /root/.triton/nvidia/cudart/include to /opt/triton/python/../third_party/nvidia/backend/include ...
      copy /root/.triton/nvidia/cupti/include to /opt/triton/python/../third_party/nvidia/backend/include ...
      running editable_wheel
      creating /tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info
      writing /tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/PKG-INFO
      writing dependency_links to /tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/dependency_links.txt
      writing entry points to /tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/entry_points.txt
      writing requirements to /tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/requires.txt
      writing top-level names to /tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/top_level.txt
      writing manifest file '/tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/SOURCES.txt'
      reading manifest file '/tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/SOURCES.txt'
      reading manifest template 'MANIFEST.in'
      writing manifest file '/tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton.egg-info/SOURCES.txt'
      creating '/tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton-3.0.0.dist-info'
      creating /tmp/pip-wheel-saqjvy0f/.tmp-toifjgei/triton-3.0.0.dist-info/WHEEL
      running build_py
      running build_ext
      CMake Deprecation Warning at CMakeLists.txt:6 (cmake_policy):
        The OLD behavior for policy CMP0116 will be removed from a future version
        of CMake.
      
        The cmake-policies(7) manual explains that the OLD behaviors of all
        policies are deprecated and that a policy should be set to OLD only under
        specific short-term circumstances.  Projects should be ported to the NEW
        behavior and not rely on setting a policy to OLD.
      
      
      -- The C compiler identification is unknown
      -- The CXX compiler identification is unknown
      CMake Error at CMakeLists.txt:15 (project):
        No CMAKE_C_COMPILER could be found.
      
        Tell CMake where to find the compiler by setting either the environment
        variable "CC" or the CMake cache entry CMAKE_C_COMPILER to the full path to
        the compiler, or to the compiler name if it is in the PATH.
      
      
      CMake Error at CMakeLists.txt:15 (project):
        No CMAKE_CXX_COMPILER could be found.
      
        Tell CMake where to find the compiler by setting either the environment
        variable "CXX" or the CMake cache entry CMAKE_CXX_COMPILER to the full path
        to the compiler, or to the compiler name if it is in the PATH.
      
      
      -- Configuring incomplete, errors occurred!
      /tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py:289: SetuptoolsDeprecationWarning: Customization incompatible with editable install
      !!
      
              ********************************************************************************
                              Traceback (most recent call last):
                File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 295, in _safely_run
                  return self.run_command(cmd_name)
                File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/cmd.py", line 316, in run_command
                  self.distribution.run_command(command)
                File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/dist.py", line 950, in run_command
                  super().run_command(command)
                File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py", line 972, in run_command
                  cmd_obj.run()
                File "<string>", line 329, in run
                File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/cmd.py", line 316, in run_command
                  self.distribution.run_command(command)
                File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/dist.py", line 950, in run_command
                  super().run_command(command)
                File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py", line 972, in run_command
                  cmd_obj.run()
                File "<string>", line 366, in run
                File "<string>", line 463, in build_extension
                File "/opt/conda/lib/python3.10/subprocess.py", line 369, in check_call
                  raise CalledProcessError(retcode, cmd)
              subprocess.CalledProcessError: Command '['cmake', '/opt/triton', '-G', 'Ninja', '-DCMAKE_MAKE_PROGRAM=/tmp/pip-build-env-fjlk84d6/overlay/bin/ninja', '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON', '-DLLVM_ENABLE_WERROR=ON', '-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=/opt/triton/python/triton/_C', '-DTRITON_BUILD_TUTORIALS=OFF', '-DTRITON_BUILD_PYTHON_MODULE=ON', '-DPython3_EXECUTABLE:FILEPATH=/opt/conda/bin/python3.10', '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON', '-DPYTHON_INCLUDE_DIRS=/opt/conda/include/python3.10', '-DTRITON_CODEGEN_BACKENDS=nvidia;amd', '-DTRITON_PLUGIN_DIRS=', '-DPYBIND11_INCLUDE_DIR=/root/.triton/pybind11/pybind11-2.13.1/include', '-DLLVM_INCLUDE_DIRS=/root/.triton/llvm/llvm-ce80c80d-ubuntu-x64/include', '-DLLVM_LIBRARY_DIR=/root/.triton/llvm/llvm-ce80c80d-ubuntu-x64/lib', '-DCMAKE_BUILD_TYPE=TritonRelBuildWithAsserts', '-DJSON_INCLUDE_DIR=/root/.triton/json//include', '-DPYBIND11_INCLUDE_DIR=/root/.triton/pybind11/pybind11-2.13.1/include', '-DCUPTI_INCLUDE_DIR=/opt/triton/third_party/nvidia/backend/include', '-DROCTRACER_INCLUDE_DIR=/opt/triton/third_party/amd/backend/include']' returned non-zero exit status 1.
      
      
                              If you are seeing this warning it is very likely that a setuptools
                              plugin or customization overrides the `build_py` command, without
                              taking into consideration how editable installs run build steps
                              starting from setuptools v64.0.0.
      
                              Plugin authors and developers relying on custom build steps are
                              encouraged to update their `build_py` implementation considering the
                              information about editable installs in
                              https://setuptools.pypa.io/en/latest/userguide/extension.html.
      
                              For the time being `setuptools` will silence this error and ignore
                              the faulty command, but this behaviour will change in future versions.
      
              ********************************************************************************
      
      !!
        self._safely_run(name)
      downloading and extracting https://github.com/pybind/pybind11/archive/refs/tags/v2.13.1.tar.gz ...
      downloading and extracting https://oaitriton.blob.core.windows.net/public/llvm-builds/llvm-ce80c80d-ubuntu-x64.tar.gz ...
      downloading and extracting https://github.com/nlohmann/json/releases/download/v3.11.3/include.zip ...
      running build_ext
      CMake Deprecation Warning at CMakeLists.txt:6 (cmake_policy):
        The OLD behavior for policy CMP0116 will be removed from a future version
        of CMake.
      
        The cmake-policies(7) manual explains that the OLD behaviors of all
        policies are deprecated and that a policy should be set to OLD only under
        specific short-term circumstances.  Projects should be ported to the NEW
        behavior and not rely on setting a policy to OLD.
      
      
      -- The C compiler identification is unknown
      -- The CXX compiler identification is unknown
      CMake Error at CMakeLists.txt:15 (project):
        No CMAKE_C_COMPILER could be found.
      
        Tell CMake where to find the compiler by setting either the environment
        variable "CC" or the CMake cache entry CMAKE_C_COMPILER to the full path to
        the compiler, or to the compiler name if it is in the PATH.
      
      
      CMake Error at CMakeLists.txt:15 (project):
        No CMAKE_CXX_COMPILER could be found.
      
        Tell CMake where to find the compiler by setting either the environment
        variable "CXX" or the CMake cache entry CMAKE_CXX_COMPILER to the full path
        to the compiler, or to the compiler name if it is in the PATH.
      
      
      -- Configuring incomplete, errors occurred!
      Traceback (most recent call last):
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 138, in run
          self._create_wheel_file(bdist_wheel)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 341, in _create_wheel_file
          files, mapping = self._run_build_commands(dist_name, unpacked, lib, tmp)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 264, in _run_build_commands
          self._run_build_subcommands()
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 291, in _run_build_subcommands
          self.run_command(name)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/cmd.py", line 316, in run_command
          self.distribution.run_command(command)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/dist.py", line 950, in run_command
          super().run_command(command)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py", line 972, in run_command
          cmd_obj.run()
        File "<string>", line 366, in run
        File "<string>", line 463, in build_extension
        File "/opt/conda/lib/python3.10/subprocess.py", line 369, in check_call
          raise CalledProcessError(retcode, cmd)
      subprocess.CalledProcessError: Command '['cmake', '/opt/triton', '-G', 'Ninja', '-DCMAKE_MAKE_PROGRAM=/tmp/pip-build-env-fjlk84d6/overlay/bin/ninja', '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON', '-DLLVM_ENABLE_WERROR=ON', '-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=/opt/triton/python/triton/_C', '-DTRITON_BUILD_TUTORIALS=OFF', '-DTRITON_BUILD_PYTHON_MODULE=ON', '-DPython3_EXECUTABLE:FILEPATH=/opt/conda/bin/python3.10', '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON', '-DPYTHON_INCLUDE_DIRS=/opt/conda/include/python3.10', '-DTRITON_CODEGEN_BACKENDS=nvidia;amd', '-DTRITON_PLUGIN_DIRS=', '-DPYBIND11_INCLUDE_DIR=/root/.triton/pybind11/pybind11-2.13.1/include', '-DLLVM_INCLUDE_DIRS=/root/.triton/llvm/llvm-ce80c80d-ubuntu-x64/include', '-DLLVM_LIBRARY_DIR=/root/.triton/llvm/llvm-ce80c80d-ubuntu-x64/lib', '-DCMAKE_BUILD_TYPE=TritonRelBuildWithAsserts', '-DJSON_INCLUDE_DIR=/root/.triton/json//include', '-DPYBIND11_INCLUDE_DIR=/root/.triton/pybind11/pybind11-2.13.1/include', '-DCUPTI_INCLUDE_DIR=/opt/triton/third_party/nvidia/backend/include', '-DROCTRACER_INCLUDE_DIR=/opt/triton/third_party/amd/backend/include']' returned non-zero exit status 1.
      /tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py:972: _DebuggingTips: Problem in editable installation.
      !!
      
              ********************************************************************************
              An error happened while installing `triton` in editable mode.
      
              The following steps are recommended to help debug this problem:
      
              - Try to install the project normally, without using the editable mode.
                Does the error still persist?
                (If it does, try fixing the problem before attempting the editable mode).
              - If you are using binary extensions, make sure you have all OS-level
                dependencies installed (e.g. compilers, toolchains, binary libraries, ...).
              - Try the latest version of setuptools (maybe the error was already fixed).
              - If you (or your project dependencies) are using any setuptools extension
                or customization, make sure they support the editable mode.
      
              After following the steps above, if the problem still persists and
              you think this is related to how setuptools handles editable installations,
              please submit a reproducible example
              (see https://stackoverflow.com/help/minimal-reproducible-example) to:
      
                  https://github.com/pypa/setuptools/issues
      
              See https://setuptools.pypa.io/en/latest/userguide/development_mode.html for details.
              ********************************************************************************
      
      !!
        cmd_obj.run()
      Traceback (most recent call last):
        File "/opt/conda/lib/python3.10/site-packages/pip/_vendor/pyproject_hooks/_in_process/_in_process.py", line 353, in <module>
          main()
        File "/opt/conda/lib/python3.10/site-packages/pip/_vendor/pyproject_hooks/_in_process/_in_process.py", line 335, in main
          json_out['return_val'] = hook(**hook_input['kwargs'])
        File "/opt/conda/lib/python3.10/site-packages/pip/_vendor/pyproject_hooks/_in_process/_in_process.py", line 273, in build_editable
          return hook(wheel_directory, config_settings, metadata_directory)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 459, in build_editable
          return self._build_with_temp_dir(
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 403, in _build_with_temp_dir
          self.run_setup()
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 503, in run_setup
          super().run_setup(setup_script=setup_script)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/build_meta.py", line 318, in run_setup
          exec(code, locals())
        File "<string>", line 613, in <module>
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/__init__.py", line 117, in setup
          return distutils.core.setup(**attrs)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/core.py", line 184, in setup
          return run_commands(dist)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/core.py", line 200, in run_commands
          dist.run_commands()
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py", line 953, in run_commands
          self.run_command(cmd)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/dist.py", line 950, in run_command
          super().run_command(command)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py", line 972, in run_command
          cmd_obj.run()
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 138, in run
          self._create_wheel_file(bdist_wheel)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 341, in _create_wheel_file
          files, mapping = self._run_build_commands(dist_name, unpacked, lib, tmp)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 264, in _run_build_commands
          self._run_build_subcommands()
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/command/editable_wheel.py", line 291, in _run_build_subcommands
          self.run_command(name)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/cmd.py", line 316, in run_command
          self.distribution.run_command(command)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/dist.py", line 950, in run_command
          super().run_command(command)
        File "/tmp/pip-build-env-fjlk84d6/overlay/lib/python3.10/site-packages/setuptools/_distutils/dist.py", line 972, in run_command
          cmd_obj.run()
        File "<string>", line 366, in run
        File "<string>", line 463, in build_extension
        File "/opt/conda/lib/python3.10/subprocess.py", line 369, in check_call
          raise CalledProcessError(retcode, cmd)
      subprocess.CalledProcessError: Command '['cmake', '/opt/triton', '-G', 'Ninja', '-DCMAKE_MAKE_PROGRAM=/tmp/pip-build-env-fjlk84d6/overlay/bin/ninja', '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON', '-DLLVM_ENABLE_WERROR=ON', '-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=/opt/triton/python/triton/_C', '-DTRITON_BUILD_TUTORIALS=OFF', '-DTRITON_BUILD_PYTHON_MODULE=ON', '-DPython3_EXECUTABLE:FILEPATH=/opt/conda/bin/python3.10', '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON', '-DPYTHON_INCLUDE_DIRS=/opt/conda/include/python3.10', '-DTRITON_CODEGEN_BACKENDS=nvidia;amd', '-DTRITON_PLUGIN_DIRS=', '-DPYBIND11_INCLUDE_DIR=/root/.triton/pybind11/pybind11-2.13.1/include', '-DLLVM_INCLUDE_DIRS=/root/.triton/llvm/llvm-ce80c80d-ubuntu-x64/include', '-DLLVM_LIBRARY_DIR=/root/.triton/llvm/llvm-ce80c80d-ubuntu-x64/lib', '-DCMAKE_BUILD_TYPE=TritonRelBuildWithAsserts', '-DJSON_INCLUDE_DIR=/root/.triton/json//include', '-DPYBIND11_INCLUDE_DIR=/root/.triton/pybind11/pybind11-2.13.1/include', '-DCUPTI_INCLUDE_DIR=/opt/triton/third_party/nvidia/backend/include', '-DROCTRACER_INCLUDE_DIR=/opt/triton/third_party/amd/backend/include']' returned non-zero exit status 1.
      [end of output]
  
  note: This error originates from a subprocess, and is likely not a problem with pip.
  ERROR: Failed building editable for triton
Failed to build triton
ERROR: Could not build wheels for triton, which is required to install pyproject.toml-based projects
FATAL:   While performing build: while running engine: exit status 1
richel@richel-N141CU:~/GitHubs/ticket_297538$ 
```


## Attempt 1: from documentation

I start with this:

```
Bootstrap: docker
From: condaforge/miniforge3

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    # Must be done before a conda create
    conda init

    # create and activate virtual python environment
    conda create -n dna python=3.8
    conda activate dna

    # (optional if you would like to use flash attention)
    # install triton from source
    cd /opt
    git clone https://github.com/openai/triton.git
    cd triton/python
    pip install cmake; # build-time dependency
    pip install -e .

    # install required packages
    cd /opt
    git clone https://github.com/MAGICS-LAB/DNABERT_2
    cd DNABERT_2
    python3 -m pip install -r requirements.txt

%runscript
python3 "$@"
```

Build:

```
./create.sh
```

Gives:

```
[sudo] password for richel: 
INFO:    Starting build...
INFO:    Fetching OCI image...
26.2MiB / 26.2MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
119.3MiB / 119.3MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Running post scriptlet
+ echo export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C
+ conda init
no change     /opt/conda/condabin/conda
no change     /opt/conda/bin/conda
no change     /opt/conda/bin/conda-env
no change     /opt/conda/bin/activate
no change     /opt/conda/bin/deactivate
no change     /opt/conda/etc/profile.d/conda.sh
no change     /opt/conda/etc/fish/conf.d/conda.fish
no change     /opt/conda/shell/condabin/Conda.psm1
no change     /opt/conda/shell/condabin/conda-hook.ps1
no change     /opt/conda/lib/python3.10/site-packages/xontrib/conda.xsh
no change     /opt/conda/etc/profile.d/conda.csh
modified      /root/.bashrc

==> For changes to take effect, close and re-open your current shell. <==

+ conda create -n dna python=3.8
Channels:
 - conda-forge
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
    current version: 24.3.0
    latest version: 24.7.1

Please update conda by running

    $ conda update -n base -c conda-forge conda



## Package Plan ##

  environment location: /opt/conda/envs/dna

  added / updated specs:
    - python=3.8


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    _libgcc_mutex-0.1          |      conda_forge           3 KB  conda-forge
    _openmp_mutex-4.5          |            2_gnu          23 KB  conda-forge
    bzip2-1.0.8                |       h4bc722e_7         247 KB  conda-forge
    ca-certificates-2024.7.4   |       hbcca054_0         151 KB  conda-forge
    ld_impl_linux-64-2.40      |       hf3520f5_7         691 KB  conda-forge
    libffi-3.4.2               |       h7f98852_5          57 KB  conda-forge
    libgcc-14.1.0              |       h77fa898_1         827 KB  conda-forge
    libgcc-ng-14.1.0           |       h69a702a_1          51 KB  conda-forge
    libgomp-14.1.0             |       h77fa898_1         449 KB  conda-forge
    libnsl-2.0.1               |       hd590300_0          33 KB  conda-forge
    libsqlite-3.46.0           |       hde9e2c9_0         845 KB  conda-forge
    libuuid-2.38.1             |       h0b41bf4_0          33 KB  conda-forge
    libxcrypt-4.4.36           |       hd590300_1          98 KB  conda-forge
    libzlib-1.3.1              |       h4ab18f5_1          60 KB  conda-forge
    ncurses-6.5                |       he02047a_1         868 KB  conda-forge
    openssl-3.3.1              |       hb9d3cd8_3         2.8 MB  conda-forge
    pip-24.2                   |     pyhd8ed1ab_0         1.2 MB  conda-forge
    python-3.8.19              |hd12c33a_0_cpython        21.3 MB  conda-forge
    readline-8.2               |       h8228510_1         275 KB  conda-forge
    setuptools-72.2.0          |     pyhd8ed1ab_0         1.4 MB  conda-forge
    tk-8.6.13                  |noxft_h4845f30_101         3.2 MB  conda-forge
    wheel-0.44.0               |     pyhd8ed1ab_0          57 KB  conda-forge
    xz-5.2.6                   |       h166bdaf_0         409 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        34.9 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge 
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-2_gnu 
  bzip2              conda-forge/linux-64::bzip2-1.0.8-h4bc722e_7 
  ca-certificates    conda-forge/linux-64::ca-certificates-2024.7.4-hbcca054_0 
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.40-hf3520f5_7 
  libffi             conda-forge/linux-64::libffi-3.4.2-h7f98852_5 
  libgcc             conda-forge/linux-64::libgcc-14.1.0-h77fa898_1 
  libgcc-ng          conda-forge/linux-64::libgcc-ng-14.1.0-h69a702a_1 
  libgomp            conda-forge/linux-64::libgomp-14.1.0-h77fa898_1 
  libnsl             conda-forge/linux-64::libnsl-2.0.1-hd590300_0 
  libsqlite          conda-forge/linux-64::libsqlite-3.46.0-hde9e2c9_0 
  libuuid            conda-forge/linux-64::libuuid-2.38.1-h0b41bf4_0 
  libxcrypt          conda-forge/linux-64::libxcrypt-4.4.36-hd590300_1 
  libzlib            conda-forge/linux-64::libzlib-1.3.1-h4ab18f5_1 
  ncurses            conda-forge/linux-64::ncurses-6.5-he02047a_1 
  openssl            conda-forge/linux-64::openssl-3.3.1-hb9d3cd8_3 
  pip                conda-forge/noarch::pip-24.2-pyhd8ed1ab_0 
  python             conda-forge/linux-64::python-3.8.19-hd12c33a_0_cpython 
  readline           conda-forge/linux-64::readline-8.2-h8228510_1 
  setuptools         conda-forge/noarch::setuptools-72.2.0-pyhd8ed1ab_0 
  tk                 conda-forge/linux-64::tk-8.6.13-noxft_h4845f30_101 
  wheel              conda-forge/noarch::wheel-0.44.0-pyhd8ed1ab_0 
  xz                 conda-forge/linux-64::xz-5.2.6-h166bdaf_0 


Proceed ([y]/n)? 

Downloading and Extracting Packages:
                                                                                                                                                                                       
Preparing transaction: done                                                                                                                                                            
Verifying transaction: done                                                                                                                                                            
Executing transaction: done                                                                                                                                                            
#                                                                                                                                                                                      
# To activate this environment, use                                                                                                                                                    
#                                                                                                                                                                                      
#     $ conda activate dna                                                                                                                                                             
#                                                                                                                                                                                      
# To deactivate an active environment, use                                                                                                                                             
#                                                                                                                                                                                      
#     $ conda deactivate                                                                                                                                                               
                                                                                                                                                                                       
+ conda activate dna                                                                                                                                                                   
                                                                                                                                                                                       
CondaError: Run 'conda init' before 'conda activate'                                                                                                                                   
                                                                                                                                                                                       
FATAL:   While performing build: while running engine: exit status 1       
```

Hmmm, how to do a `conda init` in a Singularity container?