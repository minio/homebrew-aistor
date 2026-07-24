class Minkms < Formula
  git_tag = "RELEASE.2026-07-17T11-53-00Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "58cda7aa25f720ccc7c705512f8ad406f1a82f995c0ac6f35e4d56d803c2784f"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "23354de0d703628ac896ab0142dd18930f2cd2e335bee2ee2508a1481c8886a6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "022730eaf1d9a0bd538023ce52076e7531debe02d533fee78f420bf2d7c78ce7"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "2a2f71c7b16c94dcf7937b3c790dc681714fb0d2d9cfc295e1bc829860969bf2"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
