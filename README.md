# Kaldi Pre-compiled Binaries for ARM aarch64

Pre-compiled [Kaldi](https://kaldi-asr.org/) speech recognition toolkit binaries for **ARM aarch64** (64-bit) devices such as Raspberry Pi 4/5.

No need to compile from source — just clone, install, and run.

## System Requirements

| Requirement | Details |
|-------------|---------|
| **Architecture** | ARM aarch64 (64-bit) |
| **OS** | Linux (Raspberry Pi OS 64-bit, Ubuntu ARM64, Debian ARM64) |
| **RAM** | 2 GB minimum (4 GB+ recommended) |
| **Disk** | ~500 MB for the repo, ~400 MB after install |

### Dependencies

```bash
# Debian / Ubuntu / Raspberry Pi OS
sudo apt-get update && sudo apt-get install -y \
    libgfortran5 \
    libatlas-base-dev
```

## Quick Start

```bash
# Clone the repo
git clone https://github.com/KR4YIR/kaldi-arm-prebuilt.git
cd kaldi-arm-prebuilt

# Run the installer
chmod +x install.sh
sudo ./install.sh

# Verify
acc-lda --help
decode-faster --help
```

## Manual Installation

If you prefer not to use the install script:

```bash
# Copy binaries
sudo cp bin/* /usr/local/bin/

# Copy libraries
sudo mkdir -p /usr/local/lib/kaldi
sudo cp lib/*.so* /usr/local/lib/kaldi/

# Register libraries
echo "/usr/local/lib/kaldi" | sudo tee /etc/ld.so.conf.d/kaldi.conf
sudo ldconfig

# Test
acc-lda --help
```

## Repository Structure

```
kaldi-arm-prebuilt/
├── bin/           # 75 Kaldi executable binaries (aarch64)
├── lib/           # Shared libraries (.so) + OpenFST + OpenBLAS
├── install.sh     # Automated installer script
├── LICENSE        # Apache License 2.0
├── COPYING        # Kaldi copyright notice
└── README.md
```

## Included Binaries (75 tools)

### Decoding & Lattice Generation
- `decode-faster` / `decode-faster-mapped` — FST-based decoders
- `latgen-faster-mapped` / `latgen-faster-mapped-parallel` — Lattice generating decoders
- `latgen-incremental-mapped` — Incremental lattice generation

### GMM & Acoustic Models
- `am-info` — Display acoustic model information
- `hmm-info` — Display HMM-GMM model info
- `est-lda` / `est-mllt` / `est-pca` — Estimation of LDA, MLLT, and PCA transforms
- `acc-lda` / `acc-tree-stats` — Accumulate statistics

### Alignment
- `align-compiled-mapped` / `align-equal` / `align-equal-compiled` / `align-mapped` — Various alignment methods
- `align-text` — Text alignment
- `ali-to-pdf` / `ali-to-phones` / `ali-to-post` — Convert alignments

### Graph Compilation
- `compile-graph` / `compile-train-graphs` / `compile-train-graphs-fsts` — Compile decoding graphs
- `compile-questions` — Compile questions for tree building
- `make-h-transducer` / `make-ilabel-transducer` — Build transducers

### Feature & Posterior Utilities
- `compute-gop` — Goodness of Pronunciation scoring
- `compute-wer` / `compute-wer-bootci` — Word Error Rate computation
- `copy-matrix` / `copy-vector` / `copy-post` — Data copy tools
- `matrix-sum` / `vector-sum` / `sum-post` — Summation tools
- `post-to-weights` / `post-to-pdf-post` / `post-to-phone-post` — Posterior transformers

### Tree Building
- `build-tree` / `build-tree-two-level` — Phonetic decision tree building
- `cluster-phones` — Phone clustering
- `tree-info` / `draw-tree` — Tree inspection

## Included Libraries

| Library | Description |
|---------|-------------|
| `libkaldi-decoder.so` | Decoders (Viterbi, lattice generation) |
| `libkaldi-nnet3.so` | DNN / neural network (nnet3) |
| `libkaldi-nnet2.so` | Neural network (nnet2) |
| `libkaldi-lat.so` | Lattice operations |
| `libkaldi-hmm.so` | HMM topology and transitions |
| `libkaldi-gmm.so` | Gaussian Mixture Models |
| `libkaldi-feat.so` | Feature extraction (MFCC, PLP, fbank) |
| `libkaldi-matrix.so` | Matrix/vector math |
| `libkaldi-fstext.so` | OpenFst extensions |
| `libkaldi-online2.so` | Online/streaming decoding |
| `libkaldi-rnnlm.so` | RNN Language Model |
| `libkaldi-ivector.so` | i-vector extraction |
| `libkaldi-transform.so` | Feature transforms (LDA, MLLT, fMLLR) |
| `libkaldi-tree.so` | Decision tree building |
| `libkaldi-kws.so` | Keyword search |
| `libkaldi-lm.so` | Language model utilities |
| `libkaldi-chain.so` | Chain model training |
| `libkaldi-nnet.so` | Legacy neural network |
| `libkaldi-base.so` | Base utilities and logging |
| `libkaldi-util.so` | I/O and table utilities |
| `libkaldi-cudamatrix.so` | CUDA matrix (CPU fallback on ARM) |
| `libfst.so` | OpenFST 1.8.4 |
| `libopenblas.so` | OpenBLAS 0.3.13 (ARM optimized) |

## Build Information

| Field | Value |
|-------|-------|
| **Source** | [kaldi-asr/kaldi](https://github.com/kaldi-asr/kaldi) (trunk) |
| **Target** | `aarch64-linux-gnu` |
| **OpenFST** | 1.8.4 |
| **OpenBLAS** | 0.3.13 (ARM v8) |
| **Build date** | March 2026 |
| **Tested on** | Raspberry Pi 5 Model B, 8 GB RAM, Raspberry Pi OS (64-bit) |

## Usage Examples

### Example 1: Inspect a trained model

```bash
am-info final.mdl
```

### Example 2: Decode with a language model

```bash
decode-faster-mapped \
    --beam=13.0 --max-active=7000 --acoustic-scale=0.083333 \
    final.mdl HCLG.fst \
    "ark:feature-source-command|" \
    ark,t:decoded.tra
```

### Example 3: Compute Word Error Rate

```bash
compute-wer --text --mode=present \
    ark:ref.txt ark:hyp.txt
```

## Important Notes

- These binaries are **aarch64 only** — they will NOT run on armhf (32-bit) or x86.
- The `lib/` directory must be accessible to the binaries at runtime. The install script handles this automatically.
- For feature extraction tools (`compute-mfcc-feats`, `compute-fbank-feats`, etc.), you need the `featbin` package — this repo contains only the core `bin` tools.

## License

Apache License 2.0 — see [LICENSE](LICENSE) and [COPYING](COPYING) for details.

## Resources

- [Kaldi Official Website](https://kaldi-asr.org/)
- [Kaldi GitHub](https://github.com/kaldi-asr/kaldi)
- [Kaldi Documentation](https://kaldi-asr.org/doc/)
- [OpenFST](https://www.openfst.org/)

## Contributing

Found an issue? Open a [GitHub Issue](https://github.com/KR4YIR/kaldi-arm-prebuilt/issues).
