class Minkms < Formula
  git_tag = "RELEASE.2026-09-16T11-16-36Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "aa374362168fb0ad7a2626d632bb14d4a3f43b18a5ef85c76cb6ed2cca3e20a2"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "b7e340b9be2b76ae849124d3ca9cb6ccd3ab2ffbe015b8476a4d9a73c9308398"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "7a335aee1195ccc0092235d6095cd10874dc3ac6de9d31f0d000116c808fa343"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "5a3d1af4f1a197214ffc076b78d880ec98ad603e54f51042639fcdee8b45a48b"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
