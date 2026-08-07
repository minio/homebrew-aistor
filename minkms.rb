class Minkms < Formula
  git_tag = "RELEASE.2026-08-04T13-17-26Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "4f5add00befed230a3391dac226b1783738b11a2553b8b43153664eb61ae858f"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "fd5d33f188c5b503793204c800b2208145f32fff3ec6864c22a7fd19e91e41fe"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "5b8ab4c6340c1301e60dc16a1566538ab3e95fb33451023aa5a0c319de6a5d02"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "f8b3ce1f5e2fa42672bc89ef8eb79852acc28a9012e665d1fc59ea24823684b0"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
