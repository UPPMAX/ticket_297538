# ticket_297538

Notes for ticket 297538

## Attempt 7: start from Docker with Triton, use rocm/oai-triton

No idea why this fails (beside the error message)

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

```
richel@richel-N141CU:~/GitHubs/ticket_297538$ sudo singularity build dnabert2_with_triton.def dnabert2_with_triton_7.def 
[sudo] password for richel: 
INFO:    Starting build...
INFO:    Fetching OCI image...
209.1MiB / 209.1MiB [==============================================================================================================================================] 100 % 3.3 MiB/s 0s
27.3MiB / 27.3MiB [================================================================================================================================================] 100 % 3.3 MiB/s 0s
2.1GiB / 2.1GiB [==================================================================================================================================================] 100 % 3.3 MiB/s 0s
292.2MiB / 292.2MiB [==============================================================================================================================================] 100 % 3.3 MiB/s 0s
6.1GiB / 6.1GiB [==================================================================================================================================================] 100 % 3.3 MiB/s 0s
15.2MiB / 15.2MiB [================================================================================================================================================] 100 % 3.3 MiB/s 0s
1.6GiB / 1.6GiB [==================================================================================================================================================] 100 % 3.3 MiB/s 0s
1.1MiB / 1.1MiB [==================================================================================================================================================] 100 % 3.3 MiB/s 0s
115.8MiB / 115.8MiB [==============================================================================================================================================] 100 % 3.3 MiB/s 0s
2.9GiB / 2.9GiB [==================================================================================================================================================] 100 % 3.3 MiB/s 0s
86.2KiB / 86.2KiB [================================================================================================================================================] 100 % 3.3 MiB/s 0s
396.1MiB / 396.1MiB [==============================================================================================================================================] 100 % 3.3 MiB/s 0s
97.4MiB / 97.4MiB [================================================================================================================================================] 100 % 3.3 MiB/s 0s
1.3GiB / 1.3GiB [==================================================================================================================================================] 100 % 3.3 MiB/s 0s
INFO:    Extracting OCI image...
FATAL:   While performing build: packer failed to pack: while unpacking tmpfs: error unpacking rootfs: unpack entry: opt/conda/pkgs/numpy-base-1.18.5-py38h2f8d375_0/lib/python3.8/site-packages/numpy-1.18.5-py3.8.egg-info/PKG-INFO: link: no such file or directory
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