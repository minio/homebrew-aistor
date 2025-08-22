class Minkms < Formula
  git_tag = "RELEASE.2025-08-21T08-20-29Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "49a4b0dfe5b5928034b8c7ed4e707c77560c9bafbdad2d1191ee48a411f745d0"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "6c28b947962986c238b45af05a331d8221b1cd0b36e64c4b44d1b3afdd5139af"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "56b549df0055a34b96b6f1c264c73269aefea57019b53577a3f824a61943a0c1"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "bfe608fc012534d66944dcea3ec7c385a03133ee13c342530f0e1d96eba4904b"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
