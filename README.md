# ticket_297538

Notes for ticket 297538.

Solution at
[https://github.com/richelbilderbeek/create_dnabert2_with_triton_singularity_container](https://github.com/richelbilderbeek/create_dnabert2_with_triton_singularity_container)

## Approach 2: just install on Rackham

Run <install_and_run.sh>:

```
./install_and_run.sh
```

## 2g 

- Hypothesis: taking a look at attempt `2z` (the one before `2a`), I notice that files are downloaded:

```
[...]
configuration_bert.py: 100%|████████████████| 1.01k/1.01k [00:00<00:00, 429kB/s]
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- configuration_bert.py
[...]
bert_layers.py: 100%|██████████████████████| 40.7k/40.7k [00:00<00:00, 16.6MB/s]
flash_attn_triton.py: 100%|████████████████| 42.7k/42.7k [00:00<00:00, 17.0MB/s]
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- flash_attn_triton.py
[...]
bert_padding.py: 100%|█████████████████████| 6.10k/6.10k [00:00<00:00, 2.62MB/s]
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- bert_padding.py
[...]
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- bert_layers.py
- flash_attn_triton.py
- bert_padding.py
```

I predict this is where the error is introduced. 

- Solution: uninstall DNABERT2, then install again

```
richel@r480 ticket_297538]$ ./uninstall_and_install_and_run.sh 
WARNING: Skipping DNABERT-2 as it is not installed.

[richel@r480 ticket_297538]$ ./uninstall_and_install_and_run.sh 
WARNING: Skipping DNABERT2 as it is not installed.
```

Hmmm, what is the name of the module???


### [FAILS] 2f: Run all from home folder

```
[richel@r480 ticket_297538]$ pwd
/home/richel/ticket_297538
[richel@r480 ticket_297538]$ ls
example_dnabert2_with_triton.py  install_and_run.sh  LICENSE  README.md  run.sh  singularity
[richel@r480 ticket_297538]$ ./install_and_run.sh 
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: triton in /domus/h1/richel/.local/lib/python3.8/site-packages (3.0.0)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from triton) (3.0.12)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: cmake in /domus/h1/richel/.local/lib/python3.8/site-packages (3.30.3)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Cloning into 'DNABERT_2'...
remote: Enumerating objects: 98, done.
remote: Counting objects: 100% (34/34), done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 98 (delta 18), reused 24 (delta 15), pack-reused 64 (from 1)
Unpacking objects: 100% (98/98), done.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: einops in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 1)) (0.8.0)
Requirement already satisfied: transformers==4.29.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 2)) (4.29.2)
Requirement already satisfied: peft in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 3)) (0.12.0)
Requirement already satisfied: omegaconf in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 4)) (2.3.0)
Requirement already satisfied: torch in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 5)) (2.4.1)
Requirement already satisfied: evaluate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 6)) (0.4.2)
Requirement already satisfied: accelerate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 7)) (0.34.2)
Requirement already satisfied: packaging>=20.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (20.9)
Requirement already satisfied: tokenizers!=0.11.3,<0.14,>=0.11.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.13.3)
Requirement already satisfied: regex!=2019.12.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2020.11.13)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (3.0.12)
Requirement already satisfied: requests in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2.32.3)
Requirement already satisfied: numpy>=1.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (1.20.0)
Requirement already satisfied: huggingface-hub<1.0,>=0.14.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.24.6)
Requirement already satisfied: pyyaml>=5.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (5.4.1)
Requirement already satisfied: tqdm>=4.27 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (4.66.5)
Requirement already satisfied: typing-extensions>=3.7.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (4.12.2)
Requirement already satisfied: fsspec>=2023.5.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (2024.6.1)
Requirement already satisfied: pyparsing>=2.0.2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from packaging>=20.0->transformers==4.29.2->-r requirements.txt (line 2)) (2.4.7)
Requirement already satisfied: psutil in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (6.0.0)
Requirement already satisfied: safetensors>=0.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (0.4.5)
Requirement already satisfied: networkx in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.5)
Requirement already satisfied: sympy in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (1.13.2)
Requirement already satisfied: nvidia-cublas-cu12==12.1.3.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.3.1)
Requirement already satisfied: nvidia-cufft-cu12==11.0.2.54 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.0.2.54)
Requirement already satisfied: nvidia-cusolver-cu12==11.4.5.107 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.4.5.107)
Requirement already satisfied: nvidia-cuda-nvrtc-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-cuda-runtime-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-cuda-cupti-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-curand-cu12==10.3.2.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (10.3.2.106)
Requirement already satisfied: jinja2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.11.3)
Requirement already satisfied: nvidia-cusparse-cu12==12.1.0.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.0.106)
Requirement already satisfied: nvidia-nccl-cu12==2.20.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.20.5)
Requirement already satisfied: nvidia-nvtx-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: triton==3.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (3.0.0)
Requirement already satisfied: nvidia-cudnn-cu12==9.1.0.70 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (9.1.0.70)
Requirement already satisfied: nvidia-nvjitlink-cu12 in /domus/h1/richel/.local/lib/python3.8/site-packages (from nvidia-cusolver-cu12==11.4.5.107->torch->-r requirements.txt (line 5)) (12.6.68)
Requirement already satisfied: dill in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.3.8)
Requirement already satisfied: multiprocess in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.70.16)
Requirement already satisfied: pandas in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (1.2.1)
Requirement already satisfied: xxhash in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (3.5.0)
Requirement already satisfied: datasets>=2.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (2.21.0)
Requirement already satisfied: pyarrow>=15.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (17.0.0)
Requirement already satisfied: aiohttp in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (3.10.5)
Requirement already satisfied: async-timeout<5.0,>=4.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (4.0.3)
Requirement already satisfied: aiohappyeyeballs>=2.3.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (2.4.0)
Requirement already satisfied: frozenlist>=1.1.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.4.1)
Requirement already satisfied: attrs>=17.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (20.3.0)
Requirement already satisfied: multidict<7.0,>=4.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (6.1.0)
Requirement already satisfied: aiosignal>=1.1.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.3.1)
Requirement already satisfied: yarl<2.0,>=1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.11.1)
Requirement already satisfied: idna<4,>=2.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2.10)
Requirement already satisfied: charset-normalizer<4,>=2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (3.3.2)
Requirement already satisfied: certifi>=2017.4.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2020.12.5)
Requirement already satisfied: urllib3<3,>=1.21.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (1.26.3)
Requirement already satisfied: antlr4-python3-runtime==4.9.* in /domus/h1/richel/.local/lib/python3.8/site-packages (from omegaconf->-r requirements.txt (line 4)) (4.9.3)
Requirement already satisfied: MarkupSafe>=0.23 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from jinja2->torch->-r requirements.txt (line 5)) (1.1.1)
Requirement already satisfied: decorator>=4.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from networkx->torch->-r requirements.txt (line 5)) (4.4.2)
Requirement already satisfied: python-dateutil>=2.7.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2.8.1)
Requirement already satisfied: pytz>=2017.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2021.1)
Requirement already satisfied: six>=1.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from python-dateutil>=2.7.3->pandas->evaluate->-r requirements.txt (line 6)) (1.15.0)
Requirement already satisfied: mpmath<1.4,>=1.1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from sympy->torch->-r requirements.txt (line 5)) (1.3.0)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3 -m pip install --upgrade pip' command.
Hello world
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
/home/richel/.local/lib/python3.8/site-packages/transformers/modeling_utils.py:446: FutureWarning: You are using `torch.load` with `weights_only=False` (the current default value), which uses the default pickle module implicitly. It is possible to construct malicious pickle data which will execute arbitrary code during unpickling (See https://github.com/pytorch/pytorch/blob/main/SECURITY.md#untrusted-models for more details). In a future release, the default value for `weights_only` will be flipped to `True`. This limits the functions that could be executed during unpickling. Arbitrary objects will no longer be allowed to be loaded via this mode unless they are explicitly allowlisted by the user via `torch.serialization.add_safe_globals`. We recommend you start setting `weights_only=True` for any use case where you don't have full control of the loaded file. Please open an issue on GitHub for any issues related to this experimental feature.
  return torch.load(checkpoint_file, map_location="cpu")
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.transform.LayerNorm.bias', 'cls.predictions.decoder.weight', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.dense.bias', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.transform.LayerNorm.bias', 'cls.predictions.decoder.weight', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.dense.bias', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Traceback (most recent call last):
  File "example_dnabert2_with_triton.py", line 16, in <module>
    hidden_states = model(inputs)[0] # [1, sequence_length, 768]
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 609, in forward
    encoder_outputs = self.encoder(
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 447, in forward
    hidden_states = layer_module(hidden_states,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 328, in forward
    attention_output = self.attention(hidden_states, cu_seqlens, seqlen,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 241, in forward
    self_output = self.self(input_tensor, cu_seqlens, max_s, indices,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 182, in forward
    attention = flash_attn_qkvpacked_func(qkv, bias)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/autograd/function.py", line 574, in apply
    return super().apply(*args, **kwargs)  # type: ignore[misc]
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 1021, in forward
    o, lse, ctx.softmax_scale = _flash_attn_forward(
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 781, in _flash_attn_forward
    assert q.is_cuda and k.is_cuda and v.is_cuda
AssertionError
```

### [FAILS] 2e: Run from `DNABERT_2` folder

```
[richel@r480 DNABERT_2]$ cp ../ticket_297538_dnabert2/run.sh .
[richel@r480 DNABERT_2]$ cp ../ticket_297538_dnabert2/example_dnabert2_with_triton.py .
[richel@r480 DNABERT_2]$ ./run.sh 
Hello world
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
/home/richel/.local/lib/python3.8/site-packages/transformers/modeling_utils.py:446: FutureWarning: You are using `torch.load` with `weights_only=False` (the current default value), which uses the default pickle module implicitly. It is possible to construct malicious pickle data which will execute arbitrary code during unpickling (See https://github.com/pytorch/pytorch/blob/main/SECURITY.md#untrusted-models for more details). In a future release, the default value for `weights_only` will be flipped to `True`. This limits the functions that could be executed during unpickling. Arbitrary objects will no longer be allowed to be loaded via this mode unless they are explicitly allowlisted by the user via `torch.serialization.add_safe_globals`. We recommend you start setting `weights_only=True` for any use case where you don't have full control of the loaded file. Please open an issue on GitHub for any issues related to this experimental feature.
  return torch.load(checkpoint_file, map_location="cpu")
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.decoder.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.transform.LayerNorm.bias', 'cls.predictions.transform.dense.bias', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.weight', 'bert.pooler.dense.bias']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.decoder.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.transform.LayerNorm.bias', 'cls.predictions.transform.dense.bias', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.weight', 'bert.pooler.dense.bias']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Traceback (most recent call last):
  File "example_dnabert2_with_triton.py", line 16, in <module>
    hidden_states = model(inputs)[0] # [1, sequence_length, 768]
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 609, in forward
    encoder_outputs = self.encoder(
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 447, in forward
    hidden_states = layer_module(hidden_states,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 328, in forward
    attention_output = self.attention(hidden_states, cu_seqlens, seqlen,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 241, in forward
    self_output = self.self(input_tensor, cu_seqlens, max_s, indices,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 182, in forward
    attention = flash_attn_qkvpacked_func(qkv, bias)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/autograd/function.py", line 574, in apply
    return super().apply(*args, **kwargs)  # type: ignore[misc]
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 1021, in forward
    o, lse, ctx.softmax_scale = _flash_attn_forward(
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 781, in _flash_attn_forward
    assert q.is_cuda and k.is_cuda and v.is_cuda
AssertionError
```



### [FAILS] 2d: Run from `/home/richel`

Same as 2c

### [FAILS] 2c: Install to `/home/richel`

```
[richel@r480 ticket_297538_dnabert2]$ ./install_and_run.sh 
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: triton in /domus/h1/richel/.local/lib/python3.8/site-packages (3.0.0)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from triton) (3.0.12)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: cmake in /domus/h1/richel/.local/lib/python3.8/site-packages (3.30.3)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Cloning into 'DNABERT_2'...
remote: Enumerating objects: 98, done.
remote: Counting objects: 100% (34/34), done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 98 (delta 18), reused 24 (delta 15), pack-reused 64 (from 1)
Unpacking objects: 100% (98/98), done.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: einops in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 1)) (0.8.0)
Requirement already satisfied: transformers==4.29.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 2)) (4.29.2)
Requirement already satisfied: peft in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 3)) (0.12.0)
Requirement already satisfied: omegaconf in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 4)) (2.3.0)
Requirement already satisfied: torch in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 5)) (2.4.1)
Requirement already satisfied: evaluate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 6)) (0.4.2)
Requirement already satisfied: accelerate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 7)) (0.34.2)
Requirement already satisfied: numpy>=1.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (1.20.0)
Requirement already satisfied: pyyaml>=5.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (5.4.1)
Requirement already satisfied: huggingface-hub<1.0,>=0.14.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.24.6)
Requirement already satisfied: packaging>=20.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (20.9)
Requirement already satisfied: tokenizers!=0.11.3,<0.14,>=0.11.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.13.3)
Requirement already satisfied: requests in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2.32.3)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (3.0.12)
Requirement already satisfied: tqdm>=4.27 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (4.66.5)
Requirement already satisfied: regex!=2019.12.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2020.11.13)
Requirement already satisfied: typing-extensions>=3.7.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (4.12.2)
Requirement already satisfied: fsspec>=2023.5.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (2024.6.1)
Requirement already satisfied: pyparsing>=2.0.2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from packaging>=20.0->transformers==4.29.2->-r requirements.txt (line 2)) (2.4.7)
Requirement already satisfied: safetensors>=0.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (0.4.5)
Requirement already satisfied: psutil in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (6.0.0)
Requirement already satisfied: nvidia-cuda-runtime-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-nvtx-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: triton==3.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (3.0.0)
Requirement already satisfied: nvidia-cusparse-cu12==12.1.0.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.0.106)
Requirement already satisfied: nvidia-nccl-cu12==2.20.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.20.5)
Requirement already satisfied: nvidia-curand-cu12==10.3.2.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (10.3.2.106)
Requirement already satisfied: jinja2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.11.3)
Requirement already satisfied: networkx in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.5)
Requirement already satisfied: nvidia-cuda-nvrtc-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-cufft-cu12==11.0.2.54 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.0.2.54)
Requirement already satisfied: nvidia-cusolver-cu12==11.4.5.107 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.4.5.107)
Requirement already satisfied: nvidia-cudnn-cu12==9.1.0.70 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (9.1.0.70)
Requirement already satisfied: sympy in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (1.13.2)
Requirement already satisfied: nvidia-cublas-cu12==12.1.3.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.3.1)
Requirement already satisfied: nvidia-cuda-cupti-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-nvjitlink-cu12 in /domus/h1/richel/.local/lib/python3.8/site-packages (from nvidia-cusolver-cu12==11.4.5.107->torch->-r requirements.txt (line 5)) (12.6.68)
Requirement already satisfied: pandas in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (1.2.1)
Requirement already satisfied: multiprocess in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.70.16)
Requirement already satisfied: datasets>=2.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (2.21.0)
Requirement already satisfied: xxhash in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (3.5.0)
Requirement already satisfied: dill in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.3.8)
Requirement already satisfied: aiohttp in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (3.10.5)
Requirement already satisfied: pyarrow>=15.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (17.0.0)
Requirement already satisfied: frozenlist>=1.1.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.4.1)
Requirement already satisfied: multidict<7.0,>=4.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (6.1.0)
Requirement already satisfied: yarl<2.0,>=1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.11.1)
Requirement already satisfied: aiohappyeyeballs>=2.3.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (2.4.0)
Requirement already satisfied: aiosignal>=1.1.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.3.1)
Requirement already satisfied: attrs>=17.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (20.3.0)
Requirement already satisfied: async-timeout<5.0,>=4.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (4.0.3)
Requirement already satisfied: idna<4,>=2.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2.10)
Requirement already satisfied: charset-normalizer<4,>=2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (3.3.2)
Requirement already satisfied: certifi>=2017.4.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2020.12.5)
Requirement already satisfied: urllib3<3,>=1.21.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (1.26.3)
Requirement already satisfied: antlr4-python3-runtime==4.9.* in /domus/h1/richel/.local/lib/python3.8/site-packages (from omegaconf->-r requirements.txt (line 4)) (4.9.3)
Requirement already satisfied: MarkupSafe>=0.23 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from jinja2->torch->-r requirements.txt (line 5)) (1.1.1)
Requirement already satisfied: decorator>=4.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from networkx->torch->-r requirements.txt (line 5)) (4.4.2)
Requirement already satisfied: pytz>=2017.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2021.1)
Requirement already satisfied: python-dateutil>=2.7.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2.8.1)
Requirement already satisfied: six>=1.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from python-dateutil>=2.7.3->pandas->evaluate->-r requirements.txt (line 6)) (1.15.0)
Requirement already satisfied: mpmath<1.4,>=1.1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from sympy->torch->-r requirements.txt (line 5)) (1.3.0)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3 -m pip install --upgrade pip' command.
Hello world
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
/home/richel/.local/lib/python3.8/site-packages/transformers/modeling_utils.py:446: FutureWarning: You are using `torch.load` with `weights_only=False` (the current default value), which uses the default pickle module implicitly. It is possible to construct malicious pickle data which will execute arbitrary code during unpickling (See https://github.com/pytorch/pytorch/blob/main/SECURITY.md#untrusted-models for more details). In a future release, the default value for `weights_only` will be flipped to `True`. This limits the functions that could be executed during unpickling. Arbitrary objects will no longer be allowed to be loaded via this mode unless they are explicitly allowlisted by the user via `torch.serialization.add_safe_globals`. We recommend you start setting `weights_only=True` for any use case where you don't have full control of the loaded file. Please open an issue on GitHub for any issues related to this experimental feature.
  return torch.load(checkpoint_file, map_location="cpu")
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.transform.dense.bias', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.decoder.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.LayerNorm.bias', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.transform.dense.bias', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.decoder.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.LayerNorm.bias', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Traceback (most recent call last):
  File "example_dnabert2_with_triton.py", line 16, in <module>
    hidden_states = model(inputs)[0] # [1, sequence_length, 768]
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 609, in forward
    encoder_outputs = self.encoder(
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 447, in forward
    hidden_states = layer_module(hidden_states,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 328, in forward
    attention_output = self.attention(hidden_states, cu_seqlens, seqlen,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 241, in forward
    self_output = self.self(input_tensor, cu_seqlens, max_s, indices,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 182, in forward
    attention = flash_attn_qkvpacked_func(qkv, bias)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/autograd/function.py", line 574, in apply
    return super().apply(*args, **kwargs)  # type: ignore[misc]
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 1021, in forward
    o, lse, ctx.softmax_scale = _flash_attn_forward(
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 781, in _flash_attn_forward
    assert q.is_cuda and k.is_cuda and v.is_cuda
AssertionError
```


### [FAILS] 2b: Install to `/proj/staff/richel`

```
#!/bin/bash
module load python/3.8.7
pip install triton
pip install cmake

# Folder where DNABERT2 will be installed in
DNABERT_2_SUPERFOLDER=/proj/staff/richel

{
  cd "${DNABERT_2_SUPERFOLDER}" || exit
  git clone https://github.com/MAGICS-LAB/DNABERT_2
  cd DNABERT_2 || exit
  python3 -m pip install -r requirements.txt
}

./run.sh
```

```
[richel@r480 ticket_297538_dnabert2]$ ./install_and_run.sh 
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: triton in /domus/h1/richel/.local/lib/python3.8/site-packages (3.0.0)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from triton) (3.0.12)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: cmake in /domus/h1/richel/.local/lib/python3.8/site-packages (3.30.3)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Cloning into 'DNABERT_2'...
remote: Enumerating objects: 98, done.
remote: Counting objects: 100% (34/34), done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 98 (delta 18), reused 24 (delta 15), pack-reused 64 (from 1)
Unpacking objects: 100% (98/98), done.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: einops in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 1)) (0.8.0)
Requirement already satisfied: transformers==4.29.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 2)) (4.29.2)
Requirement already satisfied: peft in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 3)) (0.12.0)
Requirement already satisfied: omegaconf in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 4)) (2.3.0)
Requirement already satisfied: torch in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 5)) (2.4.1)
Requirement already satisfied: evaluate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 6)) (0.4.2)
Requirement already satisfied: accelerate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 7)) (0.34.2)
Requirement already satisfied: packaging>=20.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (20.9)
Requirement already satisfied: tqdm>=4.27 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (4.66.5)
Requirement already satisfied: regex!=2019.12.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2020.11.13)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (3.0.12)
Requirement already satisfied: huggingface-hub<1.0,>=0.14.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.24.6)
Requirement already satisfied: requests in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2.32.3)
Requirement already satisfied: numpy>=1.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (1.20.0)
Requirement already satisfied: pyyaml>=5.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (5.4.1)
Requirement already satisfied: tokenizers!=0.11.3,<0.14,>=0.11.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.13.3)
Requirement already satisfied: typing-extensions>=3.7.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (4.12.2)
Requirement already satisfied: fsspec>=2023.5.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (2024.6.1)
Requirement already satisfied: pyparsing>=2.0.2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from packaging>=20.0->transformers==4.29.2->-r requirements.txt (line 2)) (2.4.7)
Requirement already satisfied: safetensors>=0.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (0.4.5)
Requirement already satisfied: psutil in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (6.0.0)
Requirement already satisfied: sympy in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (1.13.2)
Requirement already satisfied: nvidia-nvtx-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: networkx in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.5)
Requirement already satisfied: nvidia-cufft-cu12==11.0.2.54 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.0.2.54)
Requirement already satisfied: nvidia-cuda-nvrtc-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-cusparse-cu12==12.1.0.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.0.106)
Requirement already satisfied: nvidia-cuda-cupti-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-cudnn-cu12==9.1.0.70 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (9.1.0.70)
Requirement already satisfied: nvidia-cublas-cu12==12.1.3.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.3.1)
Requirement already satisfied: nvidia-cusolver-cu12==11.4.5.107 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.4.5.107)
Requirement already satisfied: nvidia-nccl-cu12==2.20.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.20.5)
Requirement already satisfied: nvidia-curand-cu12==10.3.2.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (10.3.2.106)
Requirement already satisfied: nvidia-cuda-runtime-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: triton==3.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (3.0.0)
Requirement already satisfied: jinja2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.11.3)
Requirement already satisfied: nvidia-nvjitlink-cu12 in /domus/h1/richel/.local/lib/python3.8/site-packages (from nvidia-cusolver-cu12==11.4.5.107->torch->-r requirements.txt (line 5)) (12.6.68)
Requirement already satisfied: datasets>=2.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (2.21.0)
Requirement already satisfied: multiprocess in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.70.16)
Requirement already satisfied: xxhash in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (3.5.0)
Requirement already satisfied: dill in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.3.8)
Requirement already satisfied: pandas in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (1.2.1)
Requirement already satisfied: aiohttp in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (3.10.5)
Requirement already satisfied: pyarrow>=15.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (17.0.0)
Requirement already satisfied: aiohappyeyeballs>=2.3.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (2.4.0)
Requirement already satisfied: yarl<2.0,>=1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.11.1)
Requirement already satisfied: multidict<7.0,>=4.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (6.1.0)
Requirement already satisfied: frozenlist>=1.1.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.4.1)
Requirement already satisfied: async-timeout<5.0,>=4.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (4.0.3)
Requirement already satisfied: attrs>=17.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (20.3.0)
Requirement already satisfied: aiosignal>=1.1.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.3.1)
Requirement already satisfied: urllib3<3,>=1.21.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (1.26.3)
Requirement already satisfied: idna<4,>=2.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2.10)
Requirement already satisfied: charset-normalizer<4,>=2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (3.3.2)
Requirement already satisfied: certifi>=2017.4.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2020.12.5)
Requirement already satisfied: antlr4-python3-runtime==4.9.* in /domus/h1/richel/.local/lib/python3.8/site-packages (from omegaconf->-r requirements.txt (line 4)) (4.9.3)
Requirement already satisfied: MarkupSafe>=0.23 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from jinja2->torch->-r requirements.txt (line 5)) (1.1.1)
Requirement already satisfied: decorator>=4.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from networkx->torch->-r requirements.txt (line 5)) (4.4.2)
Requirement already satisfied: pytz>=2017.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2021.1)
Requirement already satisfied: python-dateutil>=2.7.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2.8.1)
Requirement already satisfied: six>=1.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from python-dateutil>=2.7.3->pandas->evaluate->-r requirements.txt (line 6)) (1.15.0)
Requirement already satisfied: mpmath<1.4,>=1.1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from sympy->torch->-r requirements.txt (line 5)) (1.3.0)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3 -m pip install --upgrade pip' command.
./install_and_run.sh: line 16: ./run.sh: No such file or directory
[richel@r480 ticket_297538_dnabert2]$ ./run.sh 
Hello world
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
/home/richel/.local/lib/python3.8/site-packages/transformers/modeling_utils.py:446: FutureWarning: You are using `torch.load` with `weights_only=False` (the current default value), which uses the default pickle module implicitly. It is possible to construct malicious pickle data which will execute arbitrary code during unpickling (See https://github.com/pytorch/pytorch/blob/main/SECURITY.md#untrusted-models for more details). In a future release, the default value for `weights_only` will be flipped to `True`. This limits the functions that could be executed during unpickling. Arbitrary objects will no longer be allowed to be loaded via this mode unless they are explicitly allowlisted by the user via `torch.serialization.add_safe_globals`. We recommend you start setting `weights_only=True` for any use case where you don't have full control of the loaded file. Please open an issue on GitHub for any issues related to this experimental feature.
  return torch.load(checkpoint_file, map_location="cpu")
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.decoder.bias', 'cls.predictions.transform.dense.bias', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.transform.LayerNorm.bias', 'cls.predictions.decoder.weight', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.decoder.bias', 'cls.predictions.transform.dense.bias', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.transform.LayerNorm.bias', 'cls.predictions.decoder.weight', 'cls.predictions.transform.dense.weight']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.bias', 'bert.pooler.dense.weight']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Traceback (most recent call last):
  File "example_dnabert2_with_triton.py", line 16, in <module>
    hidden_states = model(inputs)[0] # [1, sequence_length, 768]
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 609, in forward
    encoder_outputs = self.encoder(
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 447, in forward
    hidden_states = layer_module(hidden_states,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 328, in forward
    attention_output = self.attention(hidden_states, cu_seqlens, seqlen,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 241, in forward
    self_output = self.self(input_tensor, cu_seqlens, max_s, indices,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 182, in forward
    attention = flash_attn_qkvpacked_func(qkv, bias)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/autograd/function.py", line 574, in apply
    return super().apply(*args, **kwargs)  # type: ignore[misc]
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 1021, in forward
    o, lse, ctx.softmax_scale = _flash_attn_forward(
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 781, in _flash_attn_forward
    assert q.is_cuda and k.is_cuda and v.is_cuda
AssertionError
```


### [FAILS] Attempt 2a: Install to `/proj/staff/richel`

```
#!/bin/bash
module load python/3.8.7
pip install triton
pip install cmake

# Folder where DNABERT2 will be installed in
DNABERT_2_SUPERFOLDER=/proj/staff/richel

{
  cd "$(DNABERT_2_SUPERFOLDER)" || exit # ERROR HERE
  git clone https://github.com/MAGICS-LAB/DNABERT_2
  cd DNABERT_2 || exit
  python3 -m pip install -r requirements.txt
}

./run.sh
```

Gives:

```
[richel@r480 ticket_297538_dnabert2]$ ./install_and_run.sh 
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: triton in /domus/h1/richel/.local/lib/python3.8/site-packages (3.0.0)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from triton) (3.0.12)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: cmake in /domus/h1/richel/.local/lib/python3.8/site-packages (3.30.3)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
./install_and_run.sh: line 9: DNABERT_2_SUPERFOLDER: command not found
fatal: destination path 'DNABERT_2' already exists and is not an empty directory.
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: einops in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 1)) (0.8.0)
Requirement already satisfied: transformers==4.29.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 2)) (4.29.2)
Requirement already satisfied: peft in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 3)) (0.12.0)
Requirement already satisfied: omegaconf in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 4)) (2.3.0)
Requirement already satisfied: torch in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 5)) (2.4.1)
Requirement already satisfied: evaluate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 6)) (0.4.2)
Requirement already satisfied: accelerate in /domus/h1/richel/.local/lib/python3.8/site-packages (from -r requirements.txt (line 7)) (0.34.2)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (3.0.12)
Requirement already satisfied: huggingface-hub<1.0,>=0.14.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.24.6)
Requirement already satisfied: tqdm>=4.27 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (4.66.5)
Requirement already satisfied: numpy>=1.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (1.20.0)
Requirement already satisfied: tokenizers!=0.11.3,<0.14,>=0.11.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (0.13.3)
Requirement already satisfied: regex!=2019.12.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2020.11.13)
Requirement already satisfied: requests in /domus/h1/richel/.local/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2.32.3)
Requirement already satisfied: packaging>=20.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (20.9)
Requirement already satisfied: pyyaml>=5.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (5.4.1)
Requirement already satisfied: typing-extensions>=3.7.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (4.12.2)
Requirement already satisfied: fsspec>=2023.5.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from huggingface-hub<1.0,>=0.14.1->transformers==4.29.2->-r requirements.txt (line 2)) (2024.6.1)
Requirement already satisfied: pyparsing>=2.0.2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from packaging>=20.0->transformers==4.29.2->-r requirements.txt (line 2)) (2.4.7)
Requirement already satisfied: psutil in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (6.0.0)
Requirement already satisfied: safetensors>=0.4.3 in /domus/h1/richel/.local/lib/python3.8/site-packages (from accelerate->-r requirements.txt (line 7)) (0.4.5)
Requirement already satisfied: jinja2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.11.3)
Requirement already satisfied: nvidia-cublas-cu12==12.1.3.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.3.1)
Requirement already satisfied: nvidia-cuda-runtime-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-cusparse-cu12==12.1.0.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.0.106)
Requirement already satisfied: nvidia-cusolver-cu12==11.4.5.107 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.4.5.107)
Requirement already satisfied: nvidia-curand-cu12==10.3.2.106 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (10.3.2.106)
Requirement already satisfied: sympy in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (1.13.2)
Requirement already satisfied: networkx in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.5)
Requirement already satisfied: nvidia-cuda-cupti-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-cudnn-cu12==9.1.0.70 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (9.1.0.70)
Requirement already satisfied: nvidia-cufft-cu12==11.0.2.54 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (11.0.2.54)
Requirement already satisfied: nvidia-nvtx-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: triton==3.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (3.0.0)
Requirement already satisfied: nvidia-nccl-cu12==2.20.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.20.5)
Requirement already satisfied: nvidia-cuda-nvrtc-cu12==12.1.105 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (12.1.105)
Requirement already satisfied: nvidia-nvjitlink-cu12 in /domus/h1/richel/.local/lib/python3.8/site-packages (from nvidia-cusolver-cu12==11.4.5.107->torch->-r requirements.txt (line 5)) (12.6.68)
Requirement already satisfied: datasets>=2.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (2.21.0)
Requirement already satisfied: pandas in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (1.2.1)
Requirement already satisfied: multiprocess in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.70.16)
Requirement already satisfied: xxhash in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (3.5.0)
Requirement already satisfied: dill in /domus/h1/richel/.local/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (0.3.8)
Requirement already satisfied: pyarrow>=15.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (17.0.0)
Requirement already satisfied: aiohttp in /domus/h1/richel/.local/lib/python3.8/site-packages (from datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (3.10.5)
Requirement already satisfied: aiosignal>=1.1.2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.3.1)
Requirement already satisfied: frozenlist>=1.1.1 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.4.1)
Requirement already satisfied: async-timeout<5.0,>=4.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (4.0.3)
Requirement already satisfied: aiohappyeyeballs>=2.3.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (2.4.0)
Requirement already satisfied: attrs>=17.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (20.3.0)
Requirement already satisfied: multidict<7.0,>=4.5 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (6.1.0)
Requirement already satisfied: yarl<2.0,>=1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (1.11.1)
Requirement already satisfied: certifi>=2017.4.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2020.12.5)
Requirement already satisfied: charset-normalizer<4,>=2 in /domus/h1/richel/.local/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (3.3.2)
Requirement already satisfied: urllib3<3,>=1.21.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (1.26.3)
Requirement already satisfied: idna<4,>=2.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2.10)
Requirement already satisfied: antlr4-python3-runtime==4.9.* in /domus/h1/richel/.local/lib/python3.8/site-packages (from omegaconf->-r requirements.txt (line 4)) (4.9.3)
Requirement already satisfied: MarkupSafe>=0.23 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from jinja2->torch->-r requirements.txt (line 5)) (1.1.1)
Requirement already satisfied: decorator>=4.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from networkx->torch->-r requirements.txt (line 5)) (4.4.2)
Requirement already satisfied: pytz>=2017.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2021.1)
Requirement already satisfied: python-dateutil>=2.7.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2.8.1)
Requirement already satisfied: six>=1.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from python-dateutil>=2.7.3->pandas->evaluate->-r requirements.txt (line 6)) (1.15.0)
Requirement already satisfied: mpmath<1.4,>=1.1.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from sympy->torch->-r requirements.txt (line 5)) (1.3.0)
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3 -m pip install --upgrade pip' command.
./install_and_run.sh: line 13: ./run.sh: No such file or directory
[richel@r480 ticket_297538_dnabert2]$ ls
DNABERT_2  example_dnabert2_with_triton.py  install_and_run.sh	LICENSE  README.md  run.sh  singularity
[richel@r480 ticket_297538_dnabert2]$ ./run.sh 
Hello world
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
pytorch_model.bin: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 468M/468M [00:01<00:00, 112MB/s]
/home/richel/.local/lib/python3.8/site-packages/transformers/modeling_utils.py:446: FutureWarning: You are using `torch.load` with `weights_only=False` (the current default value), which uses the default pickle module implicitly. It is possible to construct malicious pickle data which will execute arbitrary code during unpickling (See https://github.com/pytorch/pytorch/blob/main/SECURITY.md#untrusted-models for more details). In a future release, the default value for `weights_only` will be flipped to `True`. This limits the functions that could be executed during unpickling. Arbitrary objects will no longer be allowed to be loaded via this mode unless they are explicitly allowlisted by the user via `torch.serialization.add_safe_globals`. We recommend you start setting `weights_only=True` for any use case where you don't have full control of the loaded file. Please open an issue on GitHub for any issues related to this experimental feature.
  return torch.load(checkpoint_file, map_location="cpu")
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.transform.LayerNorm.bias', 'cls.predictions.decoder.weight', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.transform.dense.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.dense.bias']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.weight', 'bert.pooler.dense.bias']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Some weights of the model checkpoint at zhihan1996/DNABERT-2-117M were not used when initializing BertModel: ['cls.predictions.transform.LayerNorm.bias', 'cls.predictions.decoder.weight', 'cls.predictions.transform.LayerNorm.weight', 'cls.predictions.transform.dense.weight', 'cls.predictions.decoder.bias', 'cls.predictions.transform.dense.bias']
- This IS expected if you are initializing BertModel from the checkpoint of a model trained on another task or with another architecture (e.g. initializing a BertForSequenceClassification model from a BertForPreTraining model).
- This IS NOT expected if you are initializing BertModel from the checkpoint of a model that you expect to be exactly identical (initializing a BertForSequenceClassification model from a BertForSequenceClassification model).
Some weights of BertModel were not initialized from the model checkpoint at zhihan1996/DNABERT-2-117M and are newly initialized: ['bert.pooler.dense.weight', 'bert.pooler.dense.bias']
You should probably TRAIN this model on a down-stream task to be able to use it for predictions and inference.
Traceback (most recent call last):
  File "example_dnabert2_with_triton.py", line 16, in <module>
    hidden_states = model(inputs)[0] # [1, sequence_length, 768]
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 609, in forward
    encoder_outputs = self.encoder(
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 447, in forward
    hidden_states = layer_module(hidden_states,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 328, in forward
    attention_output = self.attention(hidden_states, cu_seqlens, seqlen,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 241, in forward
    self_output = self.self(input_tensor, cu_seqlens, max_s, indices,
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1553, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/nn/modules/module.py", line 1562, in _call_impl
    return forward_call(*args, **kwargs)
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/bert_layers.py", line 182, in forward
    attention = flash_attn_qkvpacked_func(qkv, bias)
  File "/home/richel/.local/lib/python3.8/site-packages/torch/autograd/function.py", line 574, in apply
    return super().apply(*args, **kwargs)  # type: ignore[misc]
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 1021, in forward
    o, lse, ctx.softmax_scale = _flash_attn_forward(
  File "/home/richel/.cache/huggingface/modules/transformers_modules/zhihan1996/DNABERT-2-117M/d064dece8a8b41d9fb8729fbe3435278786931f1/flash_attn_triton.py", line 781, in _flash_attn_forward
    assert q.is_cuda and k.is_cuda and v.is_cuda
AssertionError
```


### [FAILS] Attempt 2z: Installing to home folder works

(use 2z to indicate 'before 2a')

```
[richel@r480 ticket_297538]$ ./install_and_run.sh 
Defaulting to user installation because normal site-packages is not writeable
Collecting triton
  Downloading triton-3.0.0-1-cp38-cp38-manylinux2014_x86_64.manylinux_2_17_x86_64.whl (209.4 MB)
     |████████████████████████████████| 209.4 MB 25 kB/s 
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from triton) (3.0.12)
Installing collected packages: triton
  WARNING: The scripts proton and proton-viewer are installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed triton-3.0.0
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
Defaulting to user installation because normal site-packages is not writeable
Collecting cmake
  Downloading cmake-3.30.3-py3-none-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (26.9 MB)
     |████████████████████████████████| 26.9 MB 8.5 MB/s 
Installing collected packages: cmake
  WARNING: The scripts cmake, cpack and ctest are installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed cmake-3.30.3
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3.8 -m pip install --upgrade pip' command.
./install_and_run.sh: line 9: DNABERT_2_SUPERFOLDER: command not found
Cloning into 'DNABERT_2'...
remote: Enumerating objects: 98, done.
remote: Counting objects: 100% (34/34), done.
remote: Compressing objects: 100% (19/19), done.
remote: Total 98 (delta 18), reused 24 (delta 15), pack-reused 64 (from 1)
Unpacking objects: 100% (98/98), done.
Defaulting to user installation because normal site-packages is not writeable
Collecting einops
  Downloading einops-0.8.0-py3-none-any.whl (43 kB)
     |████████████████████████████████| 43 kB 752 kB/s 
Collecting transformers==4.29.2
  Downloading transformers-4.29.2-py3-none-any.whl (7.1 MB)
     |████████████████████████████████| 7.1 MB 11.9 MB/s 
Collecting peft
  Downloading peft-0.12.0-py3-none-any.whl (296 kB)
     |████████████████████████████████| 296 kB 58.7 MB/s 
Collecting omegaconf
  Downloading omegaconf-2.3.0-py3-none-any.whl (79 kB)
     |████████████████████████████████| 79 kB 7.6 MB/s 
Collecting torch
  Downloading torch-2.4.1-cp38-cp38-manylinux1_x86_64.whl (797.1 MB)
     |████████████████████████████████| 797.1 MB 4.6 kB/s 
Collecting evaluate
  Downloading evaluate-0.4.2-py3-none-any.whl (84 kB)
     |████████████████████████████████| 84 kB 1.2 MB/s 
Collecting accelerate
  Downloading accelerate-0.34.2-py3-none-any.whl (324 kB)
     |████████████████████████████████| 324 kB 42.8 MB/s 
Requirement already satisfied: numpy>=1.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (1.20.0)
Requirement already satisfied: filelock in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (3.0.12)
Requirement already satisfied: requests in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2.25.1)
Requirement already satisfied: tqdm>=4.27 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (4.56.0)
Requirement already satisfied: pyyaml>=5.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (5.4.1)
Requirement already satisfied: packaging>=20.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (20.9)
Requirement already satisfied: regex!=2019.12.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from transformers==4.29.2->-r requirements.txt (line 2)) (2020.11.13)
Collecting huggingface-hub<1.0,>=0.14.1
  Downloading huggingface_hub-0.24.6-py3-none-any.whl (417 kB)
     |████████████████████████████████| 417 kB 46.4 MB/s 
Collecting tokenizers!=0.11.3,<0.14,>=0.11.1
  Downloading tokenizers-0.13.3-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (7.8 MB)
     |████████████████████████████████| 7.8 MB 24.2 MB/s 
Collecting fsspec>=2023.5.0
  Downloading fsspec-2024.9.0-py3-none-any.whl (179 kB)
     |████████████████████████████████| 179 kB 44.3 MB/s 
Collecting typing-extensions>=3.7.4.3
  Downloading typing_extensions-4.12.2-py3-none-any.whl (37 kB)
Requirement already satisfied: pyparsing>=2.0.2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from packaging>=20.0->transformers==4.29.2->-r requirements.txt (line 2)) (2.4.7)
Collecting safetensors>=0.4.3
  Downloading safetensors-0.4.5-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (436 kB)
     |████████████████████████████████| 436 kB 45.3 MB/s 
Collecting psutil
  Downloading psutil-6.0.0-cp36-abi3-manylinux_2_12_x86_64.manylinux2010_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (290 kB)
     |████████████████████████████████| 290 kB 46.1 MB/s 
Collecting nvidia-cuda-cupti-cu12==12.1.105
  Using cached nvidia_cuda_cupti_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (14.1 MB)
Requirement already satisfied: networkx in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.5)
Collecting nvidia-cuda-nvrtc-cu12==12.1.105
  Using cached nvidia_cuda_nvrtc_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (23.7 MB)
Collecting nvidia-nccl-cu12==2.20.5
  Downloading nvidia_nccl_cu12-2.20.5-py3-none-manylinux2014_x86_64.whl (176.2 MB)
     |████████████████████████████████| 176.2 MB 44 kB/s 
Requirement already satisfied: triton==3.0.0 in /domus/h1/richel/.local/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (3.0.0)
Collecting nvidia-cublas-cu12==12.1.3.1
  Using cached nvidia_cublas_cu12-12.1.3.1-py3-none-manylinux1_x86_64.whl (410.6 MB)
Collecting nvidia-cusparse-cu12==12.1.0.106
  Using cached nvidia_cusparse_cu12-12.1.0.106-py3-none-manylinux1_x86_64.whl (196.0 MB)
Collecting nvidia-cufft-cu12==11.0.2.54
  Using cached nvidia_cufft_cu12-11.0.2.54-py3-none-manylinux1_x86_64.whl (121.6 MB)
Requirement already satisfied: jinja2 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from torch->-r requirements.txt (line 5)) (2.11.3)
Collecting nvidia-cudnn-cu12==9.1.0.70
  Downloading nvidia_cudnn_cu12-9.1.0.70-py3-none-manylinux2014_x86_64.whl (664.8 MB)
     |████████████████████████████████| 664.8 MB 3.8 kB/s 
Collecting nvidia-cuda-runtime-cu12==12.1.105
  Using cached nvidia_cuda_runtime_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (823 kB)
Collecting nvidia-cusolver-cu12==11.4.5.107
  Using cached nvidia_cusolver_cu12-11.4.5.107-py3-none-manylinux1_x86_64.whl (124.2 MB)
Collecting nvidia-nvtx-cu12==12.1.105
  Using cached nvidia_nvtx_cu12-12.1.105-py3-none-manylinux1_x86_64.whl (99 kB)
Collecting sympy
  Downloading sympy-1.13.2-py3-none-any.whl (6.2 MB)
     |████████████████████████████████| 6.2 MB 63.7 MB/s 
Collecting nvidia-curand-cu12==10.3.2.106
  Using cached nvidia_curand_cu12-10.3.2.106-py3-none-manylinux1_x86_64.whl (56.5 MB)
Collecting nvidia-nvjitlink-cu12
  Downloading nvidia_nvjitlink_cu12-12.6.68-py3-none-manylinux2014_x86_64.whl (19.7 MB)
     |████████████████████████████████| 19.7 MB 68.3 MB/s 
Requirement already satisfied: pandas in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (1.2.1)
Collecting tqdm>=4.27
  Downloading tqdm-4.66.5-py3-none-any.whl (78 kB)
     |████████████████████████████████| 78 kB 1.4 MB/s 
Requirement already satisfied: fsspec[http]>=2021.05.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from evaluate->-r requirements.txt (line 6)) (2022.11.0)
Collecting dill
  Downloading dill-0.3.8-py3-none-any.whl (116 kB)
     |████████████████████████████████| 116 kB 66.2 MB/s 
Collecting multiprocess
  Downloading multiprocess-0.70.16-py38-none-any.whl (132 kB)
     |████████████████████████████████| 132 kB 64.1 MB/s 
Collecting datasets>=2.0.0
  Downloading datasets-2.21.0-py3-none-any.whl (527 kB)
     |████████████████████████████████| 527 kB 67.2 MB/s 
Collecting xxhash
  Downloading xxhash-3.5.0-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (194 kB)
     |████████████████████████████████| 194 kB 50.5 MB/s 
Collecting pyarrow>=15.0.0
  Downloading pyarrow-17.0.0-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (40.0 MB)
     |████████████████████████████████| 40.0 MB 69.1 MB/s 
Collecting requests
  Downloading requests-2.32.3-py3-none-any.whl (64 kB)
     |████████████████████████████████| 64 kB 1.2 MB/s 
Collecting aiohttp
  Downloading aiohttp-3.10.5-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (1.3 MB)
     |████████████████████████████████| 1.3 MB 40.4 MB/s 
Collecting fsspec[http]>=2021.05.0
  Downloading fsspec-2024.6.1-py3-none-any.whl (177 kB)
     |████████████████████████████████| 177 kB 60.6 MB/s 
Collecting yarl<2.0,>=1.0
  Downloading yarl-1.11.1-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (460 kB)
     |████████████████████████████████| 460 kB 69.3 MB/s 
Collecting async-timeout<5.0,>=4.0
  Downloading async_timeout-4.0.3-py3-none-any.whl (5.7 kB)
Collecting multidict<7.0,>=4.5
  Downloading multidict-6.1.0-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (129 kB)
     |████████████████████████████████| 129 kB 64.6 MB/s 
Collecting frozenlist>=1.1.1
  Downloading frozenlist-1.4.1-cp38-cp38-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_17_x86_64.manylinux2014_x86_64.whl (240 kB)
     |████████████████████████████████| 240 kB 67.5 MB/s 
Collecting aiohappyeyeballs>=2.3.0
  Downloading aiohappyeyeballs-2.4.0-py3-none-any.whl (12 kB)
Requirement already satisfied: attrs>=17.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from aiohttp->datasets>=2.0.0->evaluate->-r requirements.txt (line 6)) (20.3.0)
Collecting aiosignal>=1.1.2
  Downloading aiosignal-1.3.1-py3-none-any.whl (7.6 kB)
Requirement already satisfied: certifi>=2017.4.17 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2020.12.5)
Requirement already satisfied: idna<4,>=2.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (2.10)
Collecting charset-normalizer<4,>=2
  Downloading charset_normalizer-3.3.2-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (141 kB)
     |████████████████████████████████| 141 kB 70.9 MB/s 
Requirement already satisfied: urllib3<3,>=1.21.1 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from requests->transformers==4.29.2->-r requirements.txt (line 2)) (1.26.3)
Collecting antlr4-python3-runtime==4.9.*
  Downloading antlr4-python3-runtime-4.9.3.tar.gz (117 kB)
     |████████████████████████████████| 117 kB 70.9 MB/s 
Requirement already satisfied: MarkupSafe>=0.23 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from jinja2->torch->-r requirements.txt (line 5)) (1.1.1)
Requirement already satisfied: decorator>=4.3.0 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from networkx->torch->-r requirements.txt (line 5)) (4.4.2)
Requirement already satisfied: pytz>=2017.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2021.1)
Requirement already satisfied: python-dateutil>=2.7.3 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from pandas->evaluate->-r requirements.txt (line 6)) (2.8.1)
Requirement already satisfied: six>=1.5 in /sw/comp/python/3.8.7_rackham/lib/python3.8/site-packages (from python-dateutil>=2.7.3->pandas->evaluate->-r requirements.txt (line 6)) (1.15.0)
Collecting mpmath<1.4,>=1.1.0
  Using cached mpmath-1.3.0-py3-none-any.whl (536 kB)
Building wheels for collected packages: antlr4-python3-runtime
  Building wheel for antlr4-python3-runtime (setup.py) ... done
  Created wheel for antlr4-python3-runtime: filename=antlr4_python3_runtime-4.9.3-py3-none-any.whl size=144573 sha256=b3dbb293bbeee258d121f0af28f2fb284d5504ba075b255f7f86ade0d8881af5
  Stored in directory: /domus/h1/richel/.cache/pip/wheels/b1/a3/c2/6df046c09459b73cc9bb6c4401b0be6c47048baf9a1617c485
Successfully built antlr4-python3-runtime
Installing collected packages: typing-extensions, nvidia-nvjitlink-cu12, multidict, frozenlist, yarl, nvidia-cusparse-cu12, nvidia-cublas-cu12, mpmath, charset-normalizer, async-timeout, aiosignal, aiohappyeyeballs, tqdm, sympy, requests, nvidia-nvtx-cu12, nvidia-nccl-cu12, nvidia-cusolver-cu12, nvidia-curand-cu12, nvidia-cufft-cu12, nvidia-cudnn-cu12, nvidia-cuda-runtime-cu12, nvidia-cuda-nvrtc-cu12, nvidia-cuda-cupti-cu12, fsspec, dill, aiohttp, xxhash, torch, tokenizers, safetensors, pyarrow, psutil, multiprocess, huggingface-hub, transformers, datasets, antlr4-python3-runtime, accelerate, peft, omegaconf, evaluate, einops
  WARNING: The script normalizer is installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script tqdm is installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script isympy is installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The scripts convert-caffe2-to-onnx, convert-onnx-to-caffe2 and torchrun are installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script huggingface-cli is installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script transformers-cli is installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script datasets-cli is installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The scripts accelerate, accelerate-config, accelerate-estimate-memory, accelerate-launch and accelerate-merge-weights are installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script evaluate-cli is installed in '/home/richel/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed accelerate-0.34.2 aiohappyeyeballs-2.4.0 aiohttp-3.10.5 aiosignal-1.3.1 antlr4-python3-runtime-4.9.3 async-timeout-4.0.3 charset-normalizer-3.3.2 datasets-2.21.0 dill-0.3.8 einops-0.8.0 evaluate-0.4.2 frozenlist-1.4.1 fsspec-2024.6.1 huggingface-hub-0.24.6 mpmath-1.3.0 multidict-6.1.0 multiprocess-0.70.16 nvidia-cublas-cu12-12.1.3.1 nvidia-cuda-cupti-cu12-12.1.105 nvidia-cuda-nvrtc-cu12-12.1.105 nvidia-cuda-runtime-cu12-12.1.105 nvidia-cudnn-cu12-9.1.0.70 nvidia-cufft-cu12-11.0.2.54 nvidia-curand-cu12-10.3.2.106 nvidia-cusolver-cu12-11.4.5.107 nvidia-cusparse-cu12-12.1.0.106 nvidia-nccl-cu12-2.20.5 nvidia-nvjitlink-cu12-12.6.68 nvidia-nvtx-cu12-12.1.105 omegaconf-2.3.0 peft-0.12.0 psutil-6.0.0 pyarrow-17.0.0 requests-2.32.3 safetensors-0.4.5 sympy-1.13.2 tokenizers-0.13.3 torch-2.4.1 tqdm-4.66.5 transformers-4.29.2 typing-extensions-4.12.2 xxhash-3.5.0 yarl-1.11.1
WARNING: You are using pip version 21.0.1; however, version 24.2 is available.
You should consider upgrading via the '/sw/comp/python/3.8.7_rackham/bin/python3 -m pip install --upgrade pip' command.
python3: can't open file 'example_dnabert2_with_triton.py': [Errno 2] No such file or directory
```

Then with `python` it seems to work:

```
[richel@r480 ticket_297538]$ ./run.sh 
Hello world
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
tokenizer_config.json: 100%|███████████████████| 158/158 [00:00<00:00, 12.5kB/s]
tokenizer.json: 100%|████████████████████████| 168k/168k [00:00<00:00, 12.1MB/s]
config.json: 100%|██████████████████████████████| 904/904 [00:00<00:00, 179kB/s]
configuration_bert.py: 100%|████████████████| 1.01k/1.01k [00:00<00:00, 429kB/s]
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- configuration_bert.py
. Make sure to double-check they do not contain any added malicious code. To avoid downloading new versions of the code file, you can pin a revision.
bert_layers.py: 100%|██████████████████████| 40.7k/40.7k [00:00<00:00, 16.6MB/s]
flash_attn_triton.py: 100%|████████████████| 42.7k/42.7k [00:00<00:00, 17.0MB/s]
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- flash_attn_triton.py
. Make sure to double-check they do not contain any added malicious code. To avoid downloading new versions of the code file, you can pin a revision.
bert_padding.py: 100%|█████████████████████| 6.10k/6.10k [00:00<00:00, 2.62MB/s]
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- bert_padding.py
. Make sure to double-check they do not contain any added malicious code. To avoid downloading new versions of the code file, you can pin a revision.
A new version of the following files was downloaded from https://huggingface.co/zhihan1996/DNABERT-2-117M:
- bert_layers.py
- flash_attn_triton.py
- bert_padding.py
. Make sure to double-check they do not contain any added malicious code. To avoid downloading new versions of the code file, you can pin a revision.
/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py:1150: FutureWarning: `resume_download` is deprecated and will be removed in version 1.0.0. Downloads always resume when possible. If you want to force a new download, use `force_download=True`.
  warnings.warn(
pytorch_model.bin: 100%|██████████████████████| 468M/468M [00:04<00:00, 116MB/s]
Traceback (most recent call last):
  File "example_dnabert2_with_triton.py", line 7, in <module>
    model = AutoModel.from_pretrained("zhihan1996/DNABERT-2-117M", trust_remote_code=True)
  File "/home/richel/.local/lib/python3.8/site-packages/transformers/models/auto/auto_factory.py", line 462, in from_pretrained
    return model_class.from_pretrained(
  File "/home/richel/.local/lib/python3.8/site-packages/transformers/modeling_utils.py", line 2452, in from_pretrained
    resolved_archive_file = cached_file(
  File "/home/richel/.local/lib/python3.8/site-packages/transformers/utils/hub.py", line 417, in cached_file
    resolved_file = hf_hub_download(
  File "/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/utils/_deprecation.py", line 101, in inner_f
    return f(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/utils/_validators.py", line 114, in _inner_fn
    return fn(*args, **kwargs)
  File "/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py", line 1240, in hf_hub_download
    return _hf_hub_download_to_cache_dir(
  File "/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py", line 1389, in _hf_hub_download_to_cache_dir
    _download_to_tmp_and_move(
  File "/home/richel/.local/lib/python3.8/site-packages/huggingface_hub/file_download.py", line 1915, in _download_to_tmp_and_move
    http_get(
OSError: [Errno 122] Disk quota exceeded
```


## [FAILS] Approach 1: Singularity


See <Singularity/README.md> for those notes


