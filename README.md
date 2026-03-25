# Kaldi Pre-compiled Binaries for ARM aarch64 (Raspberry Pi)

Bu repozitör, **Raspberry Pi 4/5 ve diğer ARM aarch64 cihazları** için önceden derlenmiş Kaldi binary'lerini içerir.

## 📋 Sistem Gereksinimleri

- **Mimari:** ARM aarch64 (64-bit)
- **İşletim Sistemi:** Linux (Raspberry Pi OS, Ubuntu ARM64, vb.)
- **Bellekek:** 2GB minimum (4GB+ önerilir)
- **Depolama:** 500MB+ boş alan

### Bağımlı Kütüphaneler

```bash
# Debian/Ubuntu/Raspberry Pi OS
sudo apt-get install -y \
    libblas-dev \
    liblapack-dev \
    liblapack3 \
    libopenblas-dev \
    libopenblas0

# Fedora
sudo dnf install -y \
    blas-devel \
    lapack-devel \
    openblas-devel
```

## 🚀 Kurulum

### 1. Binary'leri İndir

```bash
# GitHub'dan klon et
git clone https://github.com/SENIN_KULLANICI_ADI/kaldi-arm-prebuilt.git
cd kaldi-arm-prebuilt

# VEYA direkt download et
wget https://github.com/SENIN_KULLANICI_ADI/kaldi-arm-prebuilt/archive/refs/heads/main.zip
unzip main.zip
```

### 2. Kurulum Dosyasını Çalıştır

```bash
# Binary'leri PATH'e ekle
sudo cp -r bin/* /usr/local/bin/
sudo cp lib/* /usr/local/lib/

# Kütüphanelerin bulunabilmesi için
sudo ldconfig
```

### 3. Test Et

```bash
# Binary'nin çalışıp çalışmadığını kontrol et
compute-mfcc-feats --help

# Başarılı olduğunda çıktı göreceksin
```

## 📦 Dosya Yapısı

```
kaldi-arm-prebuilt/
├── bin/                    # Tüm Kaldi binary'leri (120+)
├── lib/                    # Kütüphaneler (.so, .a dosyaları)
├── docs/                   # Dokümantasyon
└── README.md              # Bu dosya
```

### Kullanılabilir Binary'ler

- `compute-mfcc-feats` - MFCC özniteliklerini hesapla
- `compute-deltas` - Delta ve delta-deltas hesapla
- `align-*` - Ses dosyalarını dizine hizala
- `gmm-*` - GMM ile işlemleri yap
- `ivector-*` - i-vector çıkarımı
- ... ve 100+ diğer araçlar

## 💡 Kullanım Örnekleri

### Örnek 1: MFCC Öznitelikleri Hesapla

```bash
compute-mfcc-feats --use-energy=false \
  scp:input.scp ark:output.ark
```

### Örnek 2: Ses Dosyalarını Hizala

```bash
align-equal-boost \
  --beam=10 --retry-beam=20 \
  data/lang/topo ark:transitions.ark \
  "ark:compute-mfcc-feats..." \
  ark:alignments.ark
```

## 📝 Lisans

Bu proje **Apache License 2.0** altında dağıtılır.
Kaldi hakkında daha fazla bilgi: https://kaldi-asr.org/

## 🔗 Kaynaklar

- **Kaldi Resmi Sitesi:** https://kaldi-asr.org/
- **GitHub:** https://github.com/kaldi-asr/kaldi
- **Dokümantasyon:** https://kaldi-asr.org/doc/

## ⚠️ Uyarılar

- Bu binary'ler **aarch64 mimarisine** özeldir
- Başka ARM sürümleri (armhf, arm32) ile uyumlu **DEĞİL**
- Kütüphaneleri sisteminize kurmadan binary'ler çalışmayabilir

## 📞 İletişim ve Destek

Sorunlarınız varsa:
- GitHub Issues açın
- Kaldi yazılım grubuna yazın
- Raspberry Pi forumlarını kontrol edin

---

**Derlenme Tarihi:** Kasım 2024  
**Kaldi Versiyonu:** v5.5 (aarch64)  
**Test Edildi:** Raspberry Pi 4 Model B, 8GB RAM
